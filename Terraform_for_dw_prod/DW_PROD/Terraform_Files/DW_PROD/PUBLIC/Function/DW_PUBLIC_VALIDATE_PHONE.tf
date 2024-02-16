resource "snowflake_function" "DW_PUBLIC_VALIDATE_PHONE" {
	name = "VALIDATE_PHONE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "SQL"

	arguments {
		name = "PHONE"
		type = "NUMBER(38"
}	
	return_type = "BOOLEAN"
	statement = <<-EOT

REGEXP_LIKE (phone,'^[\\\\+1-9-]{10}*$')

 EOT
}

