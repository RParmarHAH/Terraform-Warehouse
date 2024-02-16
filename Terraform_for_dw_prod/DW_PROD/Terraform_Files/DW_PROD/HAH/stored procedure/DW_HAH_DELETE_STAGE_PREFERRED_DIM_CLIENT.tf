resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_PREFERRED_DIM_CLIENT" {
	name ="DELETE_STAGE_PREFERRED_DIM_CLIENT"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  return_result VARCHAR;
BEGIN
DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_CLIENT WHERE SOURCE_SYSTEM_ID =17 AND SYSTEM_CODE = ''PREFERRED'' AND CLIENT_KEY NOT IN (SELECT CLIENT_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.PREFERRED_DIM_CLIENT);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

