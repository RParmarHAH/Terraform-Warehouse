resource "snowflake_procedure" "DISC_WORKDAY_GET_WORKER_EXCLUDE_LIST_POST_PROCESSING" {
	name ="GET_WORKER_EXCLUDE_LIST_POST_PROCESSING"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "WORKDAY"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

 EOT
}

