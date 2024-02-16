CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_DATAFLEXSYNCDATA_FACT_VISIT_EXCEPTION()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
	day_Of_Week int;
	return_result VARCHAR;
BEGIN
	SELECT dayofweek(current_timestamp()) into day_Of_Week;
	if (day_Of_Week = 0) then
		DELETE FROM HAH.FACT_VISIT_EXCEPTION WHERE SOURCE_SYSTEM_ID IN (3) AND VISIT_EXCEPTION_KEY NOT IN (SELECT VISIT_EXCEPTION_KEY FROM STAGE.VW_CURRENT_DATAFLEXSYNCDATA_FACT_VISIT_EXCEPTION);
	else
		DELETE FROM HAH.FACT_VISIT_EXCEPTION WHERE SOURCE_SYSTEM_ID IN (3) AND VISIT_EXCEPTION_KEY IN (SELECT VISIT_EXCEPTION_KEY FROM STAGE.VW_CURRENT_DELETED_DATAFLEXSYNCDATA_FACT_VISIT_EXCEPTION);
	end if;
	SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
end;
';