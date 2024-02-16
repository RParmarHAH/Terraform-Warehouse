resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_ZENDESK_FACT_SLA" {
	name ="DELETE_STAGE_ZENDESK_FACT_SLA"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    RETURN_RESULT VARCHAR (1000);
BEGIN
      DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_SLA WHERE SOURCE_SYSTEM_ID = 25 AND TICKET_SLA_KEY NOT IN (SELECT TICKET_SLA_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.ZENDESK_FACT_SLA);
  
  SELECT CONCAT (''MESSAGE : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
  END;

 EOT
}

