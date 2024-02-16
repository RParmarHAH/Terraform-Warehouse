resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_ALLIANCE_DIM_PARTNER_CONTRACT" {
	name ="DELETE_STAGE_ALLIANCE_DIM_PARTNER_CONTRACT"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  return_result VARCHAR;
BEGIN
	
DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_PARTNER_CONTRACT WHERE SOURCE_SYSTEM_ID =19 AND PARTNER_CONTRACT_KEY
 NOT IN (SELECT PARTNER_CONTRACT_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.ALLIANCE_DIM_PARTNER_CONTRACT);

SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

