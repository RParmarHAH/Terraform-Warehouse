CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_SANDATAIMPORT_DIM_VISIT_STATUS_MAPPING()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
	return_result VARCHAR;
BEGIN
	DELETE FROM DW_PROD.HAH.DIM_VISIT_STATUS_MAPPING WHERE SOURCE_SYSTEM_ID= 4 AND VISIT_STATUS_KEY NOT IN (SELECT VISIT_STATUS_KEY FROM DW_PROD.STAGE.SANDATAIMPORT_DIM_VISIT_STATUS_MAPPING);
	
	SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
end;
';