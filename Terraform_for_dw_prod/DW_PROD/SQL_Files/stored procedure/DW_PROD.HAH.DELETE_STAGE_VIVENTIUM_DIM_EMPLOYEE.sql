CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_VIVENTIUM_DIM_EMPLOYEE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
DELETE FROM HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID = 34 AND EMPLOYEE_KEY
    NOT IN (SELECT EMPLOYEE_KEY FROM STAGE.VIVENTIUM_DIM_EMPLOYEE);
 return ''Done'';
END; 

 
';