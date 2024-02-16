resource "snowflake_procedure" "DISC_ACTIVE_DIRECTORY_HIST_ADUSERS_RAW_REFRESH" {
	name ="HIST_ADUSERS_RAW_REFRESH"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ACTIVE_DIRECTORY"
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


CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.ACTIVE_DIRECTORY.HIST_ADUSERS_RAW CLONE DISC_${var.SF_ENVIRONMENT}.ACTIVE_DIRECTORY.ADUSERS_RAW_CURRENT;


 EOT
}

