resource "snowflake_procedure" "DISC_WORKDAY_GET_QUALIFICATIONS_CERTIFICATION_ACHIEVEMENT" {
	name ="GET_QUALIFICATIONS_CERTIFICATION_ACHIEVEMENT"
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

