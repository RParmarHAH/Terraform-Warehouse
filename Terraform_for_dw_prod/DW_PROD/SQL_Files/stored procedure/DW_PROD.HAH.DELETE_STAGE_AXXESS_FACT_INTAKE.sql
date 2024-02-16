CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_AXXESS_FACT_INTAKE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
DELETE FROM DW_PROD.HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID =14 AND SYSTEM_CODE = ''PRIME'' AND INTAKE_KEY
  NOT IN (SELECT INTAKE_KEY FROM DW_PROD.STAGE.AXXESS_FACT_INTAKE);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.  '') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';