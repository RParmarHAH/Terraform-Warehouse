resource "snowflake_procedure" "DW_HAH_GET_STAGE_OPENSYSTEMS_DIM_INVOICE_TRANSACTION_TYPE" {
	name ="GET_STAGE_OPENSYSTEMS_DIM_INVOICE_TRANSACTION_TYPE"
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
-- NAME:  OPENSYSTEMS_DIM_INVOICE_TRANSACTION_TYPE
--
-- DEVELOPMENT LOG:
-- DATE         AUTHOR              NOTES:
-- --------     ------------------- -----------------------------------------------------------------------------------------------
-- 01/01/23 	PREETI SHARMA 		Initial development

--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.OPENSYSTEMS_DIM_INVOICE_TRANSACTION_TYPE
SELECT DISTINCT
MD5(''OPENSYSTEMS'' || ''-'' || NVL(TO_VARCHAR(TR.TRANSACTIONTYPE), ''Unknown'') || ''-'' || NVL(TRIM(OFFICE.STATE),''UNKNOWN'') || ''-'' || ''OPENSYSTEMS'') TRANSACTION_TYPE_KEY
,NULL AS PARENT_TRANSACTION_TYPE_KEY
,NULL AS TRANSACTION_CODE
,TR."TRANSACTIONTYPE" AS TRANSACTION_NAME
,NULL AS TRANSACTION_DESC
,CONCAT(''OPENSYSTEMS - '', NVL(TRIM(OFFICE.STATE),''NULL'')) AS SYSTEM_CODE
,17 AS SOURCE_SYSTEM_ID
,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY                     
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
,0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.TRANSACTIONS_REPL TR
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.OFFICE_OFFICES_REPL OFFICE
	 ON TR.OFFICEID = OFFICE.OFFICEID
WHERE TR."TRANSACTIONTYPE" not in (''Invoice'');
RETURN ''SUCCESS'';
END;

 EOT
}

