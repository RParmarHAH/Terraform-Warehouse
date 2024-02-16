create or replace view DW_PROD.STAGE.VW_CURRENT_DATAFLEXSYNCDATA_DIM_CONTRACT(
	CONTRACT_KEY
) as
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
             FROM DISC_PROD.DATAFLEXSYNCDATA.DFCONTRACTS F
         ) t
    group by 1,2
  )
SELECT
	md5(F.DBNAME || '-' || F.ContractCode || '-'  ||  'DATAFLEXSYNCDATA') AS CONTRACT_KEY --PK
   
FROM DISC_PROD.DATAFLEXSYNCDATA.DFCONTRACTS F
left join sl sl
    on f.CONTRACTCODE = sl.CONTRACTCODE
    and f.DbName = sl.DbName
WHERE F.ETL_LAST_UPDATED_DATE >= '1900-01-01';