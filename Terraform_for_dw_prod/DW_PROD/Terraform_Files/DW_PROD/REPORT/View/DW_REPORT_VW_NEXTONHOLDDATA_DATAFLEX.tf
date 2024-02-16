resource "snowflake_view" "DW_REPORT_VW_NEXTONHOLDDATA_DATAFLEX" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_NEXTONHOLDDATA_DATAFLEX"
	statement = <<-SQL
	 SELECT md5(DBNAME || '-' || NUMBER || '-'  ||  'DATAFLEXSYNCDATA' ) as client_key,NUMBER,SourceSystemID,DBNAME,ONHOLDSTARTDATE,ONHOLDENDDATE,Status,CAST(ETL_INSERTED_DATE AS DATE) as ETL_INSERTED_DATE
FROM
(
SELECT DISTINCT NUMBER,3 as SourceSystemID,DBNAME,ONHOLDSTARTDATE,ONHOLDENDDATE,TRUE as Status,
  ETL_INSERTED_DATE,
row_number() over (partition by number,dbname order by ETL_INSERTED_DATE desc) as latestrecord
from DISC_${var.SF_ENVIRONMENT}.dataflexsyncdata.HIST_DFCLIENTS WHERE ETL_DELETED_FLAG = FALSE AND CAST(ETL_INSERTED_DATE AS DATE) = CAST(CURRENT_DATE AS DATE))where latestrecord = 1;
SQL
	or_replace = true 
	is_secure = false 
}

