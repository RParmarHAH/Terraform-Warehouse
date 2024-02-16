resource "snowflake_function" "DW_HAH_VALIDATE_EMAIL" {
	name = "VALIDATE_EMAIL"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
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

