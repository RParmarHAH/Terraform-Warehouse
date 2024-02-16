CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_CLEARCARE_FACT_INVOICE_TRANSACTIONS("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- NAME:  CLEARCARE_FACT_INVOICE_TRANSACTIONS
--
-- DEVELOPMENT LOG:
-- DATE         AUTHOR              NOTES:
-- --------     ------------------- -----------------------------------------------------------------------------------------------
-- 28/12/23     Pradeep Thippani     Initial developement
-- 24/01/24     Pradeep Thippani     Updated transaction_type_key logic
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.CLEARCARE_FACT_INVOICE_TRANSACTIONS
SELECT 
    MD5(''CLEARCARE'' || ''-'' || PD.ID::STRING || ''-'' || NVL(IC.CARELOG_ID,-1) || ''-'' || ''CLEARCARE'') AS TRANSACTION_KEY,
    PD.ID AS TRNSACTION_NUMBER,
    MD5(''CLEARCARE'' ||''-''|| INV.ID ||''-''|| nvl(IC.CARELOG_ID,''-1'') ||''-''|| ''CLEARCARE'') AS REVENUE_KEY,
    MD5(nvl(CA.AGENCY_ID,''-1'') || ''-'' || nvl(CA.ID,''-1'') || ''-'' || '' CLEARCARE'') AS VISIT_KEY,
    MD5(''CLEARCARE'' ||''-''||  nvl(PT.PAYMENT_TYPE,-1) ||''-''|| ''CLEARCARE'') AS TRANSACTION_TYPE_KEY,
    ((PD.AMOUNT /count(*) over (partition by PD.INVOICE_ID  order by 1))*count(1) over (partition by CA.ID  order by 1)) AS AMOUNT,
    DATE(PT.CREATED) AS  TRANSACTION_CREATED,
    NULL AS TRANSACTION_POSTED ,
    PT.TRANSACTION_DATE AS TRANSACTION_DATE,
    NULL AS FINAL_TRANSACTION_DATE,
    NULL AS CHECK_NUMBER,
    NULL AS CHECK_DATE ,
    NULL AS DEPOSIT_DATE ,
    NULL AS POSTED_DATE ,
    ''CLEARCARE'' AS SYSTEM_CODE,
    16 AS SOURCE_SYSTEM_ID,
    -1 AS ETL_TASK_KEY,
    -1 AS ETL_INSERTED_TASK_KEY,                     
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
    ,CURRENT_USER as ETL_INSERTED_BY
    ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
    ,CURRENT_USER as ETL_LAST_UPDATED_BY
    ,0 as ETL_DELETED_FLAG
FROM DISC_PROD.CLEARCARE.RECEIVABLES_PAYMENTDESIGNATION PD 
LEFT JOIN DISC_PROD.CLEARCARE.PAYMENT_TRANSACTION PT  ON PT.ID = PD.PAYMENT_ID
LEFT JOIN DISC_PROD.CLEARCARE.INVOICE_TRANSACTION INV ON PD.INVOICE_ID = INV.ID 
LEFT JOIN DISC_PROD.CLEARCARE.RECEIVABLES_INVOICE_CARELOGS  IC ON IC.INVOICE_ID = PD.INVOICE_ID
LEFT JOIN DISC_PROD.CLEARCARE.CARELOGS_CARELOG  CA ON CA.ID = IC.CARELOG_ID
;   
RETURN ''SUCCESS'';
END;
';