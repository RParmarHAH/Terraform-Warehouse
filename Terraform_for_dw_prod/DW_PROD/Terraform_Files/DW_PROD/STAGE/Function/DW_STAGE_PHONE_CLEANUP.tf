resource "snowflake_function" "DW_STAGE_PHONE_CLEANUP" {
	name = "PHONE_CLEANUP"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	language  = "SQL"

	arguments {
		name = "PHONE"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	statement = <<-EOT

	CASE 
		WHEN
			NULLIF(TRIM(UPPER(PHONE)),'') ILIKE '___-___-____%' OR NULLIF(TRIM(UPPER(PHONE)),'') ILIKE '___.___.____%' 
			THEN LEFT(NULLIF(TRIM(REGEXP_REPLACE(UPPER(PHONE),'[^[:digit:]]')),''),10)
		WHEN
			LENGTH(NULLIF(TRIM(REGEXP_REPLACE(UPPER(PHONE),'[^[:digit:]]')),'')) = 10
			THEN NULLIF(TRIM(REGEXP_REPLACE(UPPER(PHONE),'[^[:digit:]]')),'')
		WHEN 
			LENGTH(NULLIF(TRIM(REGEXP_REPLACE(UPPER(PHONE),'[^[:digit:]]')),'')) = 11 
			THEN RIGHT(NULLIF(TRIM(REGEXP_REPLACE(UPPER(PHONE),'[^[:digit:]]')),''),10)
		ELSE
			NULL
	END

 EOT
}

