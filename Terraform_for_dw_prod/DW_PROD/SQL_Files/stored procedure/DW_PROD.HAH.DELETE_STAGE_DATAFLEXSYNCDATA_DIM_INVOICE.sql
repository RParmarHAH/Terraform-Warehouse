CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_DATAFLEXSYNCDATA_DIM_INVOICE()
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
		DELETE FROM DW_PROD.HAH.DIM_INVOICE WHERE SOURCE_SYSTEM_ID = 3 AND INVOICE_KEY NOT IN (SELECT INVOICE_KEY FROM DW_PROD.STAGE.VW_CURRENT_DATAFLEXSYNCDATA_DIM_INVOICE);
	else
		DELETE FROM DW_PROD.HAH.DIM_INVOICE WHERE SOURCE_SYSTEM_ID = 3 AND INVOICE_KEY IN (SELECT INVOICE_KEY FROM DW_PROD.STAGE.VW_CURRENT_DELETED_DATAFLEXSYNCDATA_DIM_INVOICE);
	end if;
	SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
end;
';