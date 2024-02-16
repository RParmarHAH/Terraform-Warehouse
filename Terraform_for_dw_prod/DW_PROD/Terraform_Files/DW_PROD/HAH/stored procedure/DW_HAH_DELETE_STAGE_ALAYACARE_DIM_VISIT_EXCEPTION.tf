resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_ALAYACARE_DIM_VISIT_EXCEPTION" {
	name ="DELETE_STAGE_ALAYACARE_DIM_VISIT_EXCEPTION"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

	DECLARE
	  return_result VARCHAR;
	BEGIN
		DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_VISIT_EXCEPTION 
		WHERE SOURCE_SYSTEM_ID = 9 
			AND EXCEPTION_KEY NOT IN (SELECT EXCEPTION_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.ALAYACARE_DIM_VISIT_EXCEPTION);
		SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
	END;

 EOT
}

