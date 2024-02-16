resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_ZENDESK_FACT_TICKET" {
	name ="DELETE_STAGE_ZENDESK_FACT_TICKET"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result varchar(1000);
BEGIN
	DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_TICKET WHERE SOURCE_SYSTEM_ID = 25 AND TICKET_KEY NOT IN (SELECT TICKET_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.ZENDESK_FACT_TICKET);
  
SELECT CONCAT(''Message : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

