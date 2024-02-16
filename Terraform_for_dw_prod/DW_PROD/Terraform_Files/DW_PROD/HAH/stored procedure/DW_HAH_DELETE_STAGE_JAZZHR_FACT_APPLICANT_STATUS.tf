resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_JAZZHR_FACT_APPLICANT_STATUS" {
	name ="DELETE_STAGE_JAZZHR_FACT_APPLICANT_STATUS"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
      DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_APPLICANT_STATUS WHERE SOURCE_SYSTEM_ID = 20 AND APPLICANT_STATUS_KEY NOT IN (SELECT APPLICANT_STATUS_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.JAZZHR_FACT_APPLICANT_STATUS WHERE SOURCE_SYSTEM_ID = 20);
  SELECT CONCAT (''MESSAGE : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
  END;

 EOT
}

