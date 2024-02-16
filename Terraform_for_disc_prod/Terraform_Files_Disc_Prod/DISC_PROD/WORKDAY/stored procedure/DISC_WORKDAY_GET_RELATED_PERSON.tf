resource "snowflake_procedure" "DISC_WORKDAY_GET_RELATED_PERSON" {
	name ="GET_RELATED_PERSON"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "WORKDAY"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

 EOT
}

