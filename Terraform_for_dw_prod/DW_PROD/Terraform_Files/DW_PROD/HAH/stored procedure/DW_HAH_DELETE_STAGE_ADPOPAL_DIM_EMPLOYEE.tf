resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_ADPOPAL_DIM_EMPLOYEE" {
	name ="DELETE_STAGE_ADPOPAL_DIM_EMPLOYEE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  RETURN_RESULT VARCHAR;
BEGIN
		DELETE FROM HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID = 18 AND SYSTEM_CODE LIKE ''%ADP-OPAL%'' AND EMPLOYEE_KEY NOT IN 
		(SELECT EMPLOYEE_KEY FROM STAGE.ADPOPAL_DIM_EMPLOYEE);
	SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN RETURN_RESULT;
END;

 EOT
}

