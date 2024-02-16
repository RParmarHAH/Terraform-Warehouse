CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_ZENDESK_DIM_EMPLOYEE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result varchar(1000);
BEGIN
	DELETE FROM DW_PROD.HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID = 25 AND EMPLOYEE_KEY NOT IN (SELECT EMPLOYEE_KEY FROM DW_PROD.STAGE.ZENDESK_DIM_EMPLOYEE);
  
SELECT CONCAT(''Message : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';