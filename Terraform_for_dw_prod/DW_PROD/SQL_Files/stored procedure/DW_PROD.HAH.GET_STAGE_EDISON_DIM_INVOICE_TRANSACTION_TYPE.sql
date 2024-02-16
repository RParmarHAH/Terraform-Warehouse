CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_EDISON_DIM_INVOICE_TRANSACTION_TYPE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- NAME:  EDISON_DIM_INVOICE_TRANSACTION_TYPE
--
-- DEVELOPMENT LOG:
-- DATE         AUTHOR                  NOTES:
-- ---------     -------------------  -----------------------------------------------------------------------------------------------
-- 01/01/23 	Pinkal Panchal 		Initial development

--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.EDISON_DIM_INVOICE_TRANSACTION_TYPE
SELECT 
DISTINCT 
MD5(''EDISON'' || ''-'' || NVL(TO_VARCHAR(TR.TRANSACTIONTYPE), ''Unknown'') || ''-'' || ''EDISON'') TRANSACTION_TYPE_KEY,
NULL AS PARENT_TRANSACTION_TYPE_KEY,
NULL  AS TRANSACTION_CODE,
TR."TRANSACTIONTYPE" AS TRANSACTION_NAME,
NULL AS TRANSACTION_DESC,
''EDISON'' AS SYSTEM_CODE,
17 AS SOURCE_SYSTEM_ID,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,                     
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
,0 as ETL_DELETED_FLAG
FROM DISC_PROD.HHAEXCHANGEEDISON.TRANSACTIONS_REPL TR
WHERE TR."TRANSACTIONTYPE" not in (''Invoice'')
;
RETURN ''SUCCESS'';
END;
';