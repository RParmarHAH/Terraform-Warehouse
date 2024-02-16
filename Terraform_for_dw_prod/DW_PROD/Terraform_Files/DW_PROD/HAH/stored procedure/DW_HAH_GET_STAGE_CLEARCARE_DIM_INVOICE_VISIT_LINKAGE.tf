resource "snowflake_procedure" "DW_HAH_GET_STAGE_CLEARCARE_DIM_INVOICE_VISIT_LINKAGE" {
	name ="GET_STAGE_CLEARCARE_DIM_INVOICE_VISIT_LINKAGE"
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
-- NAME:  CLEARCARE_DIM_INVOICE_VISIT_LINKAGE
--
-- DEVELOPMENT LOG:A
-- DATE         AUTHOR              NOTES:
-- --------     ------------------- -----------------------------------------------------------------------------------------------
-- 06/12/23		Preeti Sharma		Initial Development
-- 15/01/23		Pinkal Panchal		Moified VISIT_KEY


--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.CLEARCARE_DIM_INVOICE_VISIT_LINKAGE
SELECT 
MD5(''CLEARCARE'' ||''-''|| IT.ID ||''-''|| IC.CARELOG_ID ||''-''|| ''CLEARCARE'') AS REVENUE_KEY
,MD5( COALESCE(CA.AGENCY_ID,IT.AGENCY_ID) || ''-'' || COALESCE(CA.ID,IC.CARELOG_ID) || ''-'' || '' CLEARCARE'') AS VISIT_KEY 
,CAST(CA.ID AS VARCHAR) AS VISIT_ID
,CA.SHIFT_DATE AS SERVICE_DATE
,''CLEARCARE'' AS SYSTEM_CODE
,16 AS SOURCE_SYSTEM_ID
,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY                     
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
,0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.CLEARCARE.INVOICE_TRANSACTION  IT
INNER JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.RECEIVABLES_INVOICE_CARELOGS IC
ON IC.INVOICE_ID = IT.ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.CARELOGS_CARELOG  CA 
ON CA.ID = IC.CARELOG_ID
 WHERE IT.AGENCY_ID IN (2459)
; 

RETURN ''SUCCESS'';
END;

 EOT
}

