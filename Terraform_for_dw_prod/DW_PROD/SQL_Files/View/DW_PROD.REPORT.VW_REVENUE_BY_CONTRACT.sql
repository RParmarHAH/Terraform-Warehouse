create or replace view DW_PROD.REPORT.VW_REVENUE_BY_CONTRACT(
	YEAR,
	MONTH,
	STATE,
	CONTRACT_CODE,
	CONTRACT_NAME,
	REVENUE_CATEGORY,
	REVENUE_SUBCATEGORY_NAME,
	PAYOR_CATEGORY,
	CONTRACT_KEY,
	REVENUE
) as 
(WITH PAYORCATS AS 
(SELECT 
csv.$1 AS CONTRACT_KEY,
csv.$2 AS CONTRACT_STATE_cODE,
csv.$3 AS CONTRACT_NAME,
csv.$4 AS PAYOR_CATEGORY

FROM @DW_DEV.Stage.AZStage/CSV_Files/CONTRACTS_PAYOR_CATS (file_format => DW_DEV.PUBLIC.CSV_Format) csv)

SELECT DISTINCT 
Year(r.report_date) AS YEAR,
MONTH (r.report_date) AS MONTH,
CASE WHEN c.SYSTEM_CODE = 'SHC_SAVANNAH' THEN 'COASTAL' ELSE 'ALTRUS' END AS STATE, 
c.contract_code, 
c.contract_name,
c.revenue_category,
c.revenue_subcategory_name,
p.payor_category,
c.contract_key,
sum(r.amount_billed) AS REVENUE


FROM DW_PROD.HAH.FACT_REVENUE r 
JOIN DW_PROD.HAH.DIM_CONTRACT C 
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
Year(r.MONTH) AS YEAR,
MONTH (r.MONTH) AS MONTH,
R.STATE,
R.contract_code, 
R.contract_name,
C.revenue_category,
C.revenue_subcategory_name,
CASE 	
	WHEN c.contract_name IN ('Keystone', 'Amerihealth', 'PA Health and Wellness', 'UPMC') THEN 'MCO' ELSE 'MEDICAID' END AS Payor,
 c.contract_key,
sum(r.ACTUALREVENUE) AS REVENUE


FROM DW_DEV.REPORT.VW_SLT_REVENUE R

JOIN DW_PROD.HAH.DIM_CONTRACT C 
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

FROM @DW_DEV.Stage.AZStage/CSV_Files/CONTRACTS_PAYOR_CATS (file_format => DW_DEV.PUBLIC.CSV_Format) csv)
 
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
sum(invdtl.amount) AS REVENUE

FROM DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES inv 
INNER JOIN DISC_Prod.DataFlexSyncData.DFInvoiceDetails AS invdtl ON invdtl.DBNAME = inv.DBNAME AND invdtl.INVOICENO = inv.INVOICENO
INNER JOIN Disc_Prod.DataFlexSyncData.DFContracts AS cntrct 
ON cntrct.DBName = inv.DBName 
AND cntrct.ContractCode = inv.ContractCode 
INNER JOIN Disc_Prod.DataFlexSyncData.DFOffices AS off ON off.DBName = inv.DBName AND off.OfficeNumber = inv.Office

LEFT OUTER JOIN PAYORCATS P 
ON p.contract_state_code = cntrct.dbname
AND p.contract_name = cntrct.contractname
 
 LEFT OUTER JOIN  DW_PROD.HAH.DIM_CONTRACT c
ON c.system_code = cntrct.dbname
 AND c.contract_name = cntrct.contractname

JOIN DISC_PROD.DATAFLEXSYNCDATA.DFREVENUESUBCATEGORIES r 
ON r.CODE = cntrct.REVENUESUBCATEGORY
AND r.DBNAME = cntrct.dbname

WHERE 
 inv.DBName NOT IN ('PA')
AND cntrct.Billable = 'TRUE'
AND inv.MovedTo = '' 

GROUP BY 1, 2,3,4,5,6,7,8,9)

----- ADAPTIVE ---- 
UNION ALL 
(WITH PAYORCATS AS 
(SELECT 
csv.$1 AS CONTRACT_KEY,
csv.$2 AS CONTRACT_STATE_cODE,
csv.$3 AS CONTRACT_NAME,
csv.$4 AS PAYOR_CATEGORY

FROM @DW_DEV.Stage.AZStage/CSV_Files/CONTRACTS_PAYOR_CATS (file_format => DW_DEV.PUBLIC.CSV_Format) csv)

SELECT DISTINCT 
Year(r.report_date) AS YEAR,
MONTH (r.report_date) AS MONTH,
CASE WHEN  B.DETAILED_OFFICE_NAME LIKE 'IN - H_%' THEN 'IN' ELSE 'ADAPTIVE' END AS STATE,
c.contract_code, 
c.contract_name,
c.revenue_category,
c.revenue_subcategory_name,
p.payor_category,
 c.contract_key,
sum(r.amount_billed) AS REVENUE

FROM DW_DEV.HAH.FACT_REVENUE r 
JOIN DW_DEV.HAH.DIM_CONTRACT C 
ON c.CONTRACT_KEY = r.contract_key 

LEFT OUTER JOIN payorcats p 
ON p.contract_key = c.contract_key
 
 JOIN DW_DEV.HAH.DIM_BRANCH B
 ON B.BRANCH_KEY = R.BRANCH_KEY

WHERE 
r.report_date > '1/1/2018'
AND r.source_system_id IN (7)

GROUP BY 
1,2,3,4,5,6,7,8,9);