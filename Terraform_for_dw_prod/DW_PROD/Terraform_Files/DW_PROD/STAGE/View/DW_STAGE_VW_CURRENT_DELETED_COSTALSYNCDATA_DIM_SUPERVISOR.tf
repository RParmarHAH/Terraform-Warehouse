resource "snowflake_view" "DW_STAGE_VW_CURRENT_DELETED_COSTALSYNCDATA_DIM_SUPERVISOR" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_DELETED_COSTALSYNCDATA_DIM_SUPERVISOR"
	statement = <<-SQL
	 WITH SC_CLIENT_SUPERVISORS AS (
	SELECT VISIT.SYSTEM_CODE AS DB, VISIT.SUPERVISOR_CODE AS DEPARTMENT__CODE, MAX(VISIT.ETL_LAST_UPDATED_DATE) ETL_LAST_UPDATED_DATE
	FROM HAH.FACT_VISIT VISIT
	JOIN HAH.DIM_BRANCH BRANCH
		ON BRANCH.BRANCH_KEY = VISIT.BRANCH_KEY
	WHERE VISIT.CONFIRMED_FLAG = 'YES' --VISIT.STATUS_CODE IN ('02', '03', '04', '05')
	GROUP BY VISIT.SYSTEM_CODE, VISIT.SUPERVISOR_CODE
	-- Supervisor should have served SC client within last 3 months of their last service record
	HAVING DATE_TRUNC(MONTH, MAX(CASE WHEN BRANCH.OFFICE_STATE_CODE = 'SC' THEN VISIT.REPORT_DATE END)) >= DATE_TRUNC(MONTH, DATEADD(MONTH, -3, MAX(VISIT.REPORT_DATE))) 
), SUPERVISORS AS (
	SELECT TRIM(DEPARTMENTS.DB) AS DB,
		TRIM(NVL(DEPARTMENTS.DEPARTMENT__CODE, '')) AS SUPERVISOR_CODE,
		TRIM(NVL(DEPARTMENTS.DEPARTMENT_NAME, 'Unknown')) AS SUPERVISOR_NAME,
		IFF(SC_CLIENT_SUPERVISORS.DB IS NOT NULL, 'SC', 'GA') AS SUPERVISOR_STATE_CODE,
		TO_DATE('1900-01-01', 'YYYY-MM-DD') AS EFFECTIVE_FROM_DATE,
		TO_DATE('9999-12-31', 'YYYY-MM-DD') AS EFFECTIVE_TO_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.HIST_CV_DEPARTMENTS AS DEPARTMENTS
	LEFT JOIN SC_CLIENT_SUPERVISORS AS SC_CLIENT_SUPERVISORS
		ON SC_CLIENT_SUPERVISORS.DB = TRIM(DEPARTMENTS.DB) AND SC_CLIENT_SUPERVISORS.DEPARTMENT__CODE = TRIM(DEPARTMENTS.DEPARTMENT__CODE)
	WHERE (DEPARTMENTS.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR SC_CLIENT_SUPERVISORS.ETL_LAST_UPDATED_DATE >= '1900-01-01')
		AND DEPARTMENTS.ETL_DELETED_FLAG = TRUE
		AND CAST(DEPARTMENTS.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.HIST_CV_DEPARTMENTS)
)
SELECT
	MD5(SUPERVISORS.DB || '-' || SUPERVISORS.SUPERVISOR_CODE || '-' || 'COSTALSYNCDATA') AS SUPERVISOR_KEY --PK
FROM SUPERVISORS AS SUPERVISORS;
SQL
	or_replace = true 
	is_secure = false 
}

