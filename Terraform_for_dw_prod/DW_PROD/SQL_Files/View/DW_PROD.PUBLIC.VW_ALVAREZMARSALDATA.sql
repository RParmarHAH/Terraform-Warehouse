create or replace view DW_PROD.PUBLIC.VW_ALVAREZMARSALDATA(
	EMPLOYEENAME,
	EMPLOYEENUMBER,
	SEGMENT,
	STATE,
	BRANCHID,
	CONTRACTID,
	EMPLOYEETYPE,
	DATEWORKED,
	STARTTIME,
	STOPTIME,
	SCHEDULEDHOURS,
	AUTHORIZEDHOURS,
	PAIDUNPAIDSTATUS,
	WORKEDHOURS,
	SYSTEMOFRECORDPAYROLL,
	BILLEDHOURS,
	BILLEDUNBILLEDSTATUS,
	SYSTEMOFRECORDBILLING,
	VISITCOUNT,
	BILLINGUNIT,
	CONTRACTEDBILLRATEPERUNIT,
	PAYRATE
) as 

WITH Bill_Only_Employees AS(
	SELECT *
	FROM DW_PROD.HAH.DIM_Employee AS emp
	WHERE (UPPER( Employee_First_Name) LIKE '%BILL%' AND UPPER( Employee_Last_Name) LIKE '%ONLY%')
	OR UPPER( Employee_First_Name) LIKE '%BILL%ONLY%'
	OR UPPER( Employee_Last_Name) LIKE '%BILL%ONLY%'
	ORDER BY Primary_Branch_State, Primary_Branch_Key)

SELECT DISTINCT 
concat (e.employee_first_name,' ',e.employee_last_name) EmployeeName, 
v.employee_id EmployeeNumber, 
c.revenue_Category Segment,
b.office_state_code State,
b.branch_name BranchID, 
c.contract_name ContractID,
e.employee_category EmployeeType,
v.service_date DateWorked, 
'Null'  StartTime,
'Null'  StopTime, 
'Null'  ScheduledHours,	
'Null'  AuthorizedHours,	
'Null'  PaidUnpaidStatus,
sum(v.hours_served) WorkedHours,
s.PAYROLL_SYSTEM_CODE  SystemofRecordPayroll, 
'Null' AS BilledHours,	
'Null' AS BilledUnbilledStatus,
v.system_code SystemofRecordBilling,
count (DISTINCT v.visit_key) AS VisitCount, 
c.TIME_TRANSLATION_CODE AS BillingUnit, 
v.bill_rate AS ContractedBillRateperUnit, 
'Null' AS PayRate



FROM DW_PROD.HAH.FACT_VISIT V

JOIN DW_PROD.HAH.DIM_EMPLOYEE e 
ON e.employee_key = v.employee_key

JOIN DW_PROD.HAH.DIM_CONTRACT c 
ON c.CONTRACT_KEY = v.contract_key
AND NVL( c.Mileage_Flag, 'FALSE') = 'FALSE' 
AND UPPER( c.Revenue_Subcategory_Name ) NOT LIKE '%MILE%' AND (NVL( v.Bill_Rate, 1) >= 1 OR v.Bill_Rate = 0)
AND V.Status_Description IN ('Billed', 'In Process', 'Paid', 'Confirmed')

LEFT JOIN DW_PROD.HAH.DIM_BRANCH b 
ON b.BRANCH_KEY = v.branch_key

LEFT JOIN DW_PROD.HAH.dim_state s 
ON s.STATE_ISO_CODE = b.OFFICE_STATE_CODE

WHERE
v.service_date >= '1/1/2019'
AND v.SOURCE_SYSTEM_ID NOT IN ('1','2')
AND b.office_state_code NOT IN ('SC','GA')
AND V.EMPLOYEE_KEY NOT IN (SELECT employee_key FROM Bill_Only_Employees)

GROUP BY 
v.employee_key,
concat (e.employee_first_name,' ',e.employee_last_name), 
v.employee_id, 
c.revenue_Category,
b.office_state_code,
b.branch_name, 
b.parent_office_Code,
c.contract_name,
e.employee_category,
v.service_date, 
s.PAYROLL_SYSTEM_CODE,
v.system_code,
c.TIME_TRANSLATION_CODE, 
v.bill_rate;