CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_OPENSYSTEMS_DIM_INVOICE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN 
DELETE FROM DW_PROD.HAH.DIM_INVOICE WHERE SOURCE_SYSTEM_ID =17 AND SYSTEM_CODE IN (''OPENSYSTEMS - PA'', ''OPENSYSTEMS - DE'') AND INVOICE_KEY
  NOT IN (SELECT INVOICE_KEY FROM DW_PROD.STAGE.OPENSYSTEMS_DIM_INVOICE);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.  '') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result; 
END;
';