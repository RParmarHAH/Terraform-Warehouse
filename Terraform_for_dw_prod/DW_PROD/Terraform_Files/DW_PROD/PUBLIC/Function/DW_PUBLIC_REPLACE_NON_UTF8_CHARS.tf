resource "snowflake_function" "DW_PUBLIC_REPLACE_NON_UTF8_CHARS" {
	name = "REPLACE_NON_UTF8_CHARS"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "JAVASCRIPT"

	arguments {
		name = "STR"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	statement = <<-EOT
  
  return STR.replace(/[^ -~]+/g, '')    

 EOT
}

