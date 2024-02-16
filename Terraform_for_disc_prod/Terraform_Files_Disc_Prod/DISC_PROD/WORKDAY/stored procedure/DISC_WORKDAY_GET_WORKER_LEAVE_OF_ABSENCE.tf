resource "snowflake_procedure" "DISC_WORKDAY_GET_WORKER_LEAVE_OF_ABSENCE" {
	name ="GET_WORKER_LEAVE_OF_ABSENCE"
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

