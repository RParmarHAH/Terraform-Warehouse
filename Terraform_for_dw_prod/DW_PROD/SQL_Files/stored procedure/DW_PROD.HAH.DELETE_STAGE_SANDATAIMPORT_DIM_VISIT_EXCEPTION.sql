CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_SANDATAIMPORT_DIM_VISIT_EXCEPTION()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
	DECLARE
		return_result VARCHAR;
		get_day DATE;
	BEGIN
		DELETE FROM HAH.DIM_VISIT_EXCEPTION WHERE SOURCE_SYSTEM_ID = 4 AND EXCEPTION_KEY NOT IN (SELECT EXCEPTION_KEY FROM STAGE.SANDATAIMPORT_DIM_VISIT_EXCEPTION);
		SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
	END;
';