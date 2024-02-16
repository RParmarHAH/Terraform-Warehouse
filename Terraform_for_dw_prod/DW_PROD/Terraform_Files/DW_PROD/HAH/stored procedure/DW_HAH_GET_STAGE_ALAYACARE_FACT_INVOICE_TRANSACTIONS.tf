resource "snowflake_procedure" "DW_HAH_GET_STAGE_ALAYACARE_FACT_INVOICE_TRANSACTIONS" {
	name ="GET_STAGE_ALAYACARE_FACT_INVOICE_TRANSACTIONS"
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
-- NAME:  ALAYACARE_FACT_INVOICE_TRANSACTIONS
--
-- DEVELOPMENT LOG:
-- DATE            AUTHOR                      NOTES:
-- --------     -------------------  -----------------------------------------------------------------------------------------------
-- 28/12/23     PRADEEP THIPPANI        Initial development
-- 11/12/23     Muhammad Zorob          Revised procedure using updated tables provided by Alayacare, added transaction types
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.ALAYACARE_FACT_INVOICE_TRANSACTIONS
SELECT DISTINCT MD5(''ALAYACARE'' || ''-'' || AT.ID::STRING || ''-'' ||
                    COALESCE(INVOICE_ITEM.INVOICE_ITEM_ID::STRING, ''UNKNOWN'') || ''-'' ||
                    ''ALAYACARE'')                                                                                 AS TRANSACTION_KEY
              , CAST(at.MAIN_TRANSACTION_ID AS varchar)                                                            AS TRANSACTION_NUMBER
              , MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' ||
                    COALESCE(AT.BRANCH_ID, -1) || '')'' || ''-'' || nvl(INVOICE_ITEM.INVOICE_ITEM_ID, -1) || ''-'' ||
                    ''ALAYACARE'')                                                                                 AS REVENUE_KEY
              , MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' ||
                    NVL(AT.BRANCH_ID, -1) || '')'' || ''-'' || NVL(VISITS.VISIT_ID, -1) || ''-'' ||
                    ''ALAYACARE'')                                                                                 AS VISIT_KEY
              , MD5(MAIN_TRANSACTION_NAME || ''ALAYACARE'' ||
                    UPPER(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'')
                        || '' ('' || COALESCE(VISITS.BRANCH_ID, -1) || '')''))                                                       AS TRANSACTION_TYPE_KEY
              , round(AT.ALLOCATED_AMOUNT / COUNT(1) OVER (PARTITION BY AT.ID), 2)                                 AS AMOUNT
              , DATE(AT.CREATION_DATE_TRANSACTION)                                                                 AS TRANSACTION_CREATED
              , DATE(AT.MAIN_TRANSACTION_POSTING_DATE)                                                             AS TRANSACTION_POSTED
              , DATE(INVOICE_ITEM.PAYMENT_DATE)                                                                    AS TRANSACTION_DATE
              , NULL                                                                                               AS FINAL_TRANSACTION_DATE
              , NULL                                                                                               AS CHECK_NUMBER
              , NULL                                                                                               AS CHECK_DATE
              , NULL                                                                                               AS DEPOSIT_DATE
              , NULL                                                                                               AS POSTED_DATE
              , UPPER(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' ||
                      COALESCE(VISITS.BRANCH_ID, -1) ||
                      '')'')                                                                                       AS SYSTEM_CODE
              , 9                                                                                                  AS SOURCE_SYSTEM_ID
              , -1                                                                                                 AS ETL_TASK_KEY
              , -1                                                                                                 AS ETL_INSERTED_TASK_KEY
              , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz                                        as ETL_INSERTED_DATE
              , CURRENT_USER                                                                                       as ETL_INSERTED_BY
              , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz                                        as ETL_UPDATED_DATE
              , CURRENT_USER                                                                                       as ETL_LAST_UPDATED_BY
              , 0                                                                                                  as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.ALAYACARE.ACCOUNTING_TRANSACTION AT
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.INVOICE_ITEM INVOICE_ITEM ON NVL(AT.ALLOC_TRANS_INVOICE_ID,AT.MAIN_TRANSACTION_INVOICE_ID)=INVOICE_ITEM.INVOICE_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.VISIT AS VISITS ON VISITS.VISIT_ID = INVOICE_ITEM.VISIT_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.BRANCH B
        ON AT.BRANCH_ID = B.BRANCH_ID
