resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_CCSI_DIM_SERVICES" {
	name ="DELETE_STAGE_CCSI_DIM_SERVICES"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  return_result VARCHAR;
BEGIN
	
DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_SERVICES WHERE SOURCE_SYSTEM_ID =8 AND SERVICE_KEY
 NOT IN (SELECT SERVICE_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.CCSI_DIM_SERVICES);

SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

