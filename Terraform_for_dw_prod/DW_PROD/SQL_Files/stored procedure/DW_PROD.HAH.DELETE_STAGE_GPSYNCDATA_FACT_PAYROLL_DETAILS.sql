CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_GPSYNCDATA_FACT_PAYROLL_DETAILS()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
	return ''Message : Done'';
END;
';