WHERE AT.BRANCH_ID IS NOT NULL
UNION
SELECT DISTINCT
MD5(''ALAYACARE'' || ''-'' || COALESCE(T.MAIN_TRANSACTION_ID::STRING,''UNKNOWN'') || ''-'' || NVL(VISITS.VISIT_ID,-1) || ''-'' || COALESCE(INVOICE_ITEM.INVOICE_ITEM_ID::STRING,''UNKNOWN'')|| ''-'' || ''ALAYACARE'') AS TRANSACTION_KEY,
CAST(T.MAIN_TRANSACTION_ID  AS varchar) AS TRANSACTION_NUMBER,
MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || COALESCE(VISITS.BRANCH_ID, -1) || '')'' || ''-'' || nvl(INVOICE_ITEM.INVOICE_ITEM_ID,-1) || ''-'' || ''ALAYACARE'') AS REVENUE_KEY ,
MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(VISITS.BRANCH_ID,-1) || '')'' || ''-'' || NVL(VISITS.VISIT_ID,-1)|| ''-'' || ''ALAYACARE'') AS VISIT_KEY,
MD5(TYPE || ''ALAYACARE'' || UPPER(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION),''Unknown'')
|| '' ('' || COALESCE(VISITS.BRANCH_ID, -1) || '')'')) AS TRANSACTION_TYPE_KEY,
CASE
WHEN TYPE IN (''void'',''payment'',''writeoff'',''credit_note'')
THEN ROUND(T.MAIN_TRANSACTION_AMOUNT / COUNT(1) OVER (PARTITION BY  MAIN_TRANSACTION_ID,T.CLAIM_SERVICE_LINE_ID,TYPE),2)
ELSE ROUND(-1.0 * T.MAIN_TRANSACTION_AMOUNT / COUNT(1) OVER (PARTITION BY  MAIN_TRANSACTION_ID,T.CLAIM_SERVICE_LINE_ID,TYPE),2) END AS AMOUNT,
NULL AS TRANSACTION_CREATED,
DATE(T.MAIN_TRANSACTION_POSTING_DATE) AS TRANSACTION_POSTED,
DATE(INVOICE_ITEM.PAYMENT_DATE) AS TRANSACTION_DATE,
NULL AS FINAL_TRANSACTION_DATE,
NULL AS CHECK_NUMBER,
NULL AS CHECK_DATE,
NULL AS DEPOSIT_DATE,
NULL AS POSTED_DATE,
UPPER(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION),''Unknown'') || '' ('' || COALESCE(VISITS.BRANCH_ID, -1) || '')'') AS SYSTEM_CODE,
9 AS SOURCE_SYSTEM_ID,
-1 AS ETL_TASK_KEY,
-1 AS ETL_INSERTED_TASK_KEY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
,0 as ETL_DELETED_FLAG
FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_CLAIMS_TRANSACTION T
LEFT JOIN (SELECT DISTINCT CLAIM_ID, CLAIM_SERVICE_LINE_ID, INVOICE_ID, VISIT_ID FROM  ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_CLAIMS  ) C
ON C.CLAIM_SERVICE_LINE_ID::VARCHAR = T.CLAIM_SERVICE_LINE_ID::VARCHAR
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.INVOICE_ITEM INVOICE_ITEM ON INVOICE_ITEM.INVOICE_ID  = c.INVOICE_ID AND INVOICE_ITEM.VISIT_ID = C.VISIT_ID
left JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.VISIT AS VISITS ON VISITS.VISIT_ID = INVOICE_ITEM.VISIT_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.BRANCH B
        ON B.BRANCH_ID = VISITS.BRANCH_ID
WHERE TYPE not in  (''sale'')
;
RETURN ''SUCCESS'';
END;

 EOT
}

