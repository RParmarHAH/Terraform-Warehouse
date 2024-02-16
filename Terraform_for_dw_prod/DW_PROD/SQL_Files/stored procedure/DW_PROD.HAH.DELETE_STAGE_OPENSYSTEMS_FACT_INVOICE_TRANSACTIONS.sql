CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DELETE_STAGE_OPENSYSTEMS_FACT_INVOICE_TRANSACTIONS()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

	DELETE FROM DW_PROD.HAH.FACT_INVOICE_TRANSACTIONS WHERE SOURCE_SYSTEM_ID =17 AND SYSTEM_CODE LIKE ''%OPENSYSTEMS%''
		   AND TRANSACTION_KEY NOT IN (SELECT TRANSACTION_KEY FROM DW_PROD.STAGE.OPENSYSTEMS_FACT_INVOICE_TRANSACTIONS);

RETURN ''SUCCESS'';
END;
';