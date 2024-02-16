CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_ASR_FACT_BRANCH_PAYROLL_PERIODS()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  return_result VARCHAR;
BEGIN
DELETE FROM DW_PROD.HAH.FACT_BRANCH_PAYROLL_PERIODS   WHERE BRANCH_KEY IN (SELECT BRANCH_KEY FROM DW_PROD.HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID=13) 
  AND BRANCH_PAYROLL_PERIODS_KEY 
  NOT IN (SELECT BRANCH_PAYROLL_PERIODS_KEY FROM DW_PROD."STAGE".ASR_FACT_BRANCH_PAYROLL_PERIODS);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';