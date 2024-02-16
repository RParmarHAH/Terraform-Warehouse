CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_CCSI_FACT_INTAKE()
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
  sqlCmd = `DELETE FROM DW_PROD.HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID =8 AND INTAKE_KEY \\
  NOT IN (SELECT INTAKE_KEY FROM DW_PROD.STAGE.CCSI_FACT_INTAKE)`;
  sqlStmt = snowflake.createStatement( {sqlText: sqlCmd} );
  rs = sqlStmt.execute();
  return ''Done'';
';