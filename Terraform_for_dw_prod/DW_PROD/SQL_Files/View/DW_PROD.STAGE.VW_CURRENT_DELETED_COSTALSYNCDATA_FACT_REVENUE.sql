create or replace view DW_PROD.STAGE.VW_CURRENT_DELETED_COSTALSYNCDATA_FACT_REVENUE(
	REVENUE_KEY
) as 
WITH HOUR_UNIT_MAPPING AS (
	SELECT DB, PLAN_CODE, 
		MIN(TIME_TRANSLATION_CODE) AS TIME_TRANSLATION_CODE, 
		CASE LEFT(MIN(TIME_TRANSLATION_CODE), 2) WHEN '15' THEN 4 WHEN '30' THEN 2 ELSE 1 END MATH_FACTOR
	FROM DISC_PROD.COSTALSYNCDATA.CV_PLANTIMETRANSLATION
	WHERE TRIM(TIME_TRANSLATION_CODE) LIKE '%MIN'
	GROUP BY DB, PLAN_CODE 
), CURRENT_BILLED_DATA AS (
	SELECT TRANSACTIONS.DB, TRANSACTIONS.BILL_NUMBER, CHARGES.SEQUENCE_NUMBER, -- Unique Key
		TRANSACTIONS.LOCATION_CODE, TRANSACTIONS.DEPARTMENT__CODE, 
		TRANSACTIONS.PATIENT_NUMBER, TRANSACTIONS.ADMISSION_NUMBER, TRANSACTIONS.PLAN_CODE, CHARGES.PROCCODE, 
		TRANSACTIONS.SCHEDULE_NUMBER, CHARGES.SERVICE_DATE, 
		CHARGES.UNIT_AMOUNT AS INVOICE_RATE,
		SCHEDULES.NURSE_ID,
--		SUM(
--			try_cast(LEFT(trim(SCHEDULES.Confirmed_Duration ),2) AS INTEGER) +try_cast(RIGHT(trim(SCHEDULES.Confirmed_Duration),2) AS INTEGER)/60 --AS DurationInHours
--		) AS SERVICE_HOURS,
		SUM(CHARGES.NUMBER_OF_UNIT) INVOICE_UNITS,
		SUM(CHARGES.EXTENDED_AMOUNT) AMOUNT_BILLED,
		MAX(CHARGES.BILL_DATE) AS BILL_DATE,
		MAX(GREATEST(COALESCE(TRANSACTIONS.ETL_LAST_UPDATED_DATE, '1/1/1900'), COALESCE(CHARGES.ETL_LAST_UPDATED_DATE, '1/1/1900'), COALESCE(SCHEDULES.ETL_LAST_UPDATED_DATE, '1/1/1900'))) AS ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.COSTALSYNCDATA.HIST_CV_BILLINGTRANSACTIONS AS TRANSACTIONS
	JOIN DISC_PROD.COSTALSYNCDATA.HIST_CV_CHARGES AS CHARGES
		ON CHARGES.DB = TRANSACTIONS.DB AND CHARGES.PATIENT_NUMBER = TRANSACTIONS.PATIENT_NUMBER AND CHARGES.BILL_NUMBER = TRANSACTIONS.BILL_NUMBER 
	LEFT JOIN DISC_PROD.COSTALSYNCDATA.CV_SCHEDULES AS SCHEDULES
		ON SCHEDULES.DB = TRANSACTIONS.DB AND SCHEDULES.SCHEDULE_NUMBER = TRANSACTIONS.SCHEDULE_NUMBER 
--			AND TRIM(UPPER(SCHEDULES.SCHEDULE_STATUS_CODE)) IN ('B', 'BP', 'P') 
			AND TRIM(SCHEDULES.CONFIRMED_DURATION) NOT IN ('', '0000') 
	WHERE ((TRANSACTIONS.ETL_DELETED_FLAG = TRUE AND CAST(TRANSACTIONS.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_PROD.COSTALSYNCDATA.HIST_CV_BILLINGTRANSACTIONS))
            OR (CHARGES.ETL_DELETED_FLAG = TRUE AND CAST(CHARGES.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_PROD.COSTALSYNCDATA.HIST_CV_CHARGES)))
	GROUP BY TRANSACTIONS.DB, TRANSACTIONS.BILL_NUMBER, CHARGES.SEQUENCE_NUMBER, 
		TRANSACTIONS.LOCATION_CODE, TRANSACTIONS.DEPARTMENT__CODE,
		TRANSACTIONS.PATIENT_NUMBER, TRANSACTIONS.ADMISSION_NUMBER, TRANSACTIONS.PLAN_CODE, CHARGES.PROCCODE, 
		TRANSACTIONS.SCHEDULE_NUMBER, CHARGES.SERVICE_DATE, 
		CHARGES.UNIT_AMOUNT,
		SCHEDULES.NURSE_ID
), CURRENT_PAID_DATA AS (
	SELECT DATA.DB, DATA.BILL_NUMBER, DATA.SEQUENCE_NUMBER, -- Unique Key
		MAX(DATA.PAYMENT_DATE) AS PAYMENT_DATE,
		SUM(DATA.PAID_AMOUNT) AS AMOUNT_COLLECTED,
		MAX(DATA.ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.COSTALSYNCDATA.HIST_CV_BILLINGDATA DATA
	WHERE DATA.SERVICE_DATE >= '2010-01-01'
	AND DATA.ETL_DELETED_FLAG = TRUE
    AND CAST(DATA.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_PROD.COSTALSYNCDATA.HIST_CV_BILLINGDATA)
	GROUP BY DATA.DB, DATA.BILL_NUMBER, DATA.SEQUENCE_NUMBER
	HAVING SUM(DATA.PAID_AMOUNT) <> 0
), CHANGED_DATA AS (
	SELECT DISTINCT DB, BILL_NUMBER, SEQUENCE_NUMBER 
	FROM CURRENT_BILLED_DATA
	WHERE ETL_LAST_UPDATED_DATE >= '1900-01-01'
	UNION
	SELECT DISTINCT DB, BILL_NUMBER, SEQUENCE_NUMBER 
	FROM CURRENT_PAID_DATA
	WHERE ETL_LAST_UPDATED_DATE >= '1900-01-01'
), REVENUE_DATA AS (
	SELECT TRIM(BILLED_DATA.DB) AS DB,
		TRIM(BILLED_DATA.BILL_NUMBER) AS BILL_NUMBER,
		TRIM(BILLED_DATA.PATIENT_NUMBER) AS CLIENT_NUMBER,
		TRIM(BILLED_DATA.PLAN_CODE) AS CONTRACT_CODE,
		TRIM(BILLED_DATA.PROCCODE) AS BILL_CODE,		
		BILLED_DATA.SERVICE_DATE,
		TRIM(BILLED_DATA.LOCATION_CODE) AS LOCATION_CODE,
		TRIM(BILLED_DATA.DEPARTMENT__CODE) AS SUPERVISOR_CODE,
		TRIM(UPPER(BILLED_DATA.NURSE_ID)) AS EMPLOYEE_ID,
		MIN(MIN(BILLED_DATA.BILL_DATE)) OVER(PARTITION BY TRIM(BILLED_DATA.DB), TRIM(BILLED_DATA.BILL_NUMBER), BILLED_DATA.SERVICE_DATE) AS REVENUE_DATE, -- First bill date
		MAX(MAX(PAID_DATA.PAYMENT_DATE)) OVER(PARTITION BY TRIM(BILLED_DATA.DB), TRIM(BILLED_DATA.BILL_NUMBER), BILLED_DATA.SERVICE_DATE) AS PAYMENT_DATE,
		SUM(CAST(BILLED_DATA.INVOICE_UNITS / NVL(MAPPING.MATH_FACTOR, 1) AS DECIMAL(38, 3))) AS INVOICE_HOURS,
		MAX(CAST(BILLED_DATA.INVOICE_RATE * NVL(MAPPING.MATH_FACTOR, 1) AS DECIMAL(38, 3))) AS INVOICE_RATE,
		SUM(NVL(BILLED_DATA.AMOUNT_BILLED, 0)) AS AMOUNT_BILLED,
		SUM(NVL(PAID_DATA.AMOUNT_COLLECTED, 0)) AS AMOUNT_COLLECTED
	FROM CURRENT_BILLED_DATA AS BILLED_DATA
	JOIN CHANGED_DATA AS CHANGED_DATA
		ON CHANGED_DATA.DB = BILLED_DATA.DB
			AND CHANGED_DATA.BILL_NUMBER = BILLED_DATA.BILL_NUMBER
			AND CHANGED_DATA.SEQUENCE_NUMBER = BILLED_DATA.SEQUENCE_NUMBER
	LEFT JOIN CURRENT_PAID_DATA AS PAID_DATA
		ON PAID_DATA.DB = BILLED_DATA.DB
	 		AND PAID_DATA.BILL_NUMBER = BILLED_DATA.BILL_NUMBER
			AND PAID_DATA.SEQUENCE_NUMBER = BILLED_DATA.SEQUENCE_NUMBER
	LEFT JOIN HOUR_UNIT_MAPPING AS MAPPING
		ON MAPPING.DB = BILLED_DATA.DB AND MAPPING.PLAN_CODE = BILLED_DATA.PLAN_CODE
	GROUP BY TRIM(BILLED_DATA.DB),
		TRIM(BILLED_DATA.BILL_NUMBER),
		TRIM(BILLED_DATA.PATIENT_NUMBER),
		TRIM(BILLED_DATA.PLAN_CODE),
		TRIM(BILLED_DATA.PROCCODE),		
		BILLED_DATA.SERVICE_DATE,
		TRIM(BILLED_DATA.LOCATION_CODE),
		TRIM(BILLED_DATA.DEPARTMENT__CODE),
		TRIM(UPPER(BILLED_DATA.NURSE_ID))
), CLIENT_DATA AS
(
	SELECT * FROM
	(
		SELECT TRIM(DB) AS MASTER_DB, TRIM(PATIENT_NUMBER) AS MASTER_PATIENT_NUMBER, TRIM(DB) AS DB, TRIM(PATIENT_NUMBER) AS PATIENT_NUMBER
		FROM DISC_DEDUPE_PROD.COSTALSYNCDATA.CLIENT_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT TRIM(MASTER.DB) AS MASTER_DB, TRIM(MASTER.PATIENT_NUMBER) AS MASTER_PATIENT_NUMBER, TRIM(MATCH.DB) AS DB, TRIM(MATCH.PATIENT_NUMBER) AS PATIENT_NUMBER
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
)
SELECT 
	MD5(REVENUE.DB || '-' || REVENUE.BILL_NUMBER || '-' || REVENUE.SERVICE_DATE || '-' || REVENUE.CONTRACT_CODE || '-' || REVENUE.BILL_CODE || '-' || NVL(REVENUE.EMPLOYEE_ID, '') || '-' || 'COSTALSYNCDATA') AS REVENUE_KEY
FROM REVENUE_DATA AS REVENUE
LEFT JOIN HAH.DIM_BRANCH AS BRANCH
	ON BRANCH.SYSTEM_CODE = REVENUE.DB AND BRANCH.OFFICE_CODE = REVENUE.LOCATION_CODE
LEFT JOIN CLIENT_DATA AS CLIENT
	ON TRIM(CLIENT.DB) = TRIM(REVENUE.DB) AND TRIM(CLIENT.PATIENT_NUMBER) = TRIM(REVENUE.CLIENT_NUMBER)
LEFT JOIN EMPLOYEES AS EMPLOYEE 
	ON TRIM(EMPLOYEE.DB) = TRIM(REVENUE.DB)
		AND TRIM(UPPER(EMPLOYEE.NURSE_ID)) = TRIM(UPPER(REVENUE.EMPLOYEE_ID))
LEFT JOIN HAH.DIM_CONTRACT CONTRACT
	ON CONTRACT.SYSTEM_CODE = REVENUE.DB AND CONTRACT.CONTRACT_CODE = REVENUE.CONTRACT_CODE
LEFT JOIN HAH.DIM_SUPERVISOR AS SUPERVISOR
	ON SUPERVISOR.SYSTEM_CODE = REVENUE.DB
    AND SUPERVISOR.SUPERVISOR_CODE = REVENUE.SUPERVISOR_CODE
LEFT JOIN HAH.DIM_INVOICE AS INVOICE
	ON INVOICE.SYSTEM_CODE = REVENUE.DB AND INVOICE.INVOICE_NUMBER = REVENUE.BILL_NUMBER;