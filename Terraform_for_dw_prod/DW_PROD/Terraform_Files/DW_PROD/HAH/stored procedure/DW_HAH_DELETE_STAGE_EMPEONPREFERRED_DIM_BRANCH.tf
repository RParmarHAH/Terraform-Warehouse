resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_EMPEONPREFERRED_DIM_BRANCH" {
	name ="DELETE_STAGE_EMPEONPREFERRED_DIM_BRANCH"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  RETURN_RESULT VARCHAR;
BEGIN
		DELETE FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID = 22 AND SYSTEM_CODE LIKE ''%EMPEONPREFERRED%'' AND BRANCH_KEY NOT IN 
		(SELECT BRANCH_KEY FROM STAGE.EMPEONPREFERRED_DIM_BRANCH);
	SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN RETURN_RESULT;
END;

 EOT
}

