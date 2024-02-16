resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_ZENDESK_FACT_CALLS" {
	name ="DELETE_STAGE_ZENDESK_FACT_CALLS"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    RETURN_RESULT VARCHAR (1000);
BEGIN
      DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_CALLS WHERE SOURCE_SYSTEM_ID = 25 AND CALL_KEY NOT IN (SELECT CALL_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.ZENDESK_FACT_CALLS);
  
  SELECT CONCAT (''MESSAGE : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
  END;

 EOT
}

