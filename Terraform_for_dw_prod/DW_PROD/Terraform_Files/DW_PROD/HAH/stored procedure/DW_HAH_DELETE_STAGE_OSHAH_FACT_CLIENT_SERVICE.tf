resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_OSHAH_FACT_CLIENT_SERVICE" {
	name ="DELETE_STAGE_OSHAH_FACT_CLIENT_SERVICE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  return_result VARCHAR;
BEGIN
	
DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_CLIENT_SERVICE WHERE SOURCE_SYSTEM_ID =17 AND SYSTEM_CODE ILIKE ''%OSHAH%'' AND CLIENT_SERVICE_KEY 
 NOT IN (SELECT CLIENT_SERVICE_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.OSHAH_FACT_CLIENT_SERVICE);

SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

