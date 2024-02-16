resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_DATAFLEXSYNCDATA_DIM_VISIT_EXCEPTION" {
	name ="DELETE_STAGE_DATAFLEXSYNCDATA_DIM_VISIT_EXCEPTION"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

	DECLARE
		return_result VARCHAR;
		get_day DATE;
	BEGIN
		DELETE FROM HAH.DIM_VISIT_EXCEPTION WHERE SOURCE_SYSTEM_ID = 3 AND EXCEPTION_KEY NOT IN (SELECT EXCEPTION_KEY FROM STAGE.DATAFLEXSYNCDATA_DIM_VISIT_EXCEPTION);
		SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
	END;

 EOT
}

