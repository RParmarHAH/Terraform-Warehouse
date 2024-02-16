resource "snowflake_view" "DW_REPORT_VW_EXECUTIVE_OPERATIONS_EXCELLENCE_CLIENTS_REACTIVATED_DIM_DATE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_EXECUTIVE_OPERATIONS_EXCELLENCE_CLIENTS_REACTIVATED_DIM_DATE"
	statement = <<-SQL
	 	SELECT DISTINCT FIRST_DAY_OF_MONTH PERIOD_BEGIN_DATE, LAST_DAY_OF_MONTH PERIOD_END_DATE, CONCAT(MONTH_NAME, ' ', "YEAR") PERIOD_NAME
	FROM HAH.DIM_DATE 
	WHERE FIRST_DAY_OF_MONTH BETWEEN DATE_TRUNC(MONTH, DATEADD(MONTH, -14, CURRENT_DATE())) AND DATE_TRUNC(MONTH, DATEADD(MONTH, -1, CURRENT_DATE()));
SQL
	or_replace = true 
	is_secure = false 
}

