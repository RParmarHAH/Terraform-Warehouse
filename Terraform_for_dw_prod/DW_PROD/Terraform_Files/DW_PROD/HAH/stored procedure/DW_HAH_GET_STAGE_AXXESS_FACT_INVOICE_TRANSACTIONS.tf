resource "snowflake_procedure" "DW_HAH_GET_STAGE_AXXESS_FACT_INVOICE_TRANSACTIONS" {
	name ="GET_STAGE_AXXESS_FACT_INVOICE_TRANSACTIONS"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

    BEGIN
        --*****************************************************************************************************************************
        -- NAME:  AXXESS_FACT_INVOICE_TRANSACTIONS
        --
        -- DEVELOPMENT LOG:
        -- DATE                AUTHOR                 NOTES:
        -- --------     -------------------    -----------------------------------------------------------------------------------------------
        -- 1/15/2024     POONIT MISTRY (OLLION) INITIAL DEVELOPMENT
        -- *****************************************************************************************************************************
        --
        INSERT OVERWRITE INTO STAGE.AXXESS_FACT_INVOICE_TRANSACTIONS
        WITH HOMECARE AS
                 (SELECT MD5(''PRIME''
                     || ''-'' || IFNULL(UPPER(TRIM(FIN.TRANSACTION_ID)), ''UNKNOWN'')
                     || ''-'' || COALESCE(TRY_TO_DATE(FIN.BILLED_DATE), ''1900-01-01'')
                     || ''-'' || IFNULL(UPPER(TRIM(VS.SCHEDULED_TASK_ID)), ''UNKNOWN'')
                     || ''-'' || ''AXXESS'')                                                                                                                           AS TRANSACTION_KEY,
                         COALESCE(FIN.TRANSACTION_ID, ''UNKNOWN'')                                                                                                     AS TRANSACTION_NUMBER,
                         MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(vs.CLAIM_ID)), ''UNKNOWN'') ||
                             ''-'' ||
                             IFNULL(UPPER(TRIM(vs.SCHEDULED_TASK_ID)), ''UNKNOWN'') ||
                             ''-'' ||
                             ''AXXESS'')                                                                                                                               AS REVENUE_KEY,
                         MD5(''PRIME'' || ''-'' ||
                             IFNULL(UPPER(TRIM(VS.SCHEDULED_TASK_ID)), ''UNKNOWN'') ||
                             ''-'' ||
                             ''AXXESS'')                                                                                                                               AS VISIT_KEY,
                         MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(FIN.TRANSACTION_TYPE)), ''UNKNOWN'') || ''-'' ||
                             ''AXXESS'')                                                                                                                               AS TRANSACTION_TYPE_KEY,
                         DIV0(NVL(fin.PAYMENT_AMOUNT, 0) - NVL(FIN.ADJUSTMENT_AMOUNT, 0), (COUNT(1)
                                                                                                 OVER (PARTITION BY TRANSACTION_ID,VS.CLAIM_ID ORDER BY VS.CLAIM_ID))) AS AMOUNT,
                         TRY_TO_DATE(COALESCE(FIN.PAYMENT_DATE, ''1999-12-31''),
                                     ''YYYY-MM-DD'')                                                                                                                   AS TRANSACTION_CREATED,
                         TRY_TO_DATE(FIN.PAYMENT_DATE, ''YYYY-MM-DD'')                                                                                                 AS TRANSACTION_POSTED,
                         TRY_TO_DATE(COALESCE(FIN.TRANSACTION_DATE, ''1999-12-31''),
                                     ''YYYY-MM-DD'')                                                                                                                   AS TRANSACTION_DATE,
                         TRY_TO_DATE(COALESCE(FIN.TRANSACTION_DATE, ''1999-12-31''),
                                     ''YYYY-MM-DD'')                                                                                                                   AS FINAL_TRANSACTION_DATE,
                         ''UNKNOWN''                                                                                                                                   AS CHECK_NUMBER, -- Replace with the actual check number
                         NULL                                                                                                                                          AS CHECK_DATE,   -- Replace with the actual check date
                         NULL                                                                                                                                          AS DEPOSIT_DATE, -- Replace with the actual deposit date
                         NULL                                                                                                                                          AS POSTED_DATE,  -- Replace with the actual posted date
                         ''AXXESS''                                                                                                                                    AS SYSTEM_CODE,
                         14                                                                                                                                            AS SOURCE_SYSTEM_ID,
                         :STR_ETL_TASK_KEY                                                                                                                             AS ETL_TASK_KEY,
                         :STR_ETL_TASK_KEY                                                                                                                             AS ETL_INSERTED_TASK_KEY,
                         CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ                                                                                   AS ETL_INSERTED_DATE,
                         CURRENT_USER                                                                                                                                  AS ETL_INSERTED_BY,
                         CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ                                                                                   AS ETL_LAST_UPDATED_DATE,
                         CURRENT_USER                                                                                                                                  AS ETL_LAST_UPDATED_BY,
                         FALSE                                                                                                                                         AS ETL_DELETED_FLAG
                  FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_FINANCIALTRANSACTIONS FIN
                           LEFT JOIN DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_VISITFINANCIALS VS ON FIN.CLAIM_ID = VS.CLAIM_ID
                  WHERE VS.SCHEDULED_TASK_ID IS NOT NULL),
             trans as (select row_number() over (partition by fact_ar_id order by fact_ar_id) row_num, *
                       from disc_${var.SF_ENVIRONMENT}.AXXESS.axxess_transactions),
             HOMEHEALTH AS (SELECT distinct MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(TRANS.FACT_AR_ID))
                 , ''UNKNOWN'')
                 || ''-'' || ROW_NUM
                 || ''-'' || IFNULL(UPPER(TRIM(VISIT.VISIT_ID))
                                                    , ''UNKNOWN'')
                 || ''-'' || ''AXXESS'')                                                      AS TRANSACTION_KEY
                                          , COALESCE(TRANS.FACT_AR_ID
                     , ''UNKNOWN'')                                                           AS TRANSACTION_NUMBER
                                          , MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(trans.FACT_AR_ID))
                     , ''UNKNOWN'') ||
                                                ''-'' ||
                                                IFNULL(UPPER(TRIM(VISIT.VISIT_ID))
                                                    , ''UNKNOWN'') || ''-'' ||
                                                ''AXXESS'')                                   AS REVENUE_KEY
                                          , MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(VISIT.VISIT_ID))
                     , ''UNKNOWN'') ||
                                                ''-'' ||
                                                ''AXXESS'')                                   AS VISIT_KEY
                                          , MD5(''PRIME'' || ''-'' || case
                                                                           when upper(IS_REMITTANCE) = ''TRUE''
                                                                               then ''REMITTANCE''
                                                                           when upper(IS_ADJUSTMENT) = ''TRUE''
                                                                               THEN ''ADJUSTMENT''
                                                                           WHEN UPPER(IS_MANUAL_PAYMENT) = ''TRUE''
                                                                               THEN ''MANUAL PAYMENT'' END || ''-'' ||
                                                ''AXXESS'')                                   AS TRANSACTION_TYPE_KEY
                                          , (DIV0(NVL(trans.PAYMENT_AMOUNT
                                                      , 0)
                     , (COUNT(1)
                              OVER (PARTITION BY TRANS.FACT_AR_ID
                                  , ROW_NUM ORDER BY TRANS.FACT_AR_ID
                                  , ROW_NUM))))                                               AS AMOUNT
                                          , CASE
                                                WHEN upper(TRANS.IS_ADJUSTMENT) = ''TRUE'' THEN
                                                    COALESCE(TRANS.ADJUSTMENT_DATE
                                                        , ''1999-12-31'')
                                                ELSE (COALESCE(TRANS.PAYMENT_DATE
                                                    , ''1999-12-31'')) END                    AS TRANSACTION_CREATED
                                          , CASE
                                                WHEN upper(TRANS.IS_ADJUSTMENT) = ''TRUE'' THEN
                                                    TRY_TO_DATE(TRANS.ADJUSTMENT_POST_DATE)
                                                ELSE TRY_TO_DATE(TRANS.PAYMENT_POST_DATE) END AS TRANSACTION_POSTED
                                          , CASE
                                                WHEN upper(TRANS.IS_ADJUSTMENT) = ''TRUE'' THEN
                                                    TRY_TO_DATE(TRANS.ADJUSTMENT_DATE)
                                                ELSE TRY_TO_DATE(TRANS.PAYMENT_DATE) END      AS TRANSACTION_DATE
                                          , NULL                                              AS FINAL_TRANSACTION_DATE
                                          , COALESCE(TRANS.EFT_NUMBER
                     , TRANS.CHECK_RA
                     , ''UNKNOWN'')                                                           AS CHECK_NUMBER
                                          , NULL                                              AS CHECK_DATE
                                          , NULL                                              AS DEPOSIT_DATE
                                          , CASE
                                                WHEN upper(TRANS.IS_ADJUSTMENT) = ''TRUE'' THEN
                                                    TRY_TO_DATE(TRANS.ADJUSTMENT_POST_DATE)
                                                ELSE TRY_TO_DATE(TRANS.PAYMENT_POST_DATE) END AS POSTED_DATE
                                          , ''AXXESS''                                        AS SYSTEM_CODE
                                          , 14                                                AS SOURCE_SYSTEM_ID
                                          , :STR_ETL_TASK_KEY                                 AS ETL_TASK_KEY
                                          , :STR_ETL_TASK_KEY                                 AS ETL_INSERTED_TASK_KEY
                                          , CONVERT_TIMEZONE(''UTC''
                     , CURRENT_TIMESTAMP)::TIMESTAMP_NTZ                                      AS ETL_INSERTED_DATE
                                          , CURRENT_USER                                      AS ETL_INSERTED_BY
                                          , CONVERT_TIMEZONE(''UTC''
                     , CURRENT_TIMESTAMP)::TIMESTAMP_NTZ                                      AS ETL_LAST_UPDATED_DATE
                                          , CURRENT_USER                                      AS ETL_LAST_UPDATED_BY
                                          , FALSE                                             AS ETL_DELETED_FLAG
                            FROM TRANS
                                     LEFT JOIN DISC_${var.SF_ENVIRONMENT}.AXXESS.VW_AXXESS_HH_VISITS_UPPER VISIT
                                               ON VISIT.FACT_AR_ID = trans.FACT_AR_ID)
        SELECT *
        FROM HOMECARE
        UNION
        SELECT *
        FROM HOMEHEALTH;
        RETURN ''SUCCESS'';
    END ;

 EOT
}

