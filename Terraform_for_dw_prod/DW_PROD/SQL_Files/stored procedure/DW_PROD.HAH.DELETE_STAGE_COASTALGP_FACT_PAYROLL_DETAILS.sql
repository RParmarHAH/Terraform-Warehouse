CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_COASTALGP_FACT_PAYROLL_DETAILS()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  RETURN_RESULT VARCHAR;
BEGIN
	DELETE FROM HAH.FACT_PAYROLL_DETAILS WHERE SOURCE_SYSTEM_ID = 11 AND PAYROLL_DETAIL_KEY
    NOT IN (SELECT PAYROLL_DETAIL_KEY FROM STAGE.COASTALGP_FACT_PAYROLL_DETAILS);
   
	SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN RETURN_RESULT;
END;
';