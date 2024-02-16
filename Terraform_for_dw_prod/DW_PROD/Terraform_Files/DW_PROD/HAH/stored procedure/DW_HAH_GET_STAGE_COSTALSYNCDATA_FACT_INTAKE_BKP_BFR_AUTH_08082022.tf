resource "snowflake_procedure" "DW_HAH_GET_STAGE_COSTALSYNCDATA_FACT_INTAKE_BKP_BFR_AUTH_08082022" {
	name ="GET_STAGE_COSTALSYNCDATA_FACT_INTAKE_BKP_BFR_AUTH_08082022"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "JAVASCRIPT"

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

        var sql = `
    --*****************************************************************************************************************************
-- NAME:  CostalSyncData_FACT_INTAKE
--
-- PURPOSE: Creates one row per INTAKE according to CoastalSnyc (combination of SHC_ALTRUS and SHC_SAVANNAH)
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 01/06/20     Greg Marsh           Initial development
-- 04/01/20		Mohd Kamaludin		 Added CDC
-- 04/03/20		Mohd Kamaludin		 Fixed duplicate Intake Key
-- 05/19/20		Arif Ansari			Include Bill Rate logic. 
-- 05/20/20		Mir Ali				 Updated to use first day of the month for Report_Date, not last day (for consistency with other systems)
-- 07/09/20		Mir Ali				 Update to use raw CV tables (instead of CV_MonthlyHours)
-- 02/18/22		Paras Bhavnani		 Replace the dim_client with dedupe client table
-- 03/09/22		Mir Ali				 Added cutover dates for transitioning from Coastal to Alayacare (Georgia)
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.CostalSyncData_FACT_INTAKE
WITH CHANGED_DATA AS (
SELECT DB, ADMISSION_NUMBER 
FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_ADMISSIONS T
WHERE T.ETL_LAST_UPDATED_DATE >= ''`; 
sql += STR_CDC_START
sql += `''::timestamp_ntz
	UNION
	SELECT DB, ADMISSION_NUMBER 
	FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_DISCIPLINES T
	WHERE T.ETL_LAST_UPDATED_DATE >= ''`; 
sql += STR_CDC_START
sql += `''::timestamp_ntz
	UNION
	SELECT DB, ADMISSION_NUMBER 
	FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_DISCIPLINEFREQUENCIES T
	WHERE T.ETL_LAST_UPDATED_DATE >= ''`; 
sql += STR_CDC_START
sql += `''::timestamp_ntz
)
-- We need build correct admission discharge date, in case there are morethan 1 admission for a patient. 
-- Admission with correct discharge date, will be consider that but for those where discharge date is ''1900-01-01''. 
-- Discharge date will be (Admit date -1 ) of next admit date. In case there no next admission for that patient then Discharge date will be current date.
-- E.g. 
-- Name			AdmissionNum 	AdmitDate 	DischargeDate 	DerivedDischargeDate
-- Patient1 	0001111			2010-01-01	1900-01-01		2010-03-20		
-- Patient1 	0001112			2010-03-21	1900-01-01		2010-07-10
-- Patient1 	0001113			2010-07-11	1900-01-01		GETDATE()
-- Patient2 	0001115			2010-05-11	1900-01-01		GETDATE()
,ADMISSIONS
AS 
(
SELECT 
	ADMISSIONS.DB
	,ADMISSIONS.PATIENT_NUMBER
	,ADMISSIONS.ADMISSION_NUMBER
	,ADMISSIONS.LOCATION_CODE
	,ADMISSIONS.CURRENT_PLAN_CODE AS PLAN_CODE
	,ADMISSIONS.ADMIT_DATE
	,CASE 
		WHEN ADMISSIONS.DISCHARGE_DATE  = ''1900-01-01 00:00:00'' THEN CAST(GETDATE() AS DATE) 
		ELSE ADMISSIONS.DISCHARGE_DATE 
	END AS DISCHARGE_DATE 
FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_ADMISSIONS ADMISSIONS
JOIN CHANGED_DATA CHANGES
	ON CHANGES.DB = ADMISSIONS.DB AND CHANGES.ADMISSION_NUMBER = ADMISSIONS.ADMISSION_NUMBER 
WHERE TRIM(NVL(ADMISSIONS.CURRENT_PLAN_CODE, '''')) <> ''''
) 
, AUTHORIZATION_BY_DAY AS (
	SELECT DATA.DB, DATA.ADMISSION_NUMBER, DATA.CALENDAR_DATE, DATA.PATIENT_NUMBER ,
	DISCIPLINE_CODE,
		CASE DATA.DDL_UNITS_FREQ_TYPE -- Frequency: x hours every day vs every week, etc.
			WHEN 1 THEN DATA.FREQUENCY_UNITS_ARR2_2 -- Frequency_Units_Arr2_2 hours EVERY DAY for LengthValue days/weeks
			WHEN 2 THEN DATA.FREQUENCY_UNITS_ARR2_2 / 7.0 -- Frequency_Units_Arr2_2 hours EVERY WEEK for LengthValue days/weeks
			WHEN 3 THEN DATA.FREQUENCY_UNITS_ARR2_2 / DATA.NUMBER_OF_DAYS_IN_MONTH -- Frequency_Units_Arr2_2 hours EVERY MONTH for LengthValue days/weeks
			WHEN 4 THEN COALESCE(
				NULLIF(DATA.AGREEMENT_LENGTH_CALCULATED, 0), 
				DATA.FREQUENCY_UNITS_ARR2_2 / DATA.AGREEMENT_LENGTH_CALCULATED) -- Frequency_Units_Arr2_2 hours EVERY PRN for LengthValue days/weeks
			WHEN 5 THEN NULL -- Frequency_Units_Arr2_2 hours EVERY NONE for LengthValue days/weeks				
			ELSE NULL END AS AUTH_LIMIT_PER_DAY,
		DATA.REAUTH_DATE
	FROM (
		SELECT DISTINCT CHANGES.DB, CHANGES.ADMISSION_NUMBER,  DISCIPLINES.PATIENT_NUMBER ,
			DATE.CALENDAR_DATE,
			DAY(DATE.LAST_DAY_OF_MONTH) AS NUMBER_OF_DAYS_IN_MONTH,
			DISCIPLINES.DISCIPLINE_CODE,
			FIRST_VALUE(FREQUENCIES.DDL_VISITS_DURATION_TYPE) OVER (PARTITION BY CHANGES.DB, CHANGES.ADMISSION_NUMBER, DATE.CALENDAR_DATE,DISCIPLINES.DISCIPLINE_CODE  ORDER BY DISCIPLINES.CERT_TRAN_NUMBER DESC, FREQUENCIES.DISCIPLINE_ORDER_NUMBER DESC) AS DDL_VISITS_DURATION_TYPE,
			FIRST_VALUE(FREQUENCIES.FREQUENCY_UNITS_ARR2_2) OVER (PARTITION BY CHANGES.DB, CHANGES.ADMISSION_NUMBER, DATE.CALENDAR_DATE, DISCIPLINES.DISCIPLINE_CODE ORDER BY DISCIPLINES.CERT_TRAN_NUMBER DESC, FREQUENCIES.DISCIPLINE_ORDER_NUMBER DESC) AS FREQUENCY_UNITS_ARR2_2,
			FIRST_VALUE(FREQUENCIES.DDL_UNITS_FREQ_TYPE) OVER (PARTITION BY CHANGES.DB, CHANGES.ADMISSION_NUMBER, DATE.CALENDAR_DATE,DISCIPLINES.DISCIPLINE_CODE ORDER BY DISCIPLINES.CERT_TRAN_NUMBER DESC, FREQUENCIES.DISCIPLINE_ORDER_NUMBER DESC) AS DDL_UNITS_FREQ_TYPE,
			FIRST_VALUE(DATEDIFF(DAY, DISCIPLINES.STATRT_DATE, DISCIPLINES.END__DATE) + 1) OVER (PARTITION BY CHANGES.DB, CHANGES.ADMISSION_NUMBER, DATE.CALENDAR_DATE,DISCIPLINES.DISCIPLINE_CODE ORDER BY DISCIPLINES.CERT_TRAN_NUMBER DESC, FREQUENCIES.DISCIPLINE_ORDER_NUMBER DESC) AS AGREEMENT_LENGTH_CALCULATED,
			MAX(DISCIPLINES.STATRT_DATE) OVER(PARTITION BY CHANGES.DB, CHANGES.ADMISSION_NUMBER, DATE.FIRST_DAY_OF_MONTH) AS REAUTH_DATE
		FROM CHANGED_DATA CHANGES
		JOIN DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_DISCIPLINES DISCIPLINES
			ON DISCIPLINES.DB = CHANGES.DB AND DISCIPLINES.ADMISSION_NUMBER = CHANGES.ADMISSION_NUMBER
		JOIN HAH.DIM_DATE AS DATE ON DATE.CALENDAR_DATE BETWEEN DISCIPLINES.STATRT_DATE AND DISCIPLINES.END__DATE 
		JOIN DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_DISCIPLINEFREQUENCIES FREQUENCIES
			ON FREQUENCIES.DB = DISCIPLINES.DB AND FREQUENCIES.ADMISSION_NUMBER = DISCIPLINES.ADMISSION_NUMBER 
				AND FREQUENCIES.CERT_TRAN_NUMBER = DISCIPLINES.CERT_TRAN_NUMBER 
				AND FREQUENCIES.SEQUENCE_NUMBER = DISCIPLINES.SEQUENCE_NUMBER 
				AND FREQUENCIES.DISCIPLINE_SEQUENCE  = DISCIPLINES.DISCIPLINE_SEQUENCE
				AND FREQUENCIES.DISCIPLINE_ORDER_NUMBER = DISCIPLINES.DISCIPLINE_ORDER_NUMBER
		WHERE NULLIF(DISCIPLINES.STATRT_DATE, ''1900-01-01'') IS NOT NULL AND NULLIF(DISCIPLINES.END__DATE, ''1900-01-01'') IS NOT NULL
			AND DISCIPLINES.DDL_DISCIPLINE_TYPE = 2 -- Only select authorizations that limit by number of hours, not visits
			AND NVL(FREQUENCIES.FREQUENCY_UNITS_ARR2_2, 0) > 0
	) DATA
) 
, ADMISSION_AUTHORIZATION_DATES AS ( -- Used to determine applicable authorization date from CTE AUTHORIZATION_BY_DAY (for possible missing authorization dates between Admissions.Admit_Date and Admissions.Discharge_Date
	SELECT DISTINCT CASE ADMISSIONS.DB WHEN ''SHC_ALTRUS'' THEN 1 WHEN ''SHC_SAVANNAH'' THEN 2 END AS SOURCE_SYSTEM_ID,
		ADMISSIONS.DB,
		ADMISSIONS.PATIENT_NUMBER,
		ADMISSIONS.ADMISSION_NUMBER,
		ADMISSIONS.PLAN_CODE,
		ADMISSIONS.LOCATION_CODE,
		ADMISSIONS.ADMIT_DATE,
		ADMISSIONS.DISCHARGE_DATE,
		ADMISSION_DATES.FIRST_DAY_OF_MONTH AS REPORT_DATE,
		ADMISSION_DATES."YEAR" AS SERVICE_YEAR,
		ADMISSION_DATES."MONTH" AS SERVICE_MONTH,
		ADMISSION_DATES.CALENDAR_DATE AS ADMISSION_CALENDAR_DATE,
		AUTHORIZATION_DATES.CALENDAR_DATE AS AUTHORIZATION_CALENDAR_DATE,
		MAX(AUTHORIZATION_DATES.CALENDAR_DATE) 
			OVER(PARTITION BY ADMISSIONS.DB, ADMISSIONS.ADMISSION_NUMBER--, ADMISSION_DATES.FIRST_DAY_OF_MONTH 
				ORDER BY ADMISSION_DATES.CALENDAR_DATE
				ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS PAST_AUTHORIZATION_DATE, 
		MIN(AUTHORIZATION_DATES.CALENDAR_DATE) 
			OVER(PARTITION BY ADMISSIONS.DB, ADMISSIONS.ADMISSION_NUMBER--, ADMISSION_DATES.FIRST_DAY_OF_MONTH 
				ORDER BY ADMISSION_DATES.CALENDAR_DATE
				ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS FUTURE_AUTHORIZATION_DATE, 
		MAX(AUTHORIZATION_DATES.REAUTH_DATE) OVER(PARTITION BY ADMISSIONS.DB
		,ADMISSIONS.ADMISSION_NUMBER ORDER BY ADMISSION_DATES.FIRST_DAY_OF_MONTH RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS REAUTH_DATE
	FROM ADMISSIONS AS ADMISSIONS
	JOIN HAH.DIM_DATE AS ADMISSION_DATES 
		ON ADMISSION_DATES.CALENDAR_DATE BETWEEN ADMISSIONS.ADMIT_DATE AND ADMISSIONS.DISCHARGE_DATE
	LEFT JOIN AUTHORIZATION_BY_DAY AS AUTHORIZATION_DATES 
		ON AUTHORIZATION_DATES.DB = ADMISSIONS.DB AND AUTHORIZATION_DATES.ADMISSION_NUMBER = ADMISSIONS.ADMISSION_NUMBER
			AND AUTHORIZATION_DATES.CALENDAR_DATE = ADMISSION_DATES.CALENDAR_DATE
)
-- Arif Test
-- We have derived new PAST_AUTHORIZATION_DATE_1 and PAST_AUTHORIZATION_DATE_2 date for some specific scenario.
-- AdmissionNumer		DISC	AdmitDate		StartDate		EndDate								
-- 00001111				01		2019-01-01		2019-03-01		2019-05-25 	
-- 00001111				02		2019-01-01		2019-05-26		2019-06-15 	
-- 00001111				03		2019-01-01		2019-08-01		2019-11-25

-- AdmissionNumer		DISC	AdmitDate	Admission_date	FIRST_DAY_OF_MONTH	PAST_AUTHORIZATION_DATE		FUTURE_AUTHORIZATION_DATE	PAST_AUTHORIZATION_DATE_1	PAST_AUTHORIZATION_DATE_2									
-- 00001111				01		2019-01-01	2019-01-04		2019-01-01			NULL						NULL						NULL						2019-03-01
-- 00001111				01		2019-01-01	2019-03-06		2019-03-01			2019-03-01					2019-03-31					2019-03-01					2019-08-01
-- 00001111				01		2019-01-01	2019-05-27		2019-05-01			2019-05-26					2019-05-31					2019-03-01					2019-08-01
-- 00001111				01		2019-01-01	2019-07-08		2019-07-01			NULL						NULL						2019-05-26					2019-08-01
-- 00001111				01		2019-01-01	2019-08-10		2019-08-01			2019-08-01					2019-08-31								
, AUTHORIZATIONS_BY_ADMISSIONS AS (
	SELECT AUTHORIZATION_DATES.SOURCE_SYSTEM_ID,
		AUTHORIZATION_DATES.DB,
		AUTHORIZATION_DATES.REPORT_DATE,
		AUTHORIZATION_DATES.SERVICE_YEAR,
		AUTHORIZATION_DATES.SERVICE_MONTH,
		AUTHORIZATION_DATES.PATIENT_NUMBER, 
		AUTHORIZATION_DATES.PLAN_CODE, 
		AUTHORIZATION_DATES.LOCATION_CODE,
		COALESCE(AUTHORIZATION_DATES.REAUTH_DATE, AUTHORIZATION_DATES.REPORT_DATE) AS REAUTH_DATE,
		AUTHORIZATION_BY_DAY.AUTH_LIMIT_PER_DAY
	FROM ADMISSION_AUTHORIZATION_DATES AUTHORIZATION_DATES
	LEFT JOIN AUTHORIZATION_BY_DAY AUTHORIZATION_BY_DAY
		ON AUTHORIZATION_BY_DAY.DB = AUTHORIZATION_DATES.DB AND AUTHORIZATION_BY_DAY.ADMISSION_NUMBER = AUTHORIZATION_DATES.ADMISSION_NUMBER
			AND AUTHORIZATION_BY_DAY.CALENDAR_DATE = COALESCE(AUTHORIZATION_DATES.PAST_AUTHORIZATION_DATE, AUTHORIZATION_DATES.FUTURE_AUTHORIZATION_DATE)
)
, CLIENT_DATA AS
(
	SELECT * FROM
	(
		
		SELECT TRIM(DB) AS MASTER_DB, TRIM(PATIENT_NUMBER) AS MASTER_PATIENT_NUMBER, TRIM(DB) AS DB, TRIM(PATIENT_NUMBER) AS PATIENT_NUMBER
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CLIENT_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		    SELECT DISTINCT TRIM(MASTER.DB) AS MASTER_DB,TRIM(MASTER.PATIENT_NUMBER) AS MASTER_PATIENT_NUMBER,  TRIM(MATCH.DB) AS DB, TRIM(MATCH.PATIENT_NUMBER) AS PATIENT_NUMBER
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CLIENT_MATCH_LIST AS MATCH
        JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CLIENT_MASTER_LIST AS MASTER 
        ON MASTER.MASTER_ID = MATCH.MASTER_ID
       	WHERE MATCH.ID <> MATCH.MASTER_ID
       	
	)
) 
, AUTHORIZATIONS AS (
	SELECT AUTHORIZATION_DATES.SOURCE_SYSTEM_ID,
		TRIM(AUTHORIZATION_DATES.DB) AS SYSTEM_CODE,
		AUTHORIZATION_DATES.REPORT_DATE,
		AUTHORIZATION_DATES.SERVICE_YEAR,
		AUTHORIZATION_DATES.SERVICE_MONTH,
		coalesce(TRIM(CLIENTS.MASTER_PATIENT_NUMBER),NVL(TRY_CAST(AUTHORIZATION_DATES.PATIENT_NUMBER AS INTEGER), -1)::STRING) AS CLIENT_NUMBER,  
		coalesce(md5(CLIENTS.MASTER_DB || ''-'' || CLIENTS.MASTER_PATIENT_NUMBER || ''-''  ||  ''COSTALSYNCDATA''), md5(AUTHORIZATION_DATES.DB || ''-'' || NVL(TRY_CAST(AUTHORIZATION_DATES.PATIENT_NUMBER AS INTEGER), -1)::STRING || ''-'' || ''COSTALSYNCDATA'')) AS CLIENT_KEY,
		TRIM(AUTHORIZATION_DATES.PLAN_CODE) AS CONTRACT_CODE, 
		COALESCE(CONTRACTS.CONTRACT_KEY, MD5(TRIM(AUTHORIZATION_DATES.DB) || ''-'' || TRIM(AUTHORIZATION_DATES.PLAN_CODE) || ''-'' || ''COSTALSYNCDATA'')) AS CONTRACT_KEY,
		TRIM(AUTHORIZATION_DATES.LOCATION_CODE) AS LOCATION_CODE,
		COALESCE(BRANCHES.BRANCH_NAME, TRIM(UPPER(LOCATIONS.LOCATION_NAME)), ''Unknown'') AS BRANCH_NAME,
		COALESCE(BRANCHES.BRANCH_KEY, MD5(TRIM(AUTHORIZATION_DATES.DB) || ''-'' || AUTHORIZATION_DATES.LOCATION_CODE || ''-'' || ''COSTALSYNCDATA'')) AS BRANCH_KEY,
		MAX(COALESCE(AUTHORIZATION_DATES.REAUTH_DATE, AUTHORIZATION_DATES.REPORT_DATE)) AS REAUTH_DATE,
		SUM(AUTHORIZATION_DATES.AUTH_LIMIT_PER_DAY) AS HOURS_AUTHORIZED
	FROM AUTHORIZATIONS_BY_ADMISSIONS AS AUTHORIZATION_DATES
	LEFT JOIN CLIENT_DATA AS CLIENTS
		ON TRIM(CLIENTS.DB) = TRIM(AUTHORIZATION_DATES.DB) AND CLIENTS.PATIENT_NUMBER::STRING = TRIM(AUTHORIZATION_DATES.PATIENT_NUMBER)
	LEFT JOIN HAH.DIM_CONTRACT AS CONTRACTS
		ON CONTRACTS.SOURCE_SYSTEM_ID = AUTHORIZATION_DATES.SOURCE_SYSTEM_ID AND CONTRACTS.CONTRACT_CODE = TRIM(AUTHORIZATION_DATES.PLAN_CODE)
	LEFT JOIN (
		SELECT DISTINCT SOURCE_SYSTEM_ID, DB, PATIENT_NUMBER, PLAN_CODE, REPORT_DATE, FIRST_VALUE(LOCATION_CODE) OVER(PARTITION BY SOURCE_SYSTEM_ID, DB, PATIENT_NUMBER, PLAN_CODE, REPORT_DATE ORDER BY SUM(AUTH_LIMIT_PER_DAY) DESC, MAX(REAUTH_DATE) DESC) AS LOCATION_CODE
		FROM AUTHORIZATIONS_BY_ADMISSIONS
		GROUP BY SOURCE_SYSTEM_ID, DB, PATIENT_NUMBER, PLAN_CODE, REPORT_DATE, LOCATION_CODE
	) ADMISSION_LOCATIONS
		ON ADMISSION_LOCATIONS.DB = AUTHORIZATION_DATES.DB AND ADMISSION_LOCATIONS.PATIENT_NUMBER = AUTHORIZATION_DATES.PATIENT_NUMBER AND ADMISSION_LOCATIONS.PLAN_CODE = AUTHORIZATION_DATES.PLAN_CODE AND ADMISSION_LOCATIONS.REPORT_DATE = AUTHORIZATION_DATES.REPORT_DATE
	LEFT JOIN HAH.DIM_BRANCH AS BRANCHES
		ON BRANCHES.SOURCE_SYSTEM_ID = ADMISSION_LOCATIONS.SOURCE_SYSTEM_ID AND BRANCHES.OFFICE_CODE = TRIM(ADMISSION_LOCATIONS.LOCATION_CODE)
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_LOCATIONS AS LOCATIONS
		ON LOCATIONS.DB = ADMISSION_LOCATIONS.DB AND LOCATIONS.LOCATION_CODE = ADMISSION_LOCATIONS.LOCATION_CODE
	GROUP BY AUTHORIZATION_DATES.SOURCE_SYSTEM_ID,
		TRIM(AUTHORIZATION_DATES.DB),
		AUTHORIZATION_DATES.REPORT_DATE,
		AUTHORIZATION_DATES.SERVICE_YEAR,
		AUTHORIZATION_DATES.SERVICE_MONTH,
		coalesce(TRIM(CLIENTS.MASTER_PATIENT_NUMBER),NVL(TRY_CAST(AUTHORIZATION_DATES.PATIENT_NUMBER AS INTEGER), -1)::STRING), 
		coalesce(md5(CLIENTS.MASTER_DB || ''-'' || CLIENTS.MASTER_PATIENT_NUMBER || ''-''  ||  ''COSTALSYNCDATA''), md5(AUTHORIZATION_DATES.DB || ''-'' || NVL(TRY_CAST(AUTHORIZATION_DATES.PATIENT_NUMBER AS INTEGER), -1)::STRING || ''-'' || ''COSTALSYNCDATA'')),
		TRIM(AUTHORIZATION_DATES.PLAN_CODE), 
		COALESCE(CONTRACTS.CONTRACT_KEY, MD5(TRIM(AUTHORIZATION_DATES.DB) || ''-'' || TRIM(AUTHORIZATION_DATES.PLAN_CODE) || ''-'' || ''COSTALSYNCDATA'')),
		TRIM(AUTHORIZATION_DATES.LOCATION_CODE),
		COALESCE(BRANCHES.BRANCH_NAME, TRIM(UPPER(LOCATIONS.LOCATION_NAME)), ''Unknown''),
		COALESCE(BRANCHES.BRANCH_KEY, MD5(TRIM(AUTHORIZATION_DATES.DB) || ''-'' || AUTHORIZATION_DATES.LOCATION_CODE || ''-'' || ''COSTALSYNCDATA''))
), AUTHORIZATIONS_WITH_PLAN_RATES AS (
	SELECT AUTHORIZATIONS.*,
		COALESCE(PATIENT_PLAN_RATES.AVERAGE_BILL_RATE, PLAN_RATES.AVERAGE_BILL_RATE) * 
			CASE WHEN CONTRACTS.BILLED_BY_QUARTER_HOURS = TRUE THEN 4
				WHEN CONTRACTS.BILLED_BY_HALF_HOURS = TRUE THEN 2
				ELSE 1 END
			AS AVERAGE_BILL_RATE,
		NVL(CUTOVER.START_DATE, DATE_TRUNC(MONTH, AUTHORIZATIONS.REPORT_DATE)) AS START_DATE_ONLY_CUTOVER,
		NVL(CUTOVER.END_DATE, LAST_DAY(AUTHORIZATIONS.REPORT_DATE)) AS END_DATE_ONLY_CUTOVER,
		IFF(START_DATE_ONLY_CUTOVER > DATE_TRUNC(MONTH, AUTHORIZATIONS.REPORT_DATE), START_DATE_ONLY_CUTOVER, DATE_TRUNC(MONTH, AUTHORIZATIONS.REPORT_DATE)) AS START_DATE_WITH_CUTOVER,
		IFF(END_DATE_ONLY_CUTOVER < LAST_DAY(AUTHORIZATIONS.REPORT_DATE), END_DATE_ONLY_CUTOVER, LAST_DAY(AUTHORIZATIONS.REPORT_DATE)) AS END_DATE_WITH_CUTOVER
	FROM AUTHORIZATIONS AUTHORIZATIONS
	LEFT JOIN HAH.DIM_CONTRACT CONTRACTS
		ON CONTRACTS.CONTRACT_KEY = AUTHORIZATIONS.CONTRACT_KEY
	LEFT JOIN (
		SELECT DB, PLAN_CODE, AVG(CHARGE_AMOUNT) AVERAGE_BILL_RATE
		FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_PLANRATEDETAILS
		WHERE CHARGE_AMOUNT > 0
		GROUP BY DB, PLAN_CODE
	) PLAN_RATES
		ON TRIM(PLAN_RATES.DB) = AUTHORIZATIONS.SYSTEM_CODE AND TRIM(PLAN_RATES.PLAN_CODE) = AUTHORIZATIONS.CONTRACT_CODE
	LEFT JOIN (
		SELECT DB, PLAN_CODE, PATIENT_NUMBER, AVG(CHARGE_AMOUNT82) AVERAGE_BILL_RATE
		FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_PATIENTPLANRATEDETAILS 
		WHERE CHARGE_AMOUNT82 > 0
		GROUP BY DB, PLAN_CODE, PATIENT_NUMBER 
	) PATIENT_PLAN_RATES
		ON TRIM(PATIENT_PLAN_RATES.DB) = AUTHORIZATIONS.SYSTEM_CODE AND TRIM(PATIENT_PLAN_RATES.PLAN_CODE) = AUTHORIZATIONS.CONTRACT_CODE
			AND TRIM(PATIENT_PLAN_RATES.PATIENT_NUMBER) = AUTHORIZATIONS.CLIENT_NUMBER
	LEFT JOIN HAH.FACT_SYSTEM_CUTOVER_DATE AS CUTOVER
		ON CUTOVER.SOURCE_SYSTEM_ID = AUTHORIZATIONS.SOURCE_SYSTEM_ID 
			AND CUTOVER.SYSTEM_CODE = AUTHORIZATIONS.SYSTEM_CODE
			AND NVL(CUTOVER.BRANCH_KEY, AUTHORIZATIONS.BRANCH_KEY) = AUTHORIZATIONS.BRANCH_KEY
			AND NVL(CUTOVER.CONTRACT_KEY, AUTHORIZATIONS.CONTRACT_KEY) = AUTHORIZATIONS.CONTRACT_KEY
)
	SELECT MD5(AUTHORIZATIONS.SERVICE_YEAR || ''-'' || 
			AUTHORIZATIONS.SERVICE_MONTH || ''-'' || 
			AUTHORIZATIONS.CLIENT_NUMBER || ''-'' || 
			AUTHORIZATIONS.CONTRACT_CODE || ''-'' || 
			AUTHORIZATIONS.BRANCH_NAME || ''-'' || 
			AUTHORIZATIONS.SYSTEM_CODE || ''-'' || AUTHORIZATIONS.LOCATION_CODE || ''-'' || ''COSTALSYNCDATA'') AS INTAKE_KEY,
		AUTHORIZATIONS.REPORT_DATE,
		AUTHORIZATIONS.BRANCH_KEY,
		AUTHORIZATIONS.CLIENT_KEY,
		AUTHORIZATIONS.CONTRACT_KEY,
		AUTHORIZATIONS.SOURCE_SYSTEM_ID,
		AUTHORIZATIONS.REAUTH_DATE AS REAUTHORIZED_DATE,
		AUTHORIZATIONS.BRANCH_NAME,
		AUTHORIZATIONS.CLIENT_NUMBER,
		AUTHORIZATIONS.CONTRACT_CODE,
		AUTHORIZATIONS.AVERAGE_BILL_RATE AS BILL_RATE, 
		AUTHORIZATIONS.SYSTEM_CODE,
		NULL AS CASE_MANAGER,
		AUTHORIZATIONS.HOURS_AUTHORIZED * CAST(
			(DATEDIFF(DAY, AUTHORIZATIONS.START_DATE_WITH_CUTOVER, AUTHORIZATIONS.END_DATE_WITH_CUTOVER) + 1)
			/ DAY(LAST_DAY(AUTHORIZATIONS.REPORT_DATE)) AS DECIMAL(12, 5)) AS HOURS_AUTHORIZED,
		AUTHORIZATIONS.HOURS_AUTHORIZED AS HOURS_AUTHORIZED_NON_ADJUSTED,
		-- ETL Fields
	    
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_TASK_KEY,
        
        
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_INSERTED_TASK_KEY,
        
        convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	    CURRENT_USER as ETL_INSERTED_BY ,
	    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	    CURRENT_USER as ETL_LAST_UPDATED_BY,
	    0 as ETL_DELETED_FLAG
	FROM AUTHORIZATIONS_WITH_PLAN_RATES AS AUTHORIZATIONS
	WHERE AUTHORIZATIONS.REPORT_DATE BETWEEN DATE_TRUNC(MONTH, AUTHORIZATIONS.START_DATE_WITH_CUTOVER) AND LAST_DAY(AUTHORIZATIONS.END_DATE_WITH_CUTOVER)
;    
`;
          try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                return "Succeeded.";   // Return a success/error indicator.
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                }  
          
 EOT
}

