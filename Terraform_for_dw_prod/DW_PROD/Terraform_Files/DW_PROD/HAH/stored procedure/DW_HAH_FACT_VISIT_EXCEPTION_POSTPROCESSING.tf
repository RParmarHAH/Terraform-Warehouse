resource "snowflake_procedure" "DW_HAH_FACT_VISIT_EXCEPTION_POSTPROCESSING" {
	name ="FACT_VISIT_EXCEPTION_POSTPROCESSING"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
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

	DECLARE
		return_result VARCHAR;
	BEGIN
		DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT_EXCEPTION WHERE VISIT_KEY NOT IN (SELECT VISIT_KEY FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT);
	
		SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

	RETURN return_result;
	END;

 EOT
}

