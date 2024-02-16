resource "snowflake_view" "DW_REPORT_VW_NEXTONHOLDDATA_SANDATA" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_NEXTONHOLDDATA_SANDATA"
	statement = <<-SQL
	  SELECT distinct c.clientid,
    md5(C.AGENCYID || '-' || C.CLIENTID || '-'  ||  'SANDATAIMPORT' ) AS Client_Key,
    4 as Source_System_id,
   'PA' AS system_code,
   ADMISSIONSTATUS,
   CAST(ETL_INSERTED_DATE as DATE)  as ETL_INSERTED_DATE
FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.HIST_SANDATA_CLIENTADMISSIONS C
 where AGENCYID = '8485' and CAST(ETL_INSERTED_DATE as DATE) = CAST(CURRENT_DATE AS DATE) and ADMISSIONSTATUS in ('02','03');
SQL
	or_replace = true 
	is_secure = false 
}

