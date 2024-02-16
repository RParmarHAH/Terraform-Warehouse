CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_ALLIANCE_FACT_INTAKE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
  BEGIN 
  DELETE FROM DW_PROD.HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID = 19 AND SYSTEM_CODE = ''ALLIANCE'' AND INTAKE_KEY
  NOT IN (SELECT INTAKE_KEY FROM DW_PROD.STAGE.ALLIANCE_FACT_INTAKE);
RETURN ''SUCCESS'';
END;
';