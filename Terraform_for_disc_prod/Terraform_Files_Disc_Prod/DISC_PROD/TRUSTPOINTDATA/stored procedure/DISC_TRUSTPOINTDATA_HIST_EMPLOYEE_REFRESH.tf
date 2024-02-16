resource "snowflake_procedure" "DISC_TRUSTPOINTDATA_HIST_EMPLOYEE_REFRESH" {
	name ="HIST_EMPLOYEE_REFRESH"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "TRUSTPOINTDATA"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT


CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.HIST_EMPLOYEES CLONE DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEES;


 EOT
}

