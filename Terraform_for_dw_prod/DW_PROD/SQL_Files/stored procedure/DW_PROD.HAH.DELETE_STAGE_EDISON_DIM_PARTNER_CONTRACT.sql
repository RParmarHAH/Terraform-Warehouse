CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_EDISON_DIM_PARTNER_CONTRACT()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    RETURN_RESULT VARCHAR;
BEGIN
DELETE FROM DW_PROD.HAH.DIM_PARTNER_CONTRACT WHERE SOURCE_SYSTEM_ID = 17 AND SYSTEM_CODE = ''EDISON''
AND PARTNER_CONTRACT_KEY NOT IN (SELECT PARTNER_CONTRACT_KEY FROM DW_PROD."STAGE".EDISON_DIM_PARTNER_CONTRACT);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';