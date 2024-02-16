resource "snowflake_procedure" "DISC_PUBLIC_BACKUP_DISC_PROD_SP" {
	name ="BACKUP_DISC_PROD_SP"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "JAVASCRIPT"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

    var today = new Date();
    var dd = String(today. getDate()). padStart(2, ''0'');
    var mm = String(today. getMonth() + 1). padStart(2, ''0''); //January is 0!
    var yyyy = today. getFullYear();
    today =  yyyy + mm + dd ;    
    var my_sql_command_1 = "CREATE DATABASE DISC_${var.SF_ENVIRONMENT}_CLONE_BACKUP_";
    var my_sql_command_1 = my_sql_command_1.concat(today," CLONE DISC_${var.SF_ENVIRONMENT};");
    var statement_1 = snowflake.createStatement( {sqlText: my_sql_command_1} );
    statement_1.execute();
  return my_sql_command_1; // Statement returned for info/debug purposes
  
 EOT
}

