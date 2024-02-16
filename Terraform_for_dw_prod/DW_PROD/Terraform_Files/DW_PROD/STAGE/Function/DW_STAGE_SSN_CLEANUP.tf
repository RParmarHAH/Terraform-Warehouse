resource "snowflake_function" "DW_STAGE_SSN_CLEANUP" {
	name = "SSN_CLEANUP"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	language  = "SQL"

	arguments {
		name = "SSN"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(11)"
	statement = <<-EOT
	
  	CASE 
  		WHEN LENGTH(NULLIF(REGEXP_REPLACE(TRIM(SSN),'\\-|\\\\\\\\s|\\\\\\\\\\\\\\\\|[A-Z]'),'')) = 9 
		AND NOT (NULLIF(TRIM(REGEXP_REPLACE(SSN,'\\-|\\\\\\\\s|\\\\\\\\\\\\\\\\|[A-Z]')),'') LIKE ANY ('666%','000%'))
		AND LEFT(NULLIF(TRIM(REGEXP_REPLACE(SSN,'\\-|\\\\\\\\s|\\\\\\\\\\\\\\\\|[A-Z]')),''),3)::NUMBER NOT BETWEEN 900 AND 999
		THEN NULLIF(REGEXP_REPLACE(TRIM(SSN),'\\-|\\\\\\\\s|\\\\\\\\\\\\\\\\|[A-Z]'),'')
		ELSE NULL
	END

 EOT
}

