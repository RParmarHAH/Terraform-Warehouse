resource "snowflake_procedure" "DW_INTEGRATION_GET_DIM_EMPLOYEE_MATCH" {
	name ="GET_DIM_EMPLOYEE_MATCH"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
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
        CALL DW_${var.SF_ENVIRONMENT}.INTEGRATION.GET_EMP_MATCH_GA(-1, ''1900-01-01'', ''2099-12-31'');

        CALL DW_${var.SF_ENVIRONMENT}.INTEGRATION.GET_DIM_EMPLOYEE_MATCH_CCSI_DFLEX_IL(-1, ''1900-01-01'', ''2099-12-31'');

		RETURN ''SUCCEED'';
		
	END;

 EOT
}

