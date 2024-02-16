resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_CCSI_DIM_INVOICE" {
	name ="DELETE_STAGE_CCSI_DIM_INVOICE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "JAVASCRIPT"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

   sqlCmd = `DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_INVOICE WHERE SOURCE_SYSTEM_ID = 8 AND INVOICE_KEY \\
    NOT IN (SELECT INVOICE_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.CCSI_DIM_INVOICE)`;
    sqlStmt = snowflake.createStatement( {sqlText: sqlCmd} );
  rs = sqlStmt.execute();
  return ''Done'';

 EOT
}

