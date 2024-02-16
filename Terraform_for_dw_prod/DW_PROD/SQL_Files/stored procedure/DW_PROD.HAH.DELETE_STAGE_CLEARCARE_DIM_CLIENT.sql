CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_CLEARCARE_DIM_CLIENT()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  return_result VARCHAR;
BEGIN
DELETE FROM HAH.DIM_CLIENT WHERE SOURCE_SYSTEM_ID =16 AND SYSTEM_CODE = ''CLEARCARE'' AND CLIENT_KEY
 NOT IN (SELECT CLIENT_KEY FROM STAGE.CLEARCARE_DIM_CLIENT);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';