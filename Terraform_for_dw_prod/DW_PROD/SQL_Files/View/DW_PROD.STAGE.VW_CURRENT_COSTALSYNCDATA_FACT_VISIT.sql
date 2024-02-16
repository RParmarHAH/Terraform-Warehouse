create or replace view DW_PROD.STAGE.VW_CURRENT_COSTALSYNCDATA_FACT_VISIT(
	VISIT_KEY
) as 
WITH HOUR_UNIT_MAPPING AS (
	SELECT DB, PLAN_CODE, 
		MIN(TIME_TRANSLATION_CODE) AS TIME_TRANSLATION_CODE, 
		CASE LEFT(MIN(TIME_TRANSLATION_CODE), 2) WHEN '15' THEN 4 WHEN '30' THEN 2 ELSE 1 END MATH_FACTOR
	FROM DISC_PROD.COSTALSYNCDATA.CV_PLANTIMETRANSLATION
	WHERE TRIM(TIME_TRANSLATION_CODE) LIKE '%MIN'
	GROUP BY DB, PLAN_CODE 
)
,BILL_RATE
AS
(
 SELECT * FROM(select s.DB,s.Patient_number,s.plan_code,s.proccode,s.schedule_number,c.unit_amount AS AMOUNT,
					row_number() over (partition by s.db,s.schedule_number order by try_cast(c.bill_number as int) desc) as rn 
					FROM DISC_PROD.COSTALSYNCDATA.CV_SCHEDULES S 
					JOIN DISC_PROD.COSTALSYNCDATA.CV_CHARGES C ON S.SCHEDULE_NUMBER = C.SCHEDULE_NUMBER and s.db=c.db
					where TRIM(SCHEDULE_status_code) in ('B','BP','C','V','VB','VP','P')
					)WHERE RN=1
                    UNION ALL	
					select s.DB,s.Patient_number,s.plan_code,s.proccode,s.schedule_number,p.CHARGE_AMOUNT82 AS AMOUNT, null as rn from DISC_PROD.COSTALSYNCDATA.CV_SCHEDULES S
					left join (select distinct db,schedule_number from DISC_PROD.COSTALSYNCDATA.CV_CHARGES) C on S.SCHEDULE_NUMBER= C.SCHEDULE_NUMBER and s.db=c.db
					join DISC_PROD.COSTALSYNCDATA.CV_PATIENTPLANRATEDETAILS p on s.db=p.db and s.Patient_number= p.patient_number and s.Plan_code = p.plan_code and s.proccode = p.proccode
					where C.Schedule_number is NULL AND TRIM(s.SCHEDULE_status_code) in ('B','BP','C','V','VB','VP','P')
                    UNION ALL
					select s.DB,s.Patient_number,s.plan_code,s.proccode,s.schedule_number,R.CHARGE_AMOUNT AS AMOUNT, null as rn from DISC_PROD.COSTALSYNCDATA.CV_SCHEDULES S
					left join (select distinct db,schedule_number from DISC_PROD.COSTALSYNCDATA.CV_CHARGES) C on S.SCHEDULE_NUMBER= C.SCHEDULE_NUMBER and s.db=c.db
					LEFT join DISC_PROD.COSTALSYNCDATA.CV_PATIENTPLANRATEDETAILS p on s.Patient_number= p.patient_number and s.Plan_code = p.plan_code and s.proccode = p.proccode
					and s.db=p.db
		    		JOIN DISC_PROD.COSTALSYNCDATA.CV_PLANRATEDETAILS R ON s.Plan_code = R.plan_code and s.proccode = R.proccode and s.db= r.db
					where C.Schedule_number is NULL AND (P.PATIENT_NUMBER IS NULL OR P.PLAN_CODE IS NULL OR P.PROCCODE IS NULL)
					AND TRIM(s.SCHEDULE_status_code) in ('B','BP','C','V','VB','VP','P')
)
, VISITS
AS
(
	SELECT 
		s.Db
		,TRIM(s.Patient_Number) AS Patient_Number
		,TRIM(s.Plan_Code) AS Plan_Code
		,TRIM(s.ProcCode) AS ProcCode
		,s.Schedule_Number
		,s.Schedule_Date
		,TRIM(s.Nurse_ID) AS Nurse_ID
		,TRIM(s.Location_Code) AS Location_Code
		,TRIM(s.Location_Name) AS Location_Name
		,s.STATE_CODE
		,TRIM(s.Department__Code) AS Department__Code
		,TRIM(s.Department_Name) AS Department_Name
		,TRIM(s.Schedule_Status_Code) AS Schedule_Status_Code
		,TRIM(s.Schedule_Status_Desc) AS Schedule_Status_Desc
		,try_cast(LEFT(trim(s.Confirmed_Duration ),2) AS INTEGER) +try_cast(RIGHT(trim(s.Confirmed_Duration),2) AS INTEGER)/60 AS DurationInHours
		,um.TIME_TRANSLATION_CODE
		,COALESCE(um.MATH_FACTOR, 1) AS MATH_FACTOR
		,s.ETL_LAST_UPDATED_DATE 
	FROM DISC_PROD.COSTALSYNCDATA.CV_Schedules s 
	LEFT JOIN HOUR_UNIT_MAPPING um
	ON um.Plan_Code = s.Plan_Code
	AND um.Db = s.Db

)
, Visit_Agg
AS
(
	SELECT 	
		db							AS db
		,PATIENT_NUMBER				AS CLIENT_NUMBER
		,SCHEDULE_DATE				AS REPORT_DATE
		,SCHEDULE_DATE				AS SERVICE_DATE
		,Schedule_Number
		,LOCATION_CODE				AS OFFICECODE
		,LOCATION_NAME				AS OFFICENAME
		,NURSE_ID					AS EMPLOYEEID
		,DEPARTMENT__CODE			AS SUPERVISORCODE
		,DEPARTMENT_NAME			AS SUPERVISORNAME
		,PLAN_CODE					AS CONTRACT_CODE
		,CASE SCHEDULE_STATUS_CODE		
			WHEN 'B' THEN '04'
			WHEN 'BP' THEN '05'
			WHEN 'C' THEN '02'
			WHEN 'CC' THEN '01'
			WHEN 'DE' THEN '10'
			WHEN 'EC' THEN '10'
			WHEN 'EN' THEN '10'
			WHEN 'ER' THEN '01'
			WHEN 'HR' THEN '10'
			WHEN 'HS' THEN '09'
			WHEN 'M' THEN '01'
			WHEN 'ND' THEN '09'
			WHEN 'O' THEN '01'
			WHEN 'OH' THEN '09'
			WHEN 'P' THEN '05'
			WHEN 'PC' THEN '10'
			WHEN 'PN' THEN '10'
			WHEN 'PR' THEN '01'
			WHEN 'R2' THEN '10'
			WHEN 'S' THEN '01'
			WHEN 'SV' THEN '01'
			WHEN 'T' THEN '01'
			WHEN 'UN' THEN '01'
			WHEN 'V' THEN '02'
			WHEN 'VB' THEN '02'
			WHEN 'VP' THEN '02'
			WHEN 'VS' THEN '01'
			ELSE SCHEDULE_STATUS_CODE 		
		END AS STATUS_CODE
		,CASE SCHEDULE_STATUS_CODE
			WHEN 'B' THEN 'Billed'
			WHEN 'BP' THEN 'Paid'
			WHEN 'C' THEN 'Confirmed'
			WHEN 'CC' THEN 'Pending'
			WHEN 'DE' THEN 'Canceled'
			WHEN 'EC' THEN 'Canceled'
			WHEN 'EN' THEN 'Canceled'
			WHEN 'ER' THEN 'Pending'
			WHEN 'HR' THEN 'Canceled'
			WHEN 'HS' THEN 'Hold'
			WHEN 'M' THEN 'Pending'
			WHEN 'ND' THEN 'Hold'
			WHEN 'O' THEN 'Pending'
			WHEN 'OH' THEN 'Hold'
			WHEN 'P' THEN 'Paid'
			WHEN 'PC' THEN 'Canceled'
			WHEN 'PN' THEN 'Canceled'
			WHEN 'PR' THEN 'Pending'
			WHEN 'R2' THEN 'Canceled'
			WHEN 'S' THEN 'Pending'
			WHEN 'SV' THEN 'Pending'
			WHEN 'T' THEN 'Pending'
			WHEN 'UN' THEN 'Pending'
			WHEN 'V' THEN 'Confirmed'
			WHEN 'VB' THEN 'Confirmed'
			WHEN 'VP' THEN 'Confirmed'
			WHEN 'VS' THEN 'Pending'
			ELSE Schedule_Status_Desc
		END STATUS_DESCRIPTION
        ,MATH_FACTOR
		,ETL_LAST_UPDATED_DATE
		,COALESCE (DURATIONINHOURS,0) AS HOURS_SERVED
		,SCHEDULE_STATUS_CODE
	FROM VISITS
)
, CLIENT_DATA AS
(
	SELECT * FROM
	(
		
		SELECT TRIM(DB) AS MASTER_DB, TRIM(PATIENT_NUMBER) AS MASTER_PATIENT_NUMBER, TRIM(DB) AS DB, TRIM(PATIENT_NUMBER) AS PATIENT_NUMBER
		FROM DISC_DEDUPE_PROD.COSTALSYNCDATA.CLIENT_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		    SELECT DISTINCT TRIM(MASTER.DB) AS MASTER_DB,TRIM(MASTER.PATIENT_NUMBER) AS MASTER_PATIENT_NUMBER,  TRIM(MATCH.DB) AS DB, TRIM(MATCH.PATIENT_NUMBER) AS PATIENT_NUMBER
		FROM DISC_DEDUPE_PROD.COSTALSYNCDATA.CLIENT_MATCH_LIST AS MATCH
        JOIN DISC_DEDUPE_PROD.COSTALSYNCDATA.CLIENT_MASTER_LIST AS MASTER 
        ON MASTER.MASTER_ID = MATCH.MASTER_ID
       	WHERE MATCH.ID <> MATCH.MASTER_ID
       	
	)
) 
, EMPLOYEES AS 
(
	SELECT *,TO_DATE('1900-01-01', 'YYYY-MM-DD') AS EFFECTIVE_FROM_DATE, TO_DATE('9999-12-31', 'YYYY-MM-DD') AS EFFECTIVE_TO_DATE 
	FROM 
	(
		SELECT 
			TRIM(DB) AS MASTER_DB, 
			TRIM(NURSE_ID) AS MASTER_NURSE_ID,
			TRIM(DB) AS DB, 
			TRIM(NURSE_ID) AS NURSE_ID 
		FROM DISC_DEDUPE_PROD.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST
	) 
	UNION
	SELECT *,TO_DATE('1900-01-01', 'YYYY-MM-DD') AS EFFECTIVE_FROM_DATE, TO_DATE('9999-12-31', 'YYYY-MM-DD') AS EFFECTIVE_TO_DATE 
	FROM 
	(
		SELECT 
            TRIM(MASTER.DB) AS MASTER_DB, 
            TRIM(MASTER.NURSE_ID) AS MASTER_NURSE_ID, 
            TRIM(MATCH.DB) AS DB, 
            TRIM(MATCH.NURSE_ID) AS NURSE_ID
		FROM DISC_DEDUPE_PROD.COSTALSYNCDATA.EMPLOYEE_MATCH_LIST AS MATCH
        JOIN DISC_DEDUPE_PROD.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST AS MASTER
            ON MASTER.MASTER_ID = MATCH.MASTER_ID
        WHERE MATCH.ID <> MATCH.MASTER_ID
	)
), DATA AS (
	SELECT 
		 MD5(v.Schedule_Number|| '-' || v.db  || '-'  || 'COSTALSYNCDATA') AS VISIT_KEY
		,REPORT_DATE AS REPORT_DATE
		,coalesce(b.BRANCH_KEY,md5(NVL(v.DB, '') || '-' || coalesce(v.OFFICECODE,'') || '-'  || 'COSTALSYNCDATA'))  AS BRANCH_KEY
		,coalesce(md5(C.MASTER_DB || '-' || C.MASTER_PATIENT_NUMBER || '-'  ||  'COSTALSYNCDATA'), md5(v.DB || '-' || NVL(TRY_CAST(v.CLIENT_NUMBER AS INTEGER), -1)::STRING || '-' || 'COSTALSYNCDATA')) AS CLIENT_KEY
		,nvl(n.CONTRACT_KEY,md5(v.DB || '-' || v.CONTRACT_CODE || '-' || 'COSTALSYNCDATA')) AS CONTRACT_KEY
		,nvl(MD5( TRIM( e.MASTER_DB) || '-' || UPPER( TRIM( E.MASTER_NURSE_ID)) || '-' || 'COSTALSYNCDATA'), md5(NVL(v.DB, '') || '-' || upper(coalesce(v.employeeid, '-1')) || '-' || 'COSTALSYNCDATA')) AS EMPLOYEE_KEY
		,CASE v.DB WHEN 'SHC_ALTRUS' THEN 1 WHEN 'SHC_SAVANNAH' THEN 2 ELSE -1 END AS SOURCE_SYSTEM_ID
		,nvl(s.SUPERVISOR_KEY,md5(v.DB || '-' || coalesce(v.SUPERVISORCODE,'Unknown') || '-' || 'COSTALSYNCDATA')) AS SUPERVISOR_KEY
		,v.SERVICE_DATE AS SERVICE_DATE
		,NULL AS PAYROLL_DATE
		,v.OFFICENAME  AS BRANCH_NAME
		,coalesce(TRY_CAST(c.MASTER_PATIENT_NUMBER AS INTEGER),TRY_CAST(v.CLIENT_NUMBER AS INTEGER)) AS CLIENT_NUMBER
		,v.CONTRACT_CODE AS CONTRACT_CODE
		,coalesce(e.MASTER_NURSE_ID,v.employeeid)   AS EMPLOYEE_ID
		,v.Db AS SYSTEM_CODE
		,v.SUPERVISORCODE AS SUPERVISOR_CODE
		,1 AS CLEAN_SHIFT_FLAG
		,v.STATUS_CODE AS STATUS_CODE
		,v.STATUS_DESCRIPTION AS STATUS_DESCRIPTION
	    ,NULL AS CANCEL_REASON_CODE
	    ,NULL AS CANCEL_REASON_DESCRIPTION
	    ,NULL AS CANCEL_REASON_NOTES
		,FALSE AS EXCEPTION_REASON_FLAG
		,NULL AS RESOLUTION_CODE
		,NULL AS RESOLUTION_DESCRIPTION
	    ,NULL AS REJECTION_CODE
	    ,NULL AS REJECTION_DESCRIPTION
	    ,NULL AS BILL_CODE
	    ,CASE WHEN v.STATUS_CODE IN ('02','04','05') THEN (r.AMOUNT * v.MATH_FACTOR ) ELSE 0 END AS BILL_RATE
	    ,NULL AS OVERHEAD_RATE
	    ,v.HOURS_SERVED
	    ,NULL AS COMMENTS
	    ,NULL AS IS_EVV_FLAG
	    ,NULL AS TIMESHEET_TYPE
	    ,NULL AS TRACKING_ID
		,STATUS.CONFIRMED_FLAG
	FROM Visit_Agg v
	LEFT JOIN BILL_RATE r
	    ON r.DB = V.DB
	    AND r.SCHEDULE_NUMBER = V.SCHEDULE_NUMBER
	LEFT JOIN HAH.DIM_BRANCH b
		ON b.OFFICE_CODE = TRIM(V.OFFICECODE)
		AND b.SYSTEM_CODE = TRIM(v.DB)
	LEFT JOIN CLIENT_DATA c
		ON TRY_CAST (c.PATIENT_NUMBER AS INTEGER) = TRY_CAST(v.CLIENT_NUMBER AS INTEGER)
	    AND TRIM(c.DB) = TRIM(v.DB)
	LEFT JOIN HAH.DIM_CONTRACT n
		ON n.CONTRACT_CODE = v.CONTRACT_CODE
	    AND n.SYSTEM_CODE = v.DB
	LEFT JOIN EMPLOYEES e
		ON coalesce(v.employeeid,'-1') = e.NURSE_ID
		AND TRIM(v.DB) = TRIM(e.DB)
	    AND v.SERVICE_DATE >= e.EFFECTIVE_FROM_DATE
	    AND v.SERVICE_DATE < e.EFFECTIVE_TO_DATE
	LEFT JOIN HAH.DIM_SUPERVISOR s
		ON TRIM(s.SUPERVISOR_CODE) = coalesce(v.SUPERVISORCODE,'Unknown')
	    AND s.SYSTEM_CODE = v.DB
	LEFT JOIN HAH.DIM_VISIT_STATUS_MAPPING STATUS ON V.SCHEDULE_STATUS_CODE= TRIM(STATUS.DISC_VISIT_STATUS)
		AND STATUS.SOURCE_SYSTEM_ID IN (1,2)
		AND v.DB = STATUS.SYSTEM_CODE
	WHERE COALESCE(v.HOURS_SERVED,0) <> 0
		AND v.ETL_LAST_UPDATED_DATE >= '1900-01-01'
)
	SELECT DATA.VISIT_KEY
	FROM DATA AS DATA
	LEFT JOIN HAH.FACT_SYSTEM_CUTOVER_DATE AS CUTOVER
		ON CUTOVER.SOURCE_SYSTEM_ID = DATA.SOURCE_SYSTEM_ID 
			AND CUTOVER.SYSTEM_CODE = DATA.SYSTEM_CODE
			AND NVL(CUTOVER.BRANCH_KEY, DATA.BRANCH_KEY) = DATA.BRANCH_KEY
			AND NVL(CUTOVER.CONTRACT_KEY, DATA.CONTRACT_KEY) = DATA.CONTRACT_KEY
	WHERE DATA.SERVICE_DATE BETWEEN NVL(CUTOVER.START_DATE, DATA.SERVICE_DATE) AND NVL(CUTOVER.END_DATE, DATA.SERVICE_DATE);