CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_PREFERRED_FACT_REVENUE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  return_result VARCHAR;
BEGIN
DELETE FROM DW_PROD.HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID =17 AND SYSTEM_CODE = ''PREFERRED'' AND REVENUE_KEY NOT IN (SELECT REVENUE_KEY FROM DW_PROD.STAGE.PREFERRED_FACT_REVENUE);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';