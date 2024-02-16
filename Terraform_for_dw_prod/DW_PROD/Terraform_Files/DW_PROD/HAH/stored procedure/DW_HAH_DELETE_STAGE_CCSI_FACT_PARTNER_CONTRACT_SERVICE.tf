resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_CCSI_FACT_PARTNER_CONTRACT_SERVICE" {
	name ="DELETE_STAGE_CCSI_FACT_PARTNER_CONTRACT_SERVICE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    RETURN_RESULT VARCHAR;
BEGIN
DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_PARTNER_CONTRACT_SERVICE WHERE SOURCE_SYSTEM_ID = 8
AND PARTNER_CONTRACT_SERVICE_KEY  NOT IN (SELECT PARTNER_CONTRACT_SERVICE_KEY FROM DW_${var.SF_ENVIRONMENT}."STAGE".CCSI_FACT_PARTNER_CONTRACT_SERVICE);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

