resource "snowflake_procedure" "DW_HAH_GET_STAGE_ALAYACARE_DIM_INVOICE_TRANSACTION_TYPE" {
	name ="GET_STAGE_ALAYACARE_DIM_INVOICE_TRANSACTION_TYPE"
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
-- NAME:  ALAYACARE_DIM_INVOICE_TRANSACTION_TYPE
--
-- DEVELOPMENT LOG:
-- DATE         AUTHOR                  NOTES:
-- ---------     -------------------  -----------------------------------------------------------------------------------------------
-- 01/01/23     PRADEEP THIPPANI        Initial development
-- 01/01/23     Muhammad Zorob          Revised procedure for simplified transaction key based on updated tables from Alayacare
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.ALAYACARE_DIM_INVOICE_TRANSACTION_TYPE
SELECT DISTINCT
MD5(MAIN_TRANSACTION_NAME || ''ALAYACARE'' || UPPER(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION),''Unknown'')
|| '' ('' || COALESCE(VISITS.BRANCH_ID, -1) || '')'')) AS TRANSACTION_TYPE_KEY,
NULL  AS PARENT_TRANSACTION_TYPE_KEY,
MAIN_TRANSACTION_NAME  AS TRANSACTION_CODE,
MAIN_TRANSACTION_NAME AS TRANSACTION_NAME,
MAIN_TRANSACTION_NAME  AS TRANSACTION_DESC,
UPPER(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION),''Unknown'') || '' ('' || COALESCE(VISITS.BRANCH_ID, -1) || '')'') AS SYSTEM_CODE,
9 AS SOURCE_SYSTEM_ID,
-1 AS ETL_TASK_KEY,
-1 AS ETL_INSERTED_TASK_KEY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
,0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.ALAYACARE.ACCOUNTING_TRANSACTION AT LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.INVOICE_ITEM INVOICE_ITEM ON NVL(AT.ALLOC_TRANS_INVOICE_ID,AT.MAIN_TRANSACTION_INVOICE_ID)=INVOICE_ITEM.INVOICE_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.VISIT AS VISITS ON VISITS.VISIT_ID = INVOICE_ITEM.VISIT_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.BRANCH B
        ON AT.BRANCH_ID = B.BRANCH_ID
WHERE AT.BRANCH_ID IS NOT NULL
UNION
SELECT DISTINCT
MD5(TYPE || ''ALAYACARE'' || UPPER(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION),''Unknown'')
|| '' ('' || COALESCE(VISITS.BRANCH_ID, -1) || '')'')) AS TRANSACTION_TYPE_KEY,
NULL  AS PARENT_TRANSACTION_TYPE_KEY,
TYPE  AS TRANSACTION_CODE,
TYPE AS TRANSACTION_NAME,
TYPE  AS TRANSACTION_DESC,
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

