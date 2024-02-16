resource "snowflake_procedure" "DW_HAH_X_TEST" {
	name ="X_TEST"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "JAVASCRIPT"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

  var now = new Date();
  var dayOfWeek = 0;
  if (dayOfWeek = 0) 
  {
    sqlCmd = `select 1`
  }
  else
  {
     sqlCmd = `select 0`
  }
sqlStmt = snowflake.createStatement( {sqlText: sqlCmd} );
  rs = sqlStmt.execute();
  return ''Done'';

 EOT
}

