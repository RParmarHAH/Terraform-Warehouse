resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_JAZZHR_DIM_JOB" {
	name ="DELETE_STAGE_JAZZHR_DIM_JOB"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
      DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_JOB WHERE SOURCE_SYSTEM_ID = 20 AND JOB_KEY NOT IN (SELECT JOB_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.JAZZHR_DIM_JOB WHERE SOURCE_SYSTEM_ID = 20);
  SELECT CONCAT (''MESSAGE : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
  END;

 EOT
}

