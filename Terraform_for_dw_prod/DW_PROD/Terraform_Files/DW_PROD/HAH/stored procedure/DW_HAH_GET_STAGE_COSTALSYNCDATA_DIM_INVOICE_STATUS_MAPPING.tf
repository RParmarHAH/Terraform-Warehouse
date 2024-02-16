resource "snowflake_procedure" "DW_HAH_GET_STAGE_COSTALSYNCDATA_DIM_INVOICE_STATUS_MAPPING" {
	name ="GET_STAGE_COSTALSYNCDATA_DIM_INVOICE_STATUS_MAPPING"
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
-- 21/03/23    Pinkal Panchal        Initial Development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.COSTALSYNCDATA_DIM_INVOICE_STATUS_MAPPING
SELECT DISTINCT 
SOURCE_SYSTEM_ID,SYSTEM_CODE,DERIVED_INVOICE_STATUS,INVOICE_STATUS_KEY
-- ETL Fields
    ,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
    ,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY                    
	,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
	,CURRENT_USER as ETL_INSERTED_BY
	,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE
	,CURRENT_USER as ETL_LAST_UPDATED_BY
FROM 
(
SELECT  DISTINCT
	inv.BILL_NUMBER
    ,CASE inv.DB WHEN ''SHC_ALTRUS'' THEN 1 WHEN ''SHC_SAVANNAH'' THEN 2 ELSE -1 END  AS SOURCE_SYSTEM_ID
	,inv.DB as SYSTEM_CODE 
    , CASE WHEN MAX(BILL_AMOUNT) /* AMOUNT_BILLED */ = SUM( CASE WHEN LEFT(PAYMENT_CODE, 1) NOT IN (''9'', ''8'') THEN PAID_AMOUNT ELSE 0 END ) /* AMOUNT_COLLECTED */
    		THEN ''PAID''
    	WHEN SUM( CASE WHEN LEFT(PAYMENT_CODE, 1) NOT IN (''9'', ''8'') THEN PAID_AMOUNT ELSE 0 END ) > 0 THEN ''PARTIAL PAY'' 
    	WHEN COUNT(CASE WHEN CLAIM_STATUS = 0 THEN 1 END) > 0 AND COUNT(CASE WHEN CLAIM_STATUS = 1 THEN 1 END) > 0 THEN ''UNKNOWN''
    	WHEN COUNT(CASE WHEN CLAIM_STATUS = 0 THEN 1 END) > 0 AND COUNT(CASE WHEN CLAIM_STATUS = 1 THEN 1 END) = 0 THEN ''BILLED''
    	WHEN COUNT(CASE WHEN CLAIM_STATUS = 0 THEN 1 END) = 0 AND COUNT(CASE WHEN CLAIM_STATUS = 1 THEN 1 END) > 0 THEN ''UNBILLED''
    	ELSE ''UNKNOWN'' END AS DERIVED_INVOICE_STATUS
   ,MD5(SOURCE_SYSTEM_ID || ''-'' || DERIVED_INVOICE_STATUS || ''-'' || SYSTEM_CODE ) AS INVOICE_STATUS_KEY
FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_BILLINGDATA inv
GROUP BY inv.BILL_NUMBER,inv.DB
);
RETURN ''SUCCESS'';
END;

 EOT
}

