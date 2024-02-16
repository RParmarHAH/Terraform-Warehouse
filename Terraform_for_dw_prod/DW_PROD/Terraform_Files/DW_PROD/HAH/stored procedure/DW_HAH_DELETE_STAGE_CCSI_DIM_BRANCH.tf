resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_CCSI_DIM_BRANCH" {
	name ="DELETE_STAGE_CCSI_DIM_BRANCH"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "JAVASCRIPT"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

  sqlCmd = `DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID =8 AND BRANCH_KEY \\
  NOT IN (SELECT BRANCH_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.CCSI_DIM_BRANCH)`;
  sqlStmt = snowflake.createStatement( {sqlText: sqlCmd} );
  rs = sqlStmt.execute();
  return ''Done'';

 EOT
}

