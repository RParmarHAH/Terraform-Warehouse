CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_ALAYACARE_DIM_INVOICE_STATUS_MAPPING()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
DELETE FROM DW_PROD.HAH.DIM_INVOICE_STATUS_MAPPING WHERE SOURCE_SYSTEM_ID =9 AND INVOICE_STATUS_KEY
  NOT IN (SELECT INVOICE_STATUS_KEY FROM DW_PROD.STAGE.ALAYACARE_DIM_INVOICE_STATUS_MAPPING);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.  '') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';