resource "snowflake_view" "DW_REPORT_ALVAREZMARSALDATA_WORKEDHOURS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "ALVAREZMARSALDATA_WORKEDHOURS"
	statement = <<-SQL
	 

---------------------development log---------------------

--   date        NAME				Description
-- 08/31/23  Deepen Gajjar   Pushing this view in PROD as per requirement in IDDPS-20

--

WITH Bill_Only_Employees AS(
	SELECT *
	FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_Employee AS emp
	WHERE (UPPER( Employee_First_Name) LIKE '%BILL%' AND UPPER( Employee_Last_Name) LIKE '%ONLY%')
	OR UPPER( Employee_First_Name) LIKE '%BILL%ONLY%'
	OR UPPER( Employee_Last_Name) LIKE '%BILL%ONLY%'
	ORDER BY Primary_Branch_State, Primary_Branch_Key)

SELECT DISTINCT 
v.employee_key,
concat (e.employee_first_name,' ',e.employee_last_name) employeename, 
v.employee_id AS EMPLOYEENUMBER, 
V.CLIENT_KEY AS CLIENTKEY,
c.revenue_Category AS SEGMENT,
b.office_state_code AS STATE,
b.PARENT_OFFICE_NUMBER AS BRANCHID,
PARENT_OFFICE_CODE,
b.PARENT_BRANCH_NAME_SHORTENED,
v.contract_key,
c.contract_code AS CONTRACTCODE,
c.contract_name AS CONTRACTID,
E.EMPLOYEE_CATEGORY AS employeetype,
v.service_date AS DATEWORKED,
'Null' STARTTIME,
'Null' STOPTIME,
'Null' SCHEDULEDHOURS,
'Null' AUTHORIZEDHOURS,
'Null' PAIDUNPAIDSTATUS,
sum(v.hours_served) AS WORKEDHOURS,
s.PAYROLL_SYSTEM_CODE AS SYSTEMOFRECORDPAYROLL, 
'Null' BILLEDHOURS,	
'Null' BILLEDUNBILLEDSTATUS,
s.STATE_ISO_CODE AS SYSTEMOFRECORDBILLING,
count  (DISTINCT v.visit_key) AS VISITCOUNT,
TIME_TRANSLATION_CODE AS BILLINGUNIT, 
BILL_RATE AS CONTRACTEDBILLRATEPERUNIT,
'Null' AS PAYRATE, 
c.REVENUE_SUBCATEGORY_CODE,
c.REVENUE_SUBCATEGORY_NAME,
getdate() AS DATERUN,
v.payroll_date,
sum(v.hours_served) * BILL_RATE AS REVENUE


FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_VISIT_MERGED V

JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_MERGED e 
ON e.original_employee_key = v.employee_key

JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_CONTRACT c 
ON c.CONTRACT_KEY = v.contract_key
AND NVL( c.Mileage_Flag, 'FALSE') = 'FALSE' 
AND UPPER( c.Revenue_Subcategory_Name ) NOT LIKE '%MILE%' AND (NVL( v.Bill_Rate, 1) >= 1 OR v.Bill_Rate = 0)
AND V.visit_status_name IN ('Completed')

LEFT JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_BRANCH_MERGED b 
ON b.ORIGINAL_BRANCH_KEY  = v.branch_key

LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.dim_state s 
ON s.STATE_ISO_CODE = b.OFFICE_STATE_CODE

WHERE
v.service_date >= '1/1/2022'
AND V.EMPLOYEE_KEY NOT IN (SELECT employee_key FROM Bill_Only_Employees)

GROUP BY 
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,21,22,23,24,26,27,28,29,30,31,32;
SQL
	or_replace = true 
	is_secure = false 
}

