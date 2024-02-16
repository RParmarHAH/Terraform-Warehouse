resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_ALAYACARE_FACT_ADMISSION" {
	name ="DELETE_STAGE_ALAYACARE_FACT_ADMISSION"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  return_result VARCHAR;
BEGIN
	
DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_ADMISSION WHERE SOURCE_SYSTEM_ID =9 AND CLIENT_ADMISSION_KEY 
 NOT IN (SELECT CLIENT_ADMISSION_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.ALAYACARE_FACT_ADMISSION);

SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

