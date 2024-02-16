resource "snowflake_view" "DISC_MATRIXCARE_VW_STVHC_T_AUTHORIZATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "VW_STVHC_T_AUTHORIZATION"
	statement = <<-SQL
	 SELECT * -- Using * Considering the fact that there can be new fields in future
		, CONVERT_TIMEZONE('America/New_York', AUTH_BEGINDATE)::DATE AS AUTH_BEGINDATE_EST
		, CONVERT_TIMEZONE('America/New_York', AUTH_ENDDATE)::DATE AS AUTH_ENDDATE_EST
FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_AUTHORIZATION;
SQL
	or_replace = true 
	is_secure = false 
}

