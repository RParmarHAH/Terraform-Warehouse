CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_ASR_FACT_VISIT()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  return_result VARCHAR;
BEGIN
DELETE FROM DW_PROD.HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID =13 AND  SYSTEM_CODE = ''PRIME''
AND VISIT_KEY  NOT IN (SELECT VISIT_KEY FROM DW_PROD.STAGE.ASR_FACT_VISIT WHERE SOURCE_SYSTEM_ID = 13);

SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';