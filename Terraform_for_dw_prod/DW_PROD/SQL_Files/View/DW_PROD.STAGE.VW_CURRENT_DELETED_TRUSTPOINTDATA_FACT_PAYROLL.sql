create or replace view DW_PROD.STAGE.VW_CURRENT_DELETED_TRUSTPOINTDATA_FACT_PAYROLL(
	PAYROLL_KEY
) as
WITH PAYROLL AS (
	SELECT PAYROLL.PAYROLL_DATE AS REPORT_DATE, 
		COALESCE(TRY_CAST(PAYROLL.EMPLOYEE_ID AS BIGINT)::STRING, TRIM(PAYROLL.EMPLOYEE_ID)) AS DERIVED_EMPLOYEE_ID, -- Try to use a consistent int version (i.e. no preceding 0), but if alphanumeric then use the value)
		COALESCE(EMPLOYEE.EMPLOYEE_KEY, MD5(DERIVED_EMPLOYEE_ID || '-' || 'EXCEL')) AS EMPLOYEE_KEY,
		COALESCE(BRANCH.BRANCH_KEY, md5('8485' || '-' || 'Unknown' || '-' ||  'SANDATAIMPORT')) AS BRANCH_KEY,
		6 AS SOURCE_SYSTEM_ID,
		PAYROLL.PAYROLL_DATE,
		DERIVED_EMPLOYEE_ID AS EMPLOYEE_ID, 
		COALESCE(BRANCH.BRANCH_NAME, PAYROLL.BRANCH_NAME, 'Unknown') AS BRANCH_NAME,
		PAYROLL.COMPANY AS SYSTEM_CODE,
		PAYROLL.PAY_PERIOD_START_DATE,
		PAYROLL.PAY_PERIOD_END_DATE,
		PAYROLL.CHECK_NUMBER,
		PAYROLL.PAY_HOURS,
		PAYROLL.SERVICE_HOURS,
		PAYROLL.OVERTIME_HOURS,
		PAYROLL.NON_SERVICE_UNITS,
		PAYROLL.SICK_HOURS,
		PAYROLL.VACATION_HOURS,
		PAYROLL.PAY_RATE,
		PAYROLL.OVERTIME_RATE,
		PAYROLL.GROSS_PAY_AMOUNT,
		PAYROLL.SERVICE_PAY_AMOUNT,
		PAYROLL.OVERTIME_PAY_AMOUNT,
		PAYROLL.NON_SERVICE_PAY_AMOUNT,
		PAYROLL.TAX_AMOUNT,
		PAYROLL.NET_PAY_AMOUNT,
		PAYROLL.OTHER_DEDUCTIONS_AMOUNT,
		PAYROLL.UNION_DUES_AMOUNT,
		PAYROLL.REIMBURSEMENT_AMOUNT AS REINBURSMENT_AMOUNT,
		GREATEST(COALESCE(PAYROLL.ETL_LAST_UPDATED_DATE, '1/1/1900'), COALESCE(BRANCH.ETL_LAST_UPDATED_DATE, '1/1/1900')) AS ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.TRUSTPOINTDATA.HIST_PAYROLL AS PAYROLL
	LEFT JOIN HAH.DIM_BRANCH AS BRANCH
		ON BRANCH.SOURCE_SYSTEM_ID = 4 
			AND REPLACE(
					TRIM(UPPER(REGEXP_REPLACE(REPLACE(PAYROLL.BRANCH_NAME, PAYROLL.SYSTEM_CODE), '-|~|\`|\!|@|#|$|%|^|&|\\*|\\(|\\)|_|\\+|=|\\{|\\}|\\[|\\]|\\|\\\\|;|:|"|''|<|>|,|\\.|\\?|/| ', ''))),
					'CHINATOWNPA', 'CHINATOWN') = 
				REPLACE (
					TRIM(UPPER(REGEXP_REPLACE(BRANCH.BRANCH_NAME, '-|~|\`|\!|@|#|$|%|^|&|\\*|\\(|\\)|_|\\+|=|\\{|\\}|\\[|\\]|\\|\\\\|;|:|"|''|<|>|,|\\.|\\?|/| ', ''))),
					'CHINATOWNPA', 'CHINATOWN')
	LEFT JOIN HAH.DIM_EMPLOYEE AS EMPLOYEE
		ON EMPLOYEE.SOURCE_SYSTEM_ID = 4 AND EMPLOYEE.EMPLOYEE_ID = COALESCE(TRY_CAST(PAYROLL.EMPLOYEE_ID AS BIGINT)::STRING, TRIM(PAYROLL.EMPLOYEE_ID))
	WHERE PAYROLL.COMPANY = 'EXCEL'
		AND PAYROLL.ETL_DELETED_FLAG = TRUE
		AND CAST(PAYROLL.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_PROD.TRUSTPOINTDATA.HIST_PAYROLL)
)
	SELECT MD5(CAST(PAYROLL.PAYROLL_DATE AS VARCHAR) || '-' || PAYROLL.CHECK_NUMBER || '-' || 'EXCEL') AS PAYROLL_KEY
	FROM PAYROLL AS PAYROLL
	--WHERE PAYROLL.ETL_LAST_UPDATED_DATE >= '1900-01-01'
;