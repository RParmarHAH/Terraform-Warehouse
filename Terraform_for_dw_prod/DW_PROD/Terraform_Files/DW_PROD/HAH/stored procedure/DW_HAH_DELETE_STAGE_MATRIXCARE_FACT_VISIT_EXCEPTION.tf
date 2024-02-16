resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_MATRIXCARE_FACT_VISIT_EXCEPTION" {
	name ="DELETE_STAGE_MATRIXCARE_FACT_VISIT_EXCEPTION"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
	return_result VARCHAR;
BEGIN
	DELETE FROM HAH.FACT_VISIT_EXCEPTION WHERE SOURCE_SYSTEM_ID = 7 AND VISIT_EXCEPTION_KEY NOT IN (SELECT VISIT_EXCEPTION_KEY FROM STAGE.VW_CURRENT_MATRIXCARE_FACT_VISIT_EXCEPTION);
	SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
end;

 EOT
}

