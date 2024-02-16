resource "snowflake_view" "DW_REPORT_VW_REVENUE_FROM_MCOS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_REVENUE_FROM_MCOS"
	statement = <<-SQL
	 
(WITH PAYORCATS AS 
(SELECT 
csv.$1 AS CONTRACT_KEY,
csv.$2 AS CONTRACT_STATE_cODE,
csv.$3 AS CONTRACT_NAME,
csv.$4 AS PAYOR_CATEGORY

FROM @DW_${var.SF_ENVIRONMENT}.Stage.AZStage/CSV_Files/CONTRACTS_PAYOR_CATS (file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_Format) csv)

SELECT DISTINCT 
Year(r.report_date),
MONTH (r.report_date),
CASE WHEN c.SYSTEM_CODE = 'SHC_SAVANNAH' THEN 'COASTAL' ELSE 'ALTRUS' END AS STATE, 
c.contract_code, 
c.contract_name,
c.revenue_category,
c.revenue_subcategory_name,
p.payor_category,
c.contract_key,
sum(r.amount_billed)


FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_REVENUE r 
JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_CONTRACT C 
ON c.CONTRACT_KEY = r.contract_key 

LEFT OUTER JOIN payorcats p 
ON p.contract_key = c.contract_key

WHERE 
r.report_date >= '2/1/2019' 
AND r.source_system_id IN (1, 2)

GROUP BY 
1,2,3,4,5,6,7,8,9)

--- PA ----

UNION ALL 
(SELECT DISTINCT
Year(r.MONTH) AS YR,
MONTH (r.MONTH),
R.STATE,
R.contract_code, 
R.contract_name,
C.revenue_category,
C.revenue_subcategory_name,
CASE 	
	WHEN c.contract_name IN ('Keystone', 'Amerihealth', 'PA Health and Wellness', 'UPMC') THEN 'MCO' ELSE 'MEDICAID' END AS Payor,
 c.contract_key,
sum(r.ACTUALREVENUE) 


FROM DW_${var.SF_ENVIRONMENT}.REPORT.VW_SLT_REVENUE R

JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_CONTRACT C 
ON C.CONTRACT_KEY = R.CONTRACT_KEY

WHERE 
MONTH >= '1/1/2018' 
AND STATE = 'PA'

GROUP BY
1,2,3,4,5,6,7,8,9)

UNION ALL 
(WITH PAYORCATS AS 
(SELECT 
csv.$1 AS CONTRACT_KEY,
csv.$2 AS CONTRACT_STATE_cODE,
csv.$3 AS CONTRACT_NAME,
csv.$4 AS PAYOR_CATEGORY

FROM @DW_${var.SF_ENVIRONMENT}.Stage.AZStage/CSV_Files/CONTRACTS_PAYOR_CATS (file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_Format) csv)
 
SELECT 
CAST (LEFT(inv.Period,4) AS int) AS YEAR, 
CAST (RIGHT(inv.Period,2) AS int) AS MONTH, 
inv.DBName AS State,
cntrct.contractcode,
cntrct.contractname,
cntrct.revenuecategory,
r.NAME AS revenue_subcategory,
p.payor_Category,
 c.contract_key,
sum(invdtl.amount)

FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFINVOICES inv 
INNER JOIN DISC_Prod.DataFlexSyncData.DFInvoiceDetails AS invdtl ON invdtl.DBNAME = inv.DBNAME AND invdtl.INVOICENO = inv.INVOICENO
INNER JOIN Disc_Prod.DataFlexSyncData.DFContracts AS cntrct 
ON cntrct.DBName = inv.DBName 
AND cntrct.ContractCode = inv.ContractCode 
INNER JOIN Disc_Prod.DataFlexSyncData.DFOffices AS off ON off.DBName = inv.DBName AND off.OfficeNumber = inv.Office

LEFT OUTER JOIN PAYORCATS P 
ON p.contract_state_code = cntrct.dbname
AND p.contract_name = cntrct.contractname
 
 LEFT OUTER JOIN  DW_${var.SF_ENVIRONMENT}.HAH.DIM_CONTRACT c
ON c.system_code = cntrct.dbname
 AND c.contract_name = cntrct.contractname

JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFREVENUESUBCATEGORIES r 
ON r.CODE = cntrct.REVENUESUBCATEGORY
AND r.DBNAME = cntrct.dbname

WHERE 
 inv.DBName NOT IN ('PA')
AND cntrct.Billable = 'TRUE'
AND inv.MovedTo = '' 

GROUP BY 1, 2,3,4,5,6,7,8,9);
SQL
	or_replace = true 
	is_secure = false 
}

