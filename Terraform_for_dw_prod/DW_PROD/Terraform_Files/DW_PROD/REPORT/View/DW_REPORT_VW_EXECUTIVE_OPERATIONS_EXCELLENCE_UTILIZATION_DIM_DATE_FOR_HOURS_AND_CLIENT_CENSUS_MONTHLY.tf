resource "snowflake_view" "DW_REPORT_VW_EXECUTIVE_OPERATIONS_EXCELLENCE_UTILIZATION_DIM_DATE_FOR_HOURS_AND_CLIENT_CENSUS_MONTHLY" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_EXECUTIVE_OPERATIONS_EXCELLENCE_UTILIZATION_DIM_DATE_FOR_HOURS_AND_CLIENT_CENSUS_MONTHLY"
	statement = <<-SQL
	 	SELECT DISTINCT FIRST_DAY_OF_MONTH, CONCAT(MONTH_NAME, ' ', "YEAR") PERIOD_NAME
	FROM HAH.DIM_DATE 
	WHERE FIRST_DAY_OF_MONTH BETWEEN DATE_TRUNC(YEAR, DATEADD(YEAR, -4, CURRENT_DATE())) AND DATE_TRUNC(MONTH, DATEADD(MONTH, 2, CURRENT_DATE()));
SQL
	or_replace = true 
	is_secure = false 
}

