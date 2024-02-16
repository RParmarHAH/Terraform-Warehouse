resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_COASTALSYNCDATA_DIM_VISIT_STATUS_MAPPING" {
	name ="DELETE_STAGE_COASTALSYNCDATA_DIM_VISIT_STATUS_MAPPING"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result varchar(1000);
BEGIN
	DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_VISIT_STATUS_MAPPING WHERE SOURCE_SYSTEM_ID IN (1,2) AND VISIT_KEY NOT IN (SELECT VISIT_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.COASTALSYNCDATA_DIM_VISIT_STATUS_MAPPING WHERE SOURCE_SYSTEM_ID IN (1,2));
  
  SELECT CONCAT(''Message : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
  return return_result;
END;

 EOT
}

