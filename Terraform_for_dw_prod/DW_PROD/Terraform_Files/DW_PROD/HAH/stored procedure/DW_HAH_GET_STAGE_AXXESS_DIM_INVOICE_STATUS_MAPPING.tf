resource "snowflake_procedure" "DW_HAH_GET_STAGE_AXXESS_DIM_INVOICE_STATUS_MAPPING" {
	name ="GET_STAGE_AXXESS_DIM_INVOICE_STATUS_MAPPING"
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
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 21/04/23    Pinkal Panchal        Initial Development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.AXXESS_DIM_INVOICE_STATUS_MAPPING
SELECT DISTINCT
	14 AS SOURCE_SYSTEM_ID,
	''PRIME'' AS SYSTEM_CODE,
	CASE WHEN UPPER(TRIM(INVOICE_STATUS)) IN (''PAID'',''OVER PAID'',''FULLY PAID'') THEN ''PAID''
		WHEN UPPER(TRIM(INVOICE_STATUS)) IN (''PARTIALLY PAID'') THEN ''PARTIAL PAY''
		WHEN UPPER(TRIM(INVOICE_STATUS)) IN (''BILL SENT'') THEN ''BILLED''
		WHEN UPPER(TRIM(INVOICE_STATUS)) IN (''CANCELLED'') THEN ''CANCELLED''
		WHEN UPPER(TRIM(INVOICE_STATUS)) IN (''DENIED'') THEN ''REJECTED''
		WHEN UPPER(TRIM(INVOICE_STATUS)) IN (''REVERSAL'',''RESUBMIT'',''PENDING'') THEN ''UNKNOWN''
	ELSE ''UNKNOWN'' END AS DERIVED_INVOICE_STATUS,
	MD5(SOURCE_SYSTEM_ID || ''-'' || DERIVED_INVOICE_STATUS || ''-'' || SYSTEM_CODE) AS INVOICE_STATUS_KEY
	,
       ---- ETL FIELDS
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,                    
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY
FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_INVOICE_STATUS_MAPPING INV
;
RETURN ''SUCCESS'';
END;

 EOT
}

