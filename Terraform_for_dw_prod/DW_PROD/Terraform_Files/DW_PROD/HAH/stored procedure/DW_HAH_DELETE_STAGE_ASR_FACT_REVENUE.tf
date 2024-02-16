resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_ASR_FACT_REVENUE" {
	name ="DELETE_STAGE_ASR_FACT_REVENUE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  return_result VARCHAR;
BEGIN
DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID = 13 AND REVENUE_KEY  NOT IN (SELECT REVENUE_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.ASR_FACT_REVENUE WHERE SOURCE_SYSTEM_ID = 13);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

