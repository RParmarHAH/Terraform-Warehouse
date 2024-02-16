CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_MATRIXCARE_DIM_INVOICE_VISIT_LINKAGE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
DELETE FROM DW_PROD.HAH.DIM_INVOICE_VISIT_LINKAGE WHERE SOURCE_SYSTEM_ID=7  AND REVENUE_KEY 
  NOT IN (SELECT REVENUE_KEY  FROM DW_PROD.STAGE.MATRIXCARE_DIM_INVOICE_VISIT_LINKAGE);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.  '') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';