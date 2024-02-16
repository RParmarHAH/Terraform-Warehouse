CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_OSHAH_DIM_VISIT_STATUS_MAPPING()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
DELETE FROM DW_PROD.HAH.DIM_VISIT_STATUS_MAPPING WHERE SOURCE_SYSTEM_ID =17 AND SYSTEM_CODE ILIKE ''%OSHAH%'' AND VISIT_STATUS_KEY
  NOT IN (SELECT VISIT_STATUS_KEY FROM DW_PROD.STAGE.OSHAH_DIM_VISIT_STATUS_MAPPING);
RETURN ''SUCCESS'';
END;
';