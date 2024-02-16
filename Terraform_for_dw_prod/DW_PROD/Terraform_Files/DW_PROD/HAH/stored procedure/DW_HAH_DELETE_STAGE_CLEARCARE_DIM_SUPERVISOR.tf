resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_CLEARCARE_DIM_SUPERVISOR" {
	name ="DELETE_STAGE_CLEARCARE_DIM_SUPERVISOR"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  return_result VARCHAR;
BEGIN
DELETE FROM HAH.DIM_SUPERVISOR WHERE SOURCE_SYSTEM_ID =16 AND SYSTEM_CODE = ''CLEARCARE'' AND SUPERVISOR_KEY
 NOT IN (SELECT SUPERVISOR_KEY FROM STAGE.CLEARCARE_DIM_SUPERVISOR);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

