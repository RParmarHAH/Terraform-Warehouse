resource "snowflake_view" "DW_STAGE_VW_CURRENT_DELETED_DATAFLEXSYNCDATA_DIM_CONTRACT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_DELETED_DATAFLEXSYNCDATA_DIM_CONTRACT"
	statement = <<-SQL
	 with sl as (
    select ContractCode, DbName, max(SERVICE_LINE_CODE) as SERVICE_LINE_CODE
    from (
             SELECT DISTINCT ContractCode,
                             DbName,
                             CASE
                             WHEN ContractName LIKE '%TEST%' THEN 'DT'
                             WHEN ContractName LIKE '%DCFS%' OR ContractName LIKE '%DCS%' THEN 'DC'
                             ELSE NVL(RevenueCategory, 'HC')
                             END as SERVICE_LINE_CODE
             FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.HIST_DFCONTRACTS F
         ) t
    group by 1,2
  )
SELECT
	md5(F.DBNAME || '-' || F.ContractCode || '-'  ||  'DATAFLEXSYNCDATA') AS CONTRACT_KEY --PK
   
FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.HIST_DFCONTRACTS F
left join sl sl
    on f.CONTRACTCODE = sl.CONTRACTCODE
    and f.DbName = sl.DbName
 WHERE F.ETL_DELETED_FLAG = TRUE AND CAST(F.ETL_LAST_UPDATED_DATE AS DATE)
             IN (SELECT MAX(CAST(ETL_LAST_UPDATED_DATE AS DATE)) FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.HIST_DFCONTRACTS);
SQL
	or_replace = true 
	is_secure = false 
}

