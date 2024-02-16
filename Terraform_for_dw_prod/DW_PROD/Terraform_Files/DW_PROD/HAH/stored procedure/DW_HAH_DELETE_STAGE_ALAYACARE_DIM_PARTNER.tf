resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_ALAYACARE_DIM_PARTNER" {
	name ="DELETE_STAGE_ALAYACARE_DIM_PARTNER"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
	return_result varchar(1000);
BEGIN 
	DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_PARTNER WHERE SOURCE_SYSTEM_ID = 9 AND PARTNER_KEY NOT IN (SELECT PARTNER_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.ALAYACARE_DIM_PARTNER WHERE SOURCE_SYSTEM_ID = 9);

  SELECT CONCAT(''Message : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
  return return_result;
 
END;

 EOT
}

