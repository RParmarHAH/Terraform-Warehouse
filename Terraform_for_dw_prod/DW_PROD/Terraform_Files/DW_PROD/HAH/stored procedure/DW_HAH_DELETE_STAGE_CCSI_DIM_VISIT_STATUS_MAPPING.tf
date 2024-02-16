resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_CCSI_DIM_VISIT_STATUS_MAPPING" {
	name ="DELETE_STAGE_CCSI_DIM_VISIT_STATUS_MAPPING"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "JAVASCRIPT"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

  sqlCmd = `DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_VISIT_STATUS_MAPPING WHERE SOURCE_SYSTEM_ID= 8 AND VISIT_STATUS_KEY \\
  NOT IN (SELECT VISIT_STATUS_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.CCSI_DIM_VISIT_STATUS_MAPPING)`;
  sqlStmt = snowflake.createStatement( {sqlText: sqlCmd} );
  rs = sqlStmt.execute();
  return ''Done'';

 EOT
}

