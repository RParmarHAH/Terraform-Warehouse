CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ASR_DIM_INVOICE_TRANSACTION_TYPE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- NAME:  ASR_DIM_INVOICE_TRANSACTION_TYPE
--
-- DEVELOPMENT LOG:
-- DATE            AUTHOR                      NOTES:
-- --------     -------------------  -----------------------------------------------------------------------------------------------
-- 31/01/24     Pinkal Panchal        Initial development
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.ASR_DIM_INVOICE_TRANSACTION_TYPE
SELECT 
DISTINCT 
MD5(''PRIME'' || ''-'' || NVL(TO_VARCHAR(CS.REIMBURSEMENT_STATUS_NAME), ''Unknown'') || ''-'' || ''ASR'') TRANSACTION_TYPE_KEY,
NULL AS PARENT_TRANSACTION_TYPE_KEY,
CS.REIMBURSEMENT_STATUS_ID  AS TRANSACTION_CODE,
CS.REIMBURSEMENT_STATUS_NAME  AS TRANSACTION_NAME,
NULL AS TRANSACTION_DESC,
''PRIME'' AS SYSTEM_CODE,
13 AS SOURCE_SYSTEM_ID,
-1 AS ETL_TASK_KEY,
-1 AS ETL_INSERTED_TASK_KEY,                     
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
,0 as ETL_DELETED_FLAG
FROM DISC_PROD.ASR.ASR_CLAIMSTATUSES CS
;   
RETURN ''SUCCESS'';
END;
';