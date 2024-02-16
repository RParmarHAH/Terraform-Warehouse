resource "snowflake_procedure" "DISC_TRUSTPOINTDATA_EMPLOYEE_TEST" {
	name ="EMPLOYEE_TEST"
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
	execute_as = "CALLER"
	statement = <<-EOT


BEGIN
	CALL DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEES_LOAD(-1, ''1900-01-01'', ''2099-12-31'');
	CALL DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEES_CV(-1, ''1900-01-01'', ''2099-12-31'');
	CALL DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.HIST_EMPLOYEE_REFRESH(-1, ''1900-01-01'', ''2099-12-31'');
    RETURN ''Succeeded.'';
END;

 EOT
}

