CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_CLEARCARE_DIM_INVOICE_STATUS_MAPPING("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 20/03/23    Pinkal Panchal        Initial Development
-- 15/09/23    Pradeep Thippani      Changed invoice_status logic for PAID and PARTIAL_PAY
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_PROD.STAGE.CLEARCARE_DIM_INVOICE_STATUS_MAPPING
SELECT DISTINCT
	16 AS SOURCE_SYSTEM_ID,
	''CLEARCARE'' AS SYSTEM_CODE,
	CASE WHEN INV.PAYMENTS_TOTAL = 0 THEN ''BILLED''
         WHEN INV.PAYMENTS_TOTAL > 0 AND INV.OUTSTANDING_BALANCE <= 0  THEN ''PAID''
		 WHEN INV.PAYMENTS_TOTAL > 0 AND INV.OUTSTANDING_BALANCE > 0  THEN ''PARTIAL PAY''
--		WHEN INV.OUTSTANDING_BALANCE = 0 AND INV.PAYMENTS_TOTAL <> 0 THEN ''PAID''
--		WHEN INV.TOTAL <> INV.PAYMENTS_TOTAL THEN ''PARTIAL PAY''
-- Changes made on 15/09/2023 for RCM
	ELSE ''UNKNOWN'' END AS DERIVED_INVOICE_STATUS,
	MD5(SOURCE_SYSTEM_ID || ''-'' || DERIVED_INVOICE_STATUS || ''-'' || SYSTEM_CODE) AS INVOICE_STATUS_KEY
	,
       ---- ETL FIELDS
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,                     
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY
FROM DISC_PROD.CLEARCARE.INVOICE_TRANSACTION INV
;
RETURN ''SUCCESS'';
END;
';