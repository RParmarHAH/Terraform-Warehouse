CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_CLEARCARE_DIM_INVOICE_TRANSACTION_TYPE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- NAME:  CLEARCARE_DIM_INVOICE_TRANSACTION_TYPE
--
-- DEVELOPMENT LOG:
-- DATE            AUTHOR                      NOTES:
-- --------   -------------------    -----------------------------------------------------------------------------------------------
-- 24/01/24 	   Pradeep Thippani 		Initial development
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.CLEARCARE_DIM_INVOICE_TRANSACTION_TYPE
SELECT DISTINCT
MD5(''CLEARCARE'' ||''-''||  nvl(PAYMENT_TYPE,-1) ||''-''|| ''CLEARCARE'') AS TRANSACTION_TYPE_KEY,
NULL AS PARENT_TRANSACTION_TYPE_KEY,
nvl(PAYMENT_TYPE::STRING,''UNKNOWN'') AS  TRANSACTION_CODE,
CASE WHEN PAYMENT_TYPE = 5 THEN ''ADJUSTMENT''
     WHEN PAYMENT_TYPE = 2000 THEN ''PAYMENT''
ELSE ''UNKNOWN'' END AS TRANSACTION_NAME,
NULL  AS TRANSACTION_DESC,
''CLEARCARE'' AS SYSTEM_CODE,
16 AS SOURCE_SYSTEM_ID,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,                     
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
,0 as ETL_DELETED_FLAG
FROM DISC_PROD.CLEARCARE.PAYMENT_TRANSACTION;
RETURN ''SUCCESS'';
END;
';