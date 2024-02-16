CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_EDISON_DIM_INVOICE_TRANSACTION_TYPE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

	DELETE FROM DW_PROD.HAH.DIM_INVOICE_TRANSACTION_TYPE WHERE SOURCE_SYSTEM_ID = 17 AND SYSTEM_CODE ILIKE ''%EDISON%''
		   AND TRANSACTION_TYPE_KEY NOT IN (SELECT TRANSACTION_TYPE_KEY FROM DW_PROD.STAGE.EDISON_DIM_INVOICE_TRANSACTION_TYPE);

RETURN ''SUCCESS'';
END;
';