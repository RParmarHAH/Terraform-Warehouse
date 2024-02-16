CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_ALLIANCE_DIM_EMPLOYEE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
  BEGIN 
  DELETE FROM DW_PROD.HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID =19 AND SYSTEM_CODE = ''ALLIANCE'' AND EMPLOYEE_KEY
  NOT IN (SELECT EMPLOYEE_KEY FROM DW_PROD.STAGE.ALLIANCE_DIM_EMPLOYEE);
 RETURN ''SUCCESS'';
END; 
';