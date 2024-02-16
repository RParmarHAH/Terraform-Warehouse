resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_CCSI_DIM_EMPLOYEE" {
	name ="DELETE_STAGE_CCSI_DIM_EMPLOYEE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "JAVASCRIPT"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

  sqlCmd = `DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID =8 AND EMPLOYEE_KEY \\
  NOT IN (SELECT EMPLOYEE_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.CCSI_DIM_EMPLOYEE)`;
  sqlStmt = snowflake.createStatement( {sqlText: sqlCmd} );
  rs = sqlStmt.execute();
  return ''Done'';

 EOT
}

