resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_CLEARCARE_DIM_SERVICES_1_0" {
	name ="DELETE_STAGE_CLEARCARE_DIM_SERVICES_1_0"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  return_result VARCHAR;
BEGIN
DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_SERVICES_1_0 WHERE SOURCE_SYSTEM_ID =16 AND SYSTEM_CODE = ''CLEARCARE'' AND SERVICE_KEY
 NOT IN (SELECT SERVICE_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.CLEARCARE_DIM_SERVICES_1_0);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

