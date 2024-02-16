resource "snowflake_procedure" "DW_HAH_GET_STAGE_PREFERRED_DIM_INVOICE_VISIT_LINKAGE" {
	name ="GET_STAGE_PREFERRED_DIM_INVOICE_VISIT_LINKAGE"
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
-- NAME:  PREFERRED_DIM_INVOICE_VISIT_LINKAGE
--
-- DEVELOPMENT LOG:A
-- DATE         AUTHOR              NOTES:
-- --------     ------------------- -----------------------------------------------------------------------------------------------
-- 06/12/23		Preeti Sharma		Initial Development
-- 06/12/23		Pinkal Panchal		Modified the Logic of revenue/visit keys

--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.PREFERRED_DIM_INVOICE_VISIT_LINKAGE
SELECT
MD5(''PREFERRED'' ||''-''|| INVOICE.InvoiceDetailID ||''-''|| INVOICE.VISITID ||''-''|| ''PREFERRED'') AS REVENUE_KEY
,MD5(''PREFERRED'' || ''-'' || COALESCE(VISITS.VISITID,INVOICE.VISITID) || ''-'' || '' PREFERRED'') AS VISIT_KEY
,CAST(COALESCE(VISITS.VISITID,INVOICE.VISITID) AS VARCHAR) AS VISIT_ID
,DATE_TRUNC(DAY, VR.VISITDATE) AS SERVICE_DATE
,''PREFERRED'' AS SYSTEM_CODE
,17 AS SOURCE_SYSTEM_ID
,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY                     
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
,0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.TBLINVOICEDETAILS_REPL INVOICE
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.VISITINFO_REPL VISITS
ON  VISITS.VISITID = INVOICE.VISITID
JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.TBLVISITS_REPL VR
ON VISITS.VISITID = VR.VISITID AND VISITS.AGENCYID = VR.AGENCYID
; 

RETURN ''SUCCESS'';
END;

 EOT
}

