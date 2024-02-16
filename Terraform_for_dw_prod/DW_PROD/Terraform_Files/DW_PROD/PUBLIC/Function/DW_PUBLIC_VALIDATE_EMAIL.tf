resource "snowflake_function" "DW_PUBLIC_VALIDATE_EMAIL" {
	name = "VALIDATE_EMAIL"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "SQL"

	arguments {
		name = "STR"
		type = "VARCHAR(16777216)"
}	
	return_type = "BOOLEAN"
	statement = <<-EOT
  
  rlike(STR,'\\\\w+@[a-zA-Z_]+?\\.[a-zA-Z]{2,3}')

 EOT
}

