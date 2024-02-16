CREATE OR REPLACE PROCEDURE DISC_PROD.PUBLIC.BACKUP_DISC_PROD_SP()
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
    var today = new Date();
    var dd = String(today. getDate()). padStart(2, ''0'');
    var mm = String(today. getMonth() + 1). padStart(2, ''0''); //January is 0!
    var yyyy = today. getFullYear();
    today =  yyyy + mm + dd ;    
    var my_sql_command_1 = "CREATE DATABASE DISC_PROD_CLONE_BACKUP_";
    var my_sql_command_1 = my_sql_command_1.concat(today," CLONE DISC_PROD;");
    var statement_1 = snowflake.createStatement( {sqlText: my_sql_command_1} );
    statement_1.execute();
  return my_sql_command_1; // Statement returned for info/debug purposes
  ';