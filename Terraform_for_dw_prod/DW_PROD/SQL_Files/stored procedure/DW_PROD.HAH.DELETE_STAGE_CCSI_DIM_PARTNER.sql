CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_CCSI_DIM_PARTNER()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    RETURN_RESULT VARCHAR;
BEGIN
DELETE FROM DW_PROD.HAH.DIM_PARTNER WHERE SOURCE_SYSTEM_ID = 8
AND PARTNER_KEY NOT IN (SELECT PARTNER_KEY FROM DW_PROD."STAGE".CCSI_DIM_PARTNER);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';