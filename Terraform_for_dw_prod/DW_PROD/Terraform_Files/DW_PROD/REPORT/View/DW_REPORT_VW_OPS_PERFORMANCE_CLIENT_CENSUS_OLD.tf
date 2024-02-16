resource "snowflake_view" "DW_REPORT_VW_OPS_PERFORMANCE_CLIENT_CENSUS_OLD" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_OPS_PERFORMANCE_CLIENT_CENSUS_OLD"
	statement = <<-SQL
	 
SELECT 
CASE WHEN CC.TERMINATED_FLAG=1 THEN CC.CLIENT_KEY ELSE NULL END AS TERMINATED_CLIENT_KEY,
CASE WHEN CC.REACTIVATED_FLAG=1 AND CC.FIRST_SERVICE_DATE <> CC.SERVICE_MONTH THEN CC.CLIENT_KEY ELSE NULL END AS REACTIVATED_CLIENT_KEY,
CASE WHEN CC.FIRST_SERVICE_DATE=CC.SERVICE_MONTH THEN CC.CLIENT_KEY ELSE NULL END AS NEW_CLIENT_KEY,
CASE WHEN DATE_TRUNC('MONTH',CC.REFERRAL_DATE)=CC.SERVICE_MONTH THEN CC.CLIENT_KEY ELSE NULL END AS REFERRAL_CLIENT_KEY,
CC.SERVICE_MONTH,
CC.FIRST_SERVICE_DATE AS FIRST_SERVICE_MONTH ,
CC.REFERRAL_DATE,
CC.BRANCH_KEY,
CC.SUPERVISOR_KEY,
CC.REVENUE_CATEGORY,
CC.REVENUE_SUBCATEGORY_CODE,
CC.SOURCE_SYSTEM_ID ,
CC.ORIGINAL_SOURCE_SYSTEM_ID 
FROM REPORT.CLIENT_CENSUS CC
WHERE INCLUDE_FOR_OPS_PERF_CLIENTS=1 AND SERVICE_MONTH>='2020-01-01' AND SERVICE_MONTH<DATE_TRUNC('MONTH',CURRENT_DATE);
SQL
	or_replace = true 
	is_secure = false 
}

