resource "snowflake_procedure" "DW_HAH_GET_STAGE_PREFERRED_FACT_PAYROLL" {
	name ="GET_STAGE_PREFERRED_FACT_PAYROLL"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

                BEGIN
INSERT OVERWRITE INTO STAGE.PREFERRED_FACT_PAYROLL
WITH EMPLOYEE AS 
(
	SELECT * FROM
		(
			SELECT CAREGIVERID, MASTER_ID, AGENCYID, MD5(''PREFERRED'' || ''-'' || MASTER_ID || ''-'' || ''PREFERRED'') AS EMPLOYEE_KEY
			FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.EMPLOYEE_MASTER_LIST
		)
	UNION
	SELECT * FROM
		(
			SELECT DISTINCT CAREGIVERID, MASTER_ID, AGENCYID, MD5(''PREFERRED'' || ''-'' || MASTER_ID || ''-'' || ''PREFERRED'') AS EMPLOYEE_KEY
			FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.EMPLOYEE_MATCH_LIST
			WHERE CAREGIVERID NOT IN (SELECT CAREGIVERID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.EMPLOYEE_MASTER_LIST) 
	) 
), non_service_units as (
                      select batchid, caregiverid, SUM(regularhours) as regularhours, SUM(othours) as othours, SUM(holidayhours) as holidayhours, 
                                                   SUM(payamount) as payamount, SUM(otamount) as otamount, SUM(holidayamount) as holidayamount
                      from "DISC_${var.SF_ENVIRONMENT}"."HHAEXCHANGEPREFERRED"."PAYROLL_DETAILS_REPL"
                      where visitid = 0 and patientid = 0
                      GROUP BY batchid, caregiverid
                        )
-- recursive cte that creates a row for each date in the vacation dates range
, vacation_dates AS (SELECT CAREGIVERID,CAREGIVERABSENCETYPESID,STARTDATE,ENDDATE
                        FROM (SELECT * FROM "DISC_${var.SF_ENVIRONMENT}"."HHAEXCHANGEPREFERRED"."CAREGIVERVACATIONS_REPL")
                        UNION  ALL
                        SELECT CAREGIVERID
                              ,CAREGIVERABSENCETYPESID
                              ,DATEADD(day,1,STARTDATE)
                              ,ENDDATE
                        FROM vacation_dates
                        WHERE STARTDATE < ENDDATE)
-- filtering out vacations on weekends and holidays
, filtered_vacations AS (              
                      SELECT CAREGIVERID,CAREGIVERABSENCETYPESID,STARTDATE as VACATIONDATE
                      FROM vacation_dates v
                      LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE d on d.CALENDAR_DATE = v.STARTDATE
                      where WEEKEND_FLAG = ''FALSE'' and HOLIDAY_FLAG = ''FALSE''
                      ORDER BY 1,2 )
-- connecting to payroll weeks and filtering for vacations older than 30 days because payroll is slow
, vacation_payroll_weeks AS (
                      SELECT *
                      FROM filtered_vacations f
                      LEFT JOIN (SELECT DISTINCT FROMDATE,TODATE FROM "DISC_${var.SF_ENVIRONMENT}"."HHAEXCHANGEPREFERRED"."PAYROLL_WEEKS_REPL") w
                          on f.VACATIONDATE >= w.FROMDATE and f.VACATIONDATE <= w.TODATE
                      WHERE VACATIONDATE<DATEADD(day,-30,GETDATE())
                      ORDER BY VACATIONDATE DESC)
-- aggregating and assigning vacation categories
, vacation_week_category AS (
                      SELECT CAREGIVERID, ABSENCEGROUP,FROMDATE, TODATE, COUNT(*)*8 as Hours
                      FROM vacation_payroll_weeks vpw
                      LEFT JOIN "DW_${var.SF_ENVIRONMENT}"."STAGE"."PREFERRED_FACT_PAYROLL_ABSENCE_GROUP_MAPPING" agm on agm.CAREGIVERABSENCETYPESID = vpw.CAREGIVERABSENCETYPESID
                      GROUP BY 1,2,3,4)  
, AGENCY_OFFICES_INCLUDE AS
(
	SELECT CONFIG.AGENCYID, INCLUDE_ALL_OFFICES, GET(CONTRACT.VALUE, ''OFFICEID'')::STRING AS OFFICEID
	FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.AGENCY_MAPPING CONFIG
		, TABLE(FLATTEN(PARSE_JSON(CONFIG.OFFICES_TO_INCLUDE), OUTER => TRUE)) CONTRACT
	WHERE CONFIG.ISACTIVE = TRUE
), AGENCY_OFFICES_EXCLUDE AS
(
	SELECT CONFIG.AGENCYID, INCLUDE_ALL_OFFICES, GET(CONTRACT.VALUE, ''OFFICEID'')::STRING AS OFFICEID
	FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.AGENCY_MAPPING CONFIG
		, TABLE(FLATTEN(PARSE_JSON(CONFIG.OFFICES_TO_EXCLUDE), OUTER => TRUE)) CONTRACT
	WHERE CONFIG.ISACTIVE = TRUE
			AND CONFIG.OFFICES_TO_EXCLUDE IS NOT NULL
)
select MD5(prh.headerid || COALESCE(em.employee_key::STRING,prh.caregiverid::STRING,''-1'') || NVL(MD5(''PREFERRED'' || ''-'' || ''PREFERRED CORPORATE OFFICE'' || ''-'' || ''PREFERRED''),''-1'')) AS PAYROLL_KEY,
    DATEADD(d, 6, prh.weekend) as report_date,
    NVL(em.employee_key,MD5(prh.caregiverid)) AS employee_key,
    MD5(''PREFERRED'' || ''-'' || ''PREFERRED CORPORATE OFFICE'' || ''-'' || ''PREFERRED'') AS BRANCH_KEY,
    17 as source_system_id,
    DATEADD(d, 6, prh.weekend) as payroll_date,
    TO_NUMBER(DE.EMPLOYEE_ID) as employee_id,
    ''PREFERRED CORPORATE OFFICE'' AS branch_name,
    ''PREFERRED'' as system_code,
    prh.weekstart as PAY_PERIOD_START_DATE,
    prh.weekend as PAY_PERIOD_END_DATE,
    prh.headerid as check_number,
    nvl((prh.totalhours / 60), 0) + nvl((prh.totalothours / 60), 0) + nvl((prh.totalholidayhours / 60), 0) as pay_hours,
    nvl((prh.totalhours / 60), 0) + nvl((prh.totalothours / 60), 0) + nvl((prh.totalholidayhours / 60), 0) -  (nvl((nsu.regularhours / 60), 0) + nvl((nsu.othours / 60), 0) + nvl((nsu.holidayhours / 60), 0)) as service_hours,
    nvl(prh.totalothours / 60, 0) as overtime_hours,
    (nvl((nsu.regularhours / 60), 0) + nvl((nsu.othours / 60), 0) + nvl((nsu.holidayhours / 60), 0)) as non_service_units,
    nvl(sick.hours, 0) as sick_hours, --Need to map absence types
    nvl(vac.hours, 0) as vacation_hours, --Need to map absence types
    DIV0((nvl(prh.totalamount, 0) + nvl(prh.totalotamount, 0) + nvl(prh.totalholidayamount, 0)), (nvl((prh.totalhours / 60), 0) + nvl((prh.totalothours / 60), 0) + nvl((prh.totalholidayhours / 60), 0))) as pay_rate,
    DIV0(nvl(prh.totalotamount, 0), nvl((prh.totalothours / 60), 0)) as overtime_rate,
    (nvl(prh.totalamount, 0) + nvl(prh.totalotamount, 0) + nvl(prh.totalholidayamount, 0)) as GROSS_PAY_AMOUNT,
	(nvl(prh.totalamount, 0) + nvl(prh.totalotamount, 0) + nvl(prh.totalholidayamount, 0)) - (nvl(nsu.payamount, 0) + nvl(nsu.otamount, 0) + nvl(nsu.holidayamount, 0)) as SERVICE_PAY_AMOUNT,
	nvl(prh.totalotamount, 0) as OVERTIME_PAY_AMOUNT,
	(nvl(nsu.payamount, 0) + nvl(nsu.otamount, 0) + nvl(nsu.holidayamount, 0)) as NON_SERVICE_PAY_AMOUNT,
    -- .0725  for demo purposes only // NY has a progessive income tax // take income in a week multiply by 52 check which bracket that lands you in and use that tax rate
	-- Demo: .0725 * (prh.totalamount + prh.totalotamount + prh.totalholidayamount) as TAX_AMOUNT,
    NULL as TAX_AMOUNT,
    -- subtracting demo from net 
    -- (prh.totalamount + prh.totalotamount + prh.totalholidayamount) - (.0725 * (prh.totalamount + prh.totalotamount + prh.totalholidayamount)) - (.01 * (prh.totalamount + prh.totalotamount + prh.totalholidayamount)) as NET_PAY_AMOUNT,
	(nvl(prh.totalamount, 0) + nvl(prh.totalotamount, 0) + nvl(prh.totalholidayamount, 0))  as NET_PAY_AMOUNT,
	NULL as OTHER_DEDUCTIONS_AMOUNT, --Medical Deduction Code in Caregiver Table (All Empty)
    -- .01 for demo purposes only // theres only a union indicator not a union amount 
	-- CASE WHEN caregivers.UNIONREDUCTION = ''Y'' THEN .01 * (prh.totalamount + prh.totalotamount + prh.totalholidayamount) 
    -- ELSE NULL END AS UNION_DUES_AMOUNT, --Union Reduction Column in Caregiver Table (Y/N)
    NULL AS UNION_DUES_AMOUNT,
    --mileage amount is always null but leaving it in in case they start to use it
	nvl(prh.expenseamount, 0) + nvl(prh.mileageamount, 0) as REINBURSMENT_AMOUNT,
	-- ETL Fields
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
                        
  convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG
from "DISC_${var.SF_ENVIRONMENT}"."HHAEXCHANGEPREFERRED"."PAYROLL_HEADER_REPL" as prh
   	INNER JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.AGENCY_MAPPING AGENCY_CONFIG
	ON AGENCY_CONFIG.AGENCYID = prh.agencyid
		AND AGENCY_CONFIG.ISACTIVE = TRUE
INNER JOIN EMPLOYEE AS EM
	ON EM.CAREGIVERID = prh.caregiverid::String
INNER JOIN HAH.DIM_EMPLOYEE DE
	ON DE.EMPLOYEE_ID = EM.MASTER_ID
		AND DE.SYSTEM_CODE = ''PREFERRED''
left join non_service_units as nsu
    on nsu.caregiverid = prh.caregiverid and nsu.batchid = prh.batchid
left join DISC_${var.SF_ENVIRONMENT}.hhaexchangepreferred.caregivers caregivers
    on caregivers.caregiverid = prh.caregiverid
left join vacation_week_category sick 
    on sick.caregiverid = prh.caregiverid and sick.FROMDATE = prh.WEEKSTART and sick.TODATE = prh.WEEKEND and sick.ABSENCEGROUP=''Sick''
left join vacation_week_category vac 
    on vac.caregiverid = prh.caregiverid and vac.FROMDATE = prh.WEEKSTART and vac.TODATE = prh.WEEKEND and vac.ABSENCEGROUP=''Vacation''
LEFT JOIN AGENCY_OFFICES_INCLUDE OFFICES_I
	ON OFFICES_I.AGENCYID = prh.AGENCYID
LEFT JOIN AGENCY_OFFICES_EXCLUDE OFFICES_E
	ON OFFICES_E.AGENCYID = prh.AGENCYID 
		AND prh.OFFICEID = OFFICES_E.OFFICEID
WHERE (OFFICES_I.INCLUDE_ALL_OFFICES = TRUE OR prh.OFFICEID = OFFICES_I.OFFICEID)
 		AND OFFICES_E.OFFICEID IS NULL	
 
;
    RETURN ''SUCCESS'';
    END;
    
 EOT
}

