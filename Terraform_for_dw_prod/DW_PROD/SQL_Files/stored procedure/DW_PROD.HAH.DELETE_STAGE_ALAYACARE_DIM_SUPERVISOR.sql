CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_ALAYACARE_DIM_SUPERVISOR()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    RETURN_RESULT VARCHAR (1000);
BEGIN
       DELETE FROM DW_PROD.HAH.DIM_SUPERVISOR WHERE SOURCE_SYSTEM_ID = 9 AND SUPERVISOR_KEY NOT IN (SELECT SUPERVISOR_KEY FROM DW_PROD.STAGE.ALAYACARE_DIM_SUPERVISOR WHERE SOURCE_SYSTEM_ID = 9);
  
  SELECT CONCAT (''MESSAGE : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
  END;
';