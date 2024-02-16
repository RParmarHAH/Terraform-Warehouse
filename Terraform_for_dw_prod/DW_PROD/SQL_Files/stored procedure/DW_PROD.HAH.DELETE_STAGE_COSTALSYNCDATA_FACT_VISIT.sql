CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_COSTALSYNCDATA_FACT_VISIT()
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
		DELETE FROM DW_PROD.HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID IN (1,2) AND VISIT_KEY NOT IN (SELECT VISIT_KEY FROM DW_PROD.STAGE.VW_CURRENT_COSTALSYNCDATA_FACT_VISIT);
	else 
		DELETE FROM DW_PROD.HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID IN (1,2) AND VISIT_KEY IN (SELECT VISIT_KEY FROM DW_PROD.STAGE.VW_CURRENT_DELETED_COSTALSYNCDATA_FACT_VISIT);
	end if;
	SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
end;
';