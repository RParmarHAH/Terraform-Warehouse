CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_COSTALSYNCDATA_FACT_INVOICE_TRANSACTIONS("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
    BEGIN
        --*****************************************************************************************************************************
        -- NAME:  COSTALSYNCDATA_FACT_INVOICE_TRANSACTIONS
        --
        -- DEVELOPMENT LOG:
        -- DATE            AUTHOR                      NOTES:
        -- --------     -------------------  -----------------------------------------------------------------------------------------------
        -- 24/01/24 	PREETI SHARMA 		Initial Development
        --*****************************************************************************************************************************
        --
        INSERT OVERWRITE INTO STAGE.COSTALSYNCDATA_FACT_INVOICE_TRANSACTIONS
        SELECT MD5(''COSTALSYNCDATA''
            || ''-'' || TRIM(tr.db)
            || ''-'' || trim(tr.ROWID)
            || ''-'' || ''COSTALSYNCDATA'')                                AS TRANSACTION_KEY
             , tr.ROWID                                                    AS TRANSACTION_NUMBER
             , MD5(TRIM(TRANSACTIONS.DB) || ''-'' || TRIM(TRANSACTIONS.BILL_NUMBER) || ''-'' ||
                   TRIM(CHARGES.SEQUENCE_NUMBER) ||
                   ''-'' ||
                   TRIM(TRANSACTIONS.PROCCODE) || ''-'' || TRIM(TRANSACTIONS.PLAN_CODE) || ''-'' ||
                   ''COSTALSYNCDATA'')                                     AS REVENUE_KEY
             , MD5(COALESCE(SCHEDULES.SCHEDULE_NUMBER, CHARGES.SCHEDULE_NUMBER, ''-1'') || ''-'' ||
                   COALESCE(SCHEDULES.DB, CHARGES.DB, ''-1'') || ''-'' ||
                   ''COSTALSYNCDATA'')                                     AS VISIT_KEY
             , MD5(''COSTALSYNCDATA'' || ''-'' || TR.DB || ''-'' || NVL(TR.PAYMENT_CODE, ''UNKNOWN'') || ''-'' ||
                   ''COSTALSYNCDATA'')                                     AS   TRANSACTION_TYPE_KEY
             , PAID_AMOUNT                                                 AS AMOUNT
             , DATE(TR.PAYMENT_DATE)                                       AS TRANSACTION_CREATED
             , DATE(TR.PAYMENT_POST_DATE)                                  AS TRANSACTION_POSTED
             , DATE(TR.PAYMENT_DATE)                                       AS TRANSACTION_DATE
             , DATE(CHARGES.LAST_PAYMENT_DATE)                             AS FINAL_TRANSACTION_DATE
             , NULL                                                        AS CHECK_NUMBER
             , NULL                                                        AS CHECK_DATE
             , NULL                                                        AS DEPOSIT_DATE
             , NULL                                                        AS POSTED_DATE
             , TR.DB                                                       AS SYSTEM_CODE
             , CASE CHARGES.DB
                   WHEN ''SHC_ALTRUS'' THEN 1
                   WHEN ''SHC_SAVANNAH'' THEN 2
                   ELSE -1 END                                             AS SOURCE_SYSTEM_ID
             , :STR_ETL_TASK_KEY                                           AS ETL_TASK_KEY
             , :STR_ETL_TASK_KEY                                           AS ETL_INSERTED_TASK_KEY
             , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
             , CURRENT_USER                                                as ETL_INSERTED_BY
             , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
             , CURRENT_USER                                                as ETL_LAST_UPDATED_BY
             , 0                                                           as ETL_DELETED_FLAG
        FROM DISC_PROD.COSTALSYNCDATA.CV_BILLINGDATA AS TR
                 INNER JOIN DISC_PROD.COSTALSYNCDATA.CV_CHARGES AS CHARGES
                            ON CHARGES.DB = TR.DB AND CHARGES.PATIENT_NUMBER = TR.PATIENT_NUMBER AND
                               CHARGES.BILL_NUMBER = TR.BILL_NUMBER and tr.SEQUENCE_NUMBER = charges.SEQUENCE_NUMBER
                 LEFT JOIN DISC_PROD.COSTALSYNCDATA.CV_SCHEDULES AS SCHEDULES
                           ON SCHEDULES.DB = CHARGES.DB AND SCHEDULES.SCHEDULE_NUMBER = CHARGES.SCHEDULE_NUMBER
                               AND TRIM(SCHEDULES.CONFIRMED_DURATION) NOT IN ('''', ''0000'')
                 LEFT JOIN DISC_PROD.COSTALSYNCDATA.CV_BILLINGTRANSACTIONS AS TRANSACTIONS ON
                    CHARGES.DB = TRANSACTIONS.DB AND CHARGES.PATIENT_NUMBER = TRANSACTIONS.PATIENT_NUMBER AND
                    CHARGES.BILL_NUMBER = TRANSACTIONS.BILL_NUMBER;
        RETURN ''SUCCESS'';
    END ;
';