CREATE OR REPLACE PROCEDURE DW_PROD.HAH.X_TEST()
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
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
';