resource "snowflake_view" "DW_REPORT_VW_OPS_PERFORMANCE_UTILIZATION_BACKUP" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_OPS_PERFORMANCE_UTILIZATION_BACKUP"
	statement = <<-SQL
	 SELECT 
U.CLIENT_KEY,
CASE WHEN INCLUDE_FOR_OPS_PERF_CLIENTS=1 THEN U.CLIENT_KEY ELSE NULL END AS CLIENT_KEY_CENSUS,
CASE WHEN INCLUDE_FOR_OPS_PERF_HOURS=1 THEN U.CLIENT_KEY ELSE NULL END AS CLIENT_KEY_HOURS,
U.CONTRACT_KEY,
U.CONTRACT_CODE,
U.OFFICE_NUMBER,
U.OFFICE_NAME,
U.STATE,
U.BRANCH_KEY,
U.SUPERVISOR_KEY,
U.SUPERVISOR_CODE,
COALESCE(CASE WHEN INCLUDE_FOR_OPS_PERF_HOURS=1 THEN U.HOURS_SERVED END,0) AS HOURS_SERVED,
COALESCE(CASE WHEN INCLUDE_FOR_OPS_PERF_CLIENTS=1 THEN U.HOURS_SERVED END,0) AS HOURS_SERVED_CENSUS,
--NVL(U.HOURS_SERVED,0) AS HOURS_SERVED,
COALESCE(CASE WHEN INCLUDE_FOR_OPS_PERF_HOURS=1 THEN U.HOURS_AUTHORIZED END,0) AS HOURS_AUTHORIZED,
COALESCE(CASE WHEN INCLUDE_FOR_OPS_PERF_HOURS=1 THEN U.HOURS_AUTHORIZED_NON_ADJUSTED END,0) AS HOURS_AUTHORIZED_NON_ADJUSTED,
COALESCE(CASE WHEN INCLUDE_FOR_OPS_PERF_CLIENTS=1 THEN U.HOURS_AUTHORIZED END,0) AS HOURS_AUTHORIZED_CENSUS,
--NVL(U.HOURS_AUTHORIZED,0) AS HOURS_AUTHORIZED,
COALESCE(CASE WHEN INCLUDE_FOR_OPS_PERF_HOURS=1 THEN U.UTILIZATION END,0) AS UTILIZATION,
--NVL(U.UTILIZATION,0) AS UTILIZATION,
COALESCE(CASE WHEN INCLUDE_FOR_OPS_PERF_HOURS=1 THEN U.OVER_AUTHED END,0) AS OVER_AUTHED,
COALESCE(CASE WHEN INCLUDE_FOR_OPS_PERF_HOURS=1 THEN U.OVER_AUTHED END,0) AS OVER_AUTHED_ADJUSTED,
--OVER_AUTHED,
COALESCE(CASE WHEN INCLUDE_FOR_OPS_PERF_HOURS=1 THEN U.SERVED_WITHOUT_AUTH END,0) AS SERVED_WITHOUT_AUTH,
--U.SERVED_WITHOUT_AUTH,
COALESCE(CASE WHEN INCLUDE_FOR_OPS_PERF_HOURS=1 THEN U.OVER_AUTHED_HOURS END,0) AS OVER_AUTHED_HOURS,
COALESCE(CASE WHEN INCLUDE_FOR_OPS_PERF_HOURS=1 THEN U.OVER_AUTHED_HOURS END,0) AS OVER_AUTHED_HOURS_ADJUSTED,
--NVL(U.OVER_AUTHED_HOURS,0) AS OVER_AUTHED_HOURS,
U.VISITS_ALL,
U.VISITS_CLEAN_SHIFTS,
U.VISITS_NEED_MAINTENANCE,
U.PERIOD_BEGIN_DATE AS REPORT_DATE
FROM REPORT.UTILIZATION U
JOIN REPORT.VW_DASHBOARD_CONTRACTS C ON U.CONTRACT_KEY=C.CONTRACT_KEY
WHERE U.PERIOD_BEGIN_DATE >= '2020-01-01' AND U.PERIOD_BEGIN_DATE < DATE_TRUNC('MONTH',CURRENT_DATE);
SQL
	or_replace = true 
	is_secure = false 
}

