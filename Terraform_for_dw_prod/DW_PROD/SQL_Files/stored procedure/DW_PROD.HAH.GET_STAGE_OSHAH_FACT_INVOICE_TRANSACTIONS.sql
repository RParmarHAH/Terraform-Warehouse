CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_OSHAH_FACT_INVOICE_TRANSACTIONS("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- NAME: OSHAH_FACT_INVOICE_TRANSACTIONS
--
-- DEVELOPMENT LOG:
-- DATE         AUTHOR              NOTES:
-- --------     ------------------- -----------------------------------------------------------------------------------------------
-- 12/28/23 	PRADEEP THIPPANI 		Initial development
-- 11/29/23     POONIT MISTRY (OLLION)  ADJUSTMENT TO TRANSACTION_TYPE_KEY
-- 12/04/23     POONIT MISTRY (OLLION)  REDO JOIN LOGIC BETWEEN TRANACTIONS AND INVOICE DETAILS
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.OSHAH_FACT_INVOICE_TRANSACTIONS
SELECT DISTINCT MD5(''OSHAH'' || ''-'' || TR.SEQ || ''-'' || ''OSHAH'')                            AS TRANSACTION_KEY
              , TR.TRANSACTIONNUMBER::VARCHAR                                                      AS TRANSACTION_NUMBER
              , MD5(''OSHAH'' || ''-'' || nvl(ID.INVOICEHEADERID, -1) || ''-'' || nvl(ID.INVOICEDETAILID, 0) || ''-'' ||
                    ''HHAEXCHANGE'')                                                               AS REVENUE_KEY
              , MD5(''OSHAH'' || ''-'' || NVL(TR.VISITID::STRING, 0) || ''-'' || '' HHAEXCHANGE'') AS VISIT_KEY
              , MD5(''OSHAH'' || ''-'' || NVL(TO_VARCHAR(TR.TRANSACTIONTYPE), ''Unknown'') || ''-'' ||
                    ''OSHAH'')                                                                        TRANSACTION_TYPE_KEY
              , NVL(CREDITAMOUNT, DEBITAMOUNT)                                                     AS AMOUNT
              , TR.CREATEDDATE                                                                     AS TRANSACTION_CREATED
              , TR.DEPOSITDATE                                                                     AS TRANSACTION_POSTED
              , TR.CHECKDATE                                                                       AS TRANSACTION_DATE
              , TR.TRANSACTIONDATE                                                                 AS FINAL_TRANSACTION_DATE
              , BC.CHECKNUMBER                                                                     AS CHECK_NUMBER
              , BC.CHECKDATE                                                                       AS CHECK_DATE
              , BC.DEPOSITDATE                                                                     AS DEPOSIT_DATE
              , BC.POSTEDDATE                                                                      AS POSTED_DATE
              , CONCAT(''OSHAH - '', NVL(TRIM(OFFICE.STATE), ''NULL''))                            AS SYSTEM_CODE
              , 17                                                                                 AS SOURCE_SYSTEM_ID
              , :STR_ETL_TASK_KEY                                                                  AS ETL_TASK_KEY
              , :STR_ETL_TASK_KEY                                                                  AS ETL_INSERTED_TASK_KEY
              , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz                        as ETL_INSERTED_DATE
              , CURRENT_USER                                                                       as ETL_INSERTED_BY
              , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz                        as ETL_UPDATED_DATE
              , CURRENT_USER                                                                       as ETL_LAST_UPDATED_BY
              , 0                                                                                  as ETL_DELETED_FLAG
FROM "DISC_PROD"."HHAEXCHANGEOSHAH".TRANSACTIONS_REPL TR
         LEFT JOIN DISC_PROD.HHAEXCHANGEOSHAH.INVOICEDETAILS ID
                   ON ID.VISITID = TR.VISITID AND ID.INVSERVICECODEID = TR.SERVICECODEID AND ID.AGENCYID = TR.AGENCYID
         LEFT JOIN DISC_PROD.HHAEXCHANGEOSHAH.OFFICE_OFFICES_REPL OFFICE ON TR.OFFICEID = OFFICE.OFFICEID
         LEFT JOIN "DISC_PROD"."HHAEXCHANGEOSHAH".BILLING_CHECKDETAILS_REPL BC ON BC.CHECKID = TR.TRANSACTIONID
WHERE TRANSACTIONTYPE != ''Invoice'';
RETURN ''SUCCESS'';
END ;
';