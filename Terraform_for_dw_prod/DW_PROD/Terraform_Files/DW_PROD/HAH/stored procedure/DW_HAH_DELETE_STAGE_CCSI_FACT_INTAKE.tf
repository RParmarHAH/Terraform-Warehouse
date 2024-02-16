resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_CCSI_FACT_INTAKE" {
	name ="DELETE_STAGE_CCSI_FACT_INTAKE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "JAVASCRIPT"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

  sqlCmd = `DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID =8 AND INTAKE_KEY \\
  NOT IN (SELECT INTAKE_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.CCSI_FACT_INTAKE)`;
  sqlStmt = snowflake.createStatement( {sqlText: sqlCmd} );
  rs = sqlStmt.execute();
  return ''Done'';

 EOT
}

