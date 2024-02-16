resource "snowflake_procedure" "DW_HAH_GET_STAGE_OSHAH_DIM_INVOICE_VISIT_LINKAGE" {
	name ="GET_STAGE_OSHAH_DIM_INVOICE_VISIT_LINKAGE"
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
-- NAME:  OSHAH_DIM_INVOICE_VISIT_LINKAGE
--
-- DEVELOPMENT LOG:A
-- DATE         AUTHOR              NOTES:
-- --------     ------------------- -----------------------------------------------------------------------------------------------
-- 06/12/23		Preeti Sharma		Initial Development
-- 06/12/23		Pinkal Panchal		Visit_Key logic Corrrection

--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.OSHAH_DIM_INVOICE_VISIT_LINKAGE
SELECT DISTINCT 
MD5(''OSHAH'' || ''-'' || INVOICE.INVOICEHEADERID || ''-'' ||INVOICE.INVOICEDETAILID || ''-'' || ''HHAEXCHANGE'') AS REVENUE_KEY
,MD5(''OSHAH'' || COALESCE(VR.VISITID,INVOICE.VISITID) || ''-'' || ''HHAEXCHANGE'') AS VISIT_KEY
,CAST(NVL(VR.VISITID,INVOICE.VISITID) AS VARCHAR) AS VISIT_ID
,DATE_TRUNC(DAY, VR.VISITDATE::DATE) AS SERVICE_DATE
,CONCAT(''OSHAH - '', NVL(TRIM(OFFICE.STATE),''NULL'')) AS SYSTEM_CODE
,17 AS SOURCE_SYSTEM_ID
,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY                     
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
,0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.TBLINVOICEDETAILS_REPL INVOICE
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.VISITINFO_REPL VISITS
ON  VISITS.VISITID = INVOICE.VISITID
JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.TBLVISITS_REPL VR
ON VISITS.VISITID = VR.VISITID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.OFFICE_OFFICES_REPL OFFICE
ON INVOICE.OFFICEID = OFFICE.OFFICEID
; 

RETURN ''SUCCESS'';
END;

 EOT
}

