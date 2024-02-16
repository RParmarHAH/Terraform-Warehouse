resource "snowflake_procedure" "DW_HAH_GET_STAGE_MATRIXCARE_DIM_INVOICE_TRANSACTION_TYPE" {
	name ="GET_STAGE_MATRIXCARE_DIM_INVOICE_TRANSACTION_TYPE"
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
-- NAME:  MATRIXCARE_DIM_INVOICE_TRANSACTION_TYPE
--
-- DEVELOPMENT LOG:
-- DATE         AUTHOR              NOTES:
-- --------     ------------------- -----------------------------------------------------------------------------------------------
-- 01/01/23 	PINKAL PANCHAL 		Initial development

--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.MATRIXCARE_DIM_INVOICE_TRANSACTION_TYPE
SELECT 
MD5(''MATRIXCARE'' || ''-'' || NVL(P.POST_PAYMENTPOSTINGTYPEID::STRING,''Unknown'') || ''-'' || ''MATRIXCARE'') AS TRANSACTION_TYPE_KEY,
MD5(''MATRIXCARE'' || ''-'' || NVL(PT.POSTTYP_POSTINGTYPE::STRING,''Unknown'') || ''-'' || ''MATRIXCARE'') AS PARENT_TRANSACTION_TYPE_KEY,
CAST(P.POST_PAYMENTPOSTINGTYPEID AS VARCHAR) AS TRANSACTION_CODE,
PT.POSTTYP_NAME AS TRANSACTION_NAME,
PT.POSTTYP_DESCRIPTION AS TRANSACTION_DESC,
''MATRIXCARE'' AS SYSTEM_CODE,
7 AS SOURCE_SYSTEM_ID,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,                     
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
,0 as ETL_DELETED_FLAG
FROM
DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_PAYMENTPOSTING P
LEFT JOIN
DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_PAYMENTPOSTINGTYPE PT
ON P.POST_PAYMENTPOSTINGTYPEID = PT.POSTTYP_ID
GROUP BY
P.POST_PAYMENTPOSTINGTYPEID,
PT.POSTTYP_POSTINGTYPE,
PT.POSTTYP_NAME,
PT.POSTTYP_DESCRIPTION
ORDER BY
POSTTYP_POSTINGTYPE;
    
RETURN ''SUCCESS'';
END;

 EOT
}

