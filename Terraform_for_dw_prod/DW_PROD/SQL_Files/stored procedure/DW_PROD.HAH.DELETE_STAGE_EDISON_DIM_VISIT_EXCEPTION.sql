CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_EDISON_DIM_VISIT_EXCEPTION()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
	DECLARE
	  return_result VARCHAR;
	BEGIN
		DELETE FROM DW_PROD.HAH.DIM_VISIT_EXCEPTION 
		WHERE SOURCE_SYSTEM_ID = 17 AND SYSTEM_CODE = ''EDISON''
			AND EXCEPTION_KEY NOT IN (SELECT EXCEPTION_KEY FROM DW_PROD.STAGE.EDISON_DIM_VISIT_EXCEPTION);
		SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
	END;
';