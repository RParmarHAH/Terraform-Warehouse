CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_OSHAH_DIM_SERVICES_1_0()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
  DELETE FROM DW_PROD.HAH.DIM_SERVICES_1_0 WHERE SOURCE_SYSTEM_ID =17 AND SYSTEM_CODE LIKE ''%OSHAH%'' AND SERVICE_KEY
  NOT IN (SELECT SERVICE_KEY FROM DW_PROD.STAGE.OSHAH_DIM_SERVICES_1_0);
  
RETURN ''SUCCESS'';
END;
';