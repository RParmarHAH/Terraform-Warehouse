resource "snowflake_procedure" "DW_HAH_GET_STAGE_MATRIXCARE_DIM_INVOICE_VISIT_LINKAGE" {
	name ="GET_STAGE_MATRIXCARE_DIM_INVOICE_VISIT_LINKAGE"
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
-- NAME:  MATRIXCARE_DIM_INVOICE_VISIT_LINKAGE
--
-- DEVELOPMENT LOG:A
-- DATE         AUTHOR              NOTES:
-- --------     ------------------- -----------------------------------------------------------------------------------------------
-- 06/12/23		Pinkal Panchal		Initial Development

--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.MATRIXCARE_DIM_INVOICE_VISIT_LINKAGE
SELECT
MD5(''MATRIXCARE''|| ''-'' || INV.INVD_ID::STRING || ''-'' || ''MATRIXCARE'') AS REVENUE_KEY
,MD5(''MATRIXCARE'' || ''-'' ||  NVL(VIS.SCH_ID,INV.INVD_SCHEDULEID) || ''-'' || ''MATRIXCARE'') AS VISIT_KEY
, CAST(NVL(VIS.SCH_ID,INV.INVD_SCHEDULEID) AS VARCHAR) AS VISIT_ID
,TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', VIS.SCH_STARTTIME))) as SERVICE_DATE
,''MATRIXCARE'' AS SYSTEM_CODE
,7 AS SOURCE_SYSTEM_ID
,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY                     
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
,0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEDETAILS INV
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULES VIS ON INV.INVD_SCHEDULEID = VIS.SCH_ID
; 

RETURN ''SUCCESS'';
END;

 EOT
}

