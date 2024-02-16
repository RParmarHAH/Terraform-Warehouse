CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_PREFERRED_FACT_INVOICE_TRANSACTIONS("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- NAME:  PREFERRED_FACT_INVOICE_TRANSACTIONS
--
-- DEVELOPMENT LOG:
-- DATE            AUTHOR                      NOTES:
-- --------     -------------------  -----------------------------------------------------------------------------------------------
-- 12/28/23     RUTVI VYAS        Initial development
-- 09/11/23     Muhammad Zorob    Using payments table instead of transactions for invoice detail visit linkage (known issues but incremental improvement)
-- 12/01/23     Poonit Mistry (OLLION) Revert to use transactions and change join to billing checks
-- 12/14/23     Muhammad Zorob    Added billedhours/billed units to join to assoicate previously associated invoices to transactions (reach out to HHAx about mismatch servicecodeids)
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.PREFERRED_FACT_INVOICE_TRANSACTIONS
SELECT  MD5(''PREFERRED'' || ''-'' || TR.SEQ || ''-'' || ''PREFERRED'')                      AS TRANSACTION_KEY
              , TR.TRANSACTIONNUMBER::VARCHAR                                                        AS TRANSACTION_NUMBER
              , MD5(''PREFERRED'' || ''-'' || NVL(ID.INVOICEDETAILID, 0) || ''-'' || NVL(TR.VISITID, 0) || ''-'' ||
                    ''PREFERRED'')                                                                   AS REVENUE_KEY
              , MD5(''PREFERRED'' || ''-'' || NVL(TR.VISITID::STRING, 0) || ''-'' || '' PREFERRED'') AS VISIT_KEY
              , MD5(''PREFERRED'' || ''-'' || NVL(TO_VARCHAR(TR.TRANSACTIONTYPE), ''Unknown'') || ''-'' ||
                    ''PREFERRED'')                                                                      TRANSACTION_TYPE_KEY
              , NVL(CREDITAMOUNT, 0) + NVL(-1.0 * DEBITAMOUNT, 0)                                    AS AMOUNT
              , TR.CREATEDDATE                                                                       AS TRANSACTION_CREATED
              , TR.DEPOSITDATE                                                                       AS TRANSACTION_POSTED
              , TR.CHECKDATE                                                                         AS TRANSACTION_DATE
              , TR.TRANSACTIONDATE                                                                   AS FINAL_TRANSACTION_DATE
              , BC.CHECKNUMBER                                                                       AS CHECK_NUMBER
              , BC.CHECKDATE                                                                         AS CHECK_DATE
              , BC.DEPOSITDATE                                                                       AS DEPOSIT_DATE
              , BC.POSTEDDATE                                                                        AS POSTED_DATE
              , ''PREFERRED''                                                                        AS SYSTEM_CODE
              , 17                                                                                   AS SOURCE_SYSTEM_ID
              , :STR_ETL_TASK_KEY                                                              AS ETL_TASK_KEY
              , :STR_ETL_TASK_KEY                                                              AS ETL_INSERTED_TASK_KEY
              , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz                    as ETL_INSERTED_DATE
              , CURRENT_USER                                                                   as ETL_INSERTED_BY
              , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz                    as ETL_UPDATED_DATE
              , CURRENT_USER                                                                   as ETL_LAST_UPDATED_BY
              , 0                                                                              as ETL_DELETED_FLAG
FROM DISC_PROD.HHAEXCHANGEPREFERRED.TRANSACTIONS_REPL TR
         LEFT JOIN DISC_PROD.HHAEXCHANGEPREFERRED.INVOICEDETAILS ID
                   ON ID.VISITID = TR.VISITID 
                   AND ((ID.INVSERVICECODEID = TR.SERVICECODEID) OR ( ABS(TR.BILLEDHOURS - ID.BILLEDHOURS) < 5 OR ABS(TR.BILLEDUNITS - ID.BILLEDUNITS) < 5  ) )
                   AND ID.AGENCYID = TR.AGENCYID
         LEFT JOIN DISC_PROD.HHAEXCHANGEPREFERRED.BILLING_CHECKDETAILS_REPL BC ON BC.CHECKID = TR.TRANSACTIONID
WHERE TRANSACTIONTYPE != ''Invoice''
QUALIFY ROW_NUMBER() OVER (PARTITION BY TRANSACTION_KEY ORDER BY ID.INVSERVICECODEID = TR.SERVICECODEID) = 1;

;
RETURN ''SUCCESS'';
END;
';