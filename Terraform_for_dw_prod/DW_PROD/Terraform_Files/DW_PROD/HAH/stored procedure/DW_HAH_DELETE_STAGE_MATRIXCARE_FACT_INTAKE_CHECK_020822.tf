resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_MATRIXCARE_FACT_INTAKE_CHECK_020822" {
	name ="DELETE_STAGE_MATRIXCARE_FACT_INTAKE_CHECK_020822"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "JAVASCRIPT"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

  var now = new Date();
  var dayOfWeek = 0;
  if (dayOfWeek == 0) 
  {
    sqlCmd = `DELETE FROM HAH.FACT_INTAKE_BKP_AFTR_DLT_020822 WHERE SOURCE_SYSTEM_ID IN (7) AND INTAKE_KEY \\
    NOT IN (SELECT INTAKE_KEY FROM STAGE.VW_CURRENT_MATRIXCARE_FACT_INTAKE)`;
  }
  else
  {
     sqlCmd = `DELETE FROM HAH.FACT_INTAKE_BKP_AFTR_DLT_020822 WHERE SOURCE_SYSTEM_ID IN (7) AND INTAKE_KEY \\
     IN (SELECT INTAKE_KEY FROM STAGE.VW_CURRENT_DELETED_MATRIXCARE_FACT_INTAKE)`;
  }
  sqlStmt = snowflake.createStatement( {sqlText: sqlCmd} );
  rs = sqlStmt.execute();
  return ''Done'';

 EOT
}

