CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_OSH_DIM_CLIENT()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
	return ''Message : Done'';
end;
';