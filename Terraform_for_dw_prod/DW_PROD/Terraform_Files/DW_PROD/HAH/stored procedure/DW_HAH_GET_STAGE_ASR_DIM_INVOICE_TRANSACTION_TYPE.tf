resource "snowflake_procedure" "DW_HAH_GET_STAGE_ASR_DIM_INVOICE_TRANSACTION_TYPE" {
	name ="GET_STAGE_ASR_DIM_INVOICE_TRANSACTION_TYPE"
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
FROM DISC_${var.SF_ENVIRONMENT}.ASR.ASR_CLAIMSTATUSES CS
;   
RETURN ''SUCCESS'';
END;

 EOT
}

