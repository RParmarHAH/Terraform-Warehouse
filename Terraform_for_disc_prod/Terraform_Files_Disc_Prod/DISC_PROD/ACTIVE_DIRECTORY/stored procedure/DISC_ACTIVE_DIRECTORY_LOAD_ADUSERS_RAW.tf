resource "snowflake_procedure" "DISC_ACTIVE_DIRECTORY_LOAD_ADUSERS_RAW" {
	name ="LOAD_ADUSERS_RAW"
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

	BEGIN
        CALL DISC_${var.SF_ENVIRONMENT}.ACTIVE_DIRECTORY.ADUSERS_RAW(-1,''1900-01-01'',''2099-12-31'');
        CALL DISC_${var.SF_ENVIRONMENT}.ACTIVE_DIRECTORY.ADUSERS_RAW_CURRENT(-1,''1900-01-01'',''2099-12-31'');
		CALL DISC_${var.SF_ENVIRONMENT}.ACTIVE_DIRECTORY.HIST_ADUSERS_RAW_REFRESH(-1,''1900-01-01'',''2099-12-31'');
	END;

 EOT
}

