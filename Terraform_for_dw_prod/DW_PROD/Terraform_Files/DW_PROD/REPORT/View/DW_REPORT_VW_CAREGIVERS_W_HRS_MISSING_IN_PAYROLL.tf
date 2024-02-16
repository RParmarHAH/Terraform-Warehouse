resource "snowflake_view" "DW_REPORT_VW_CAREGIVERS_W_HRS_MISSING_IN_PAYROLL" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_CAREGIVERS_W_HRS_MISSING_IN_PAYROLL"
	statement = <<-SQL
	 WITH first_service_date AS
(
SELECT vis.Employee_Key,
       MIN( vis.Service_Date) AS First_Service_Date
FROM DW_Prod.Integration.FACT_Visit_Merged AS vis
WHERE vis.System_Code NOT IN ('PREFERRED', 'EDISON')
GROUP BY 1
),
curr_week_caregivers AS
(
SELECT vis.Source_System_ID, 
       stm.Source_System, 
       vis.System_Code, 
       br.Office_State_Code AS Market, br.Detailed_Office_Name AS Office,
       vis.Employee_ID, 
       emp.Employee_First_Name, emp.Employee_Last_Name, emp.Employee_Hire_Date AS Hire_Date, emp.Employee_PID, emp.Employee_DOB, emp.Payroll_ID,
       vis.Employee_Key,
       MIN( vis.Service_Date) AS Min_Service_Date,
       MAX( vis.Service_Date) AS Max_Service_Date,
       COUNT( vis.Visit_Key) AS Num_Visits,
       SUM( IFNULL( vis.Hours_Served, 0)) AS Sum_Wk_Hrs
FROM DW_Prod.Integration.FACT_Visit_Merged AS vis
--INNER JOIN DW_Prod.HAH.DIM_Date AS dt ON vis.Service_Date BETWEEN dt.HAH_Current_Week_First_Day AND dt.HAH_Current_Week_Last_Day AND dt.Calendar_Date = CURRENT_DATE
INNER JOIN DW_Prod.Integration.DIM_Employee_Merged AS emp ON emp.Original_Employee_Key = vis.Original_Employee_Key AND IFNULL( emp.Employee_Category, 'Caregiver') <> 'ADMIN'
LEFT OUTER JOIN DW_Prod.HAH.VW_DIM_Source_System_to_Market AS stm ON vis.Source_System_ID = stm.Source_System_ID AND vis.System_Code = stm.System_Code
LEFT OUTER JOIN DW_Prod.Integration.DIM_Branch_Merged AS br ON br.Original_Branch_Key = vis.Original_Branch_Key
WHERE (vis.Visit_Status_Code IN ('v04') OR UPPER( vis.Confirmed_Flag) = 'YES')
AND vis.System_Code NOT IN ('PREFERRED', 'EDISON')
AND vis.Service_Date BETWEEN CAST( '2023-10-07' AS DATE) AND CAST( '2023-12-24' AS DATE)
--AND vis.Employee_Key = '9e48783051fe8cde2cfa4deba371fbaa'
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13
),
emp_list AS
(
SELECT cwc.Source_System, cwc.System_Code, cwc.Market, cwc.Office, cwc.Employee_ID, cwc.Employee_First_Name, cwc.Employee_Last_Name, cwc.Employee_PID, cwc.Employee_DOB, cwc.Hire_date, cwc.Payroll_ID,
       fsd.First_Service_Date AS First_Srvc_All_Time,
       cwc.Min_Service_Date AS First_Srvc_Past_6_Wks, cwc.Max_Service_Date AS Last_Srvc_Past_6_Wks, cwc.Num_Visits AS Num_Visits_Past_6_Wks, cwc.Sum_Wk_Hrs AS Hrs_Srvd_Past_6_Wks,
       ecw.Employee_Enterprise_ID, ecw.Workday_Internal_ID,
       ecw.AMS_Employee_Key,
       ecw.AMS_Source_System_ID, ecw.AMS_System_Code, ecw.AMS_Employee_ID, ecw.AMS_IVR_ID, ecw.AMS_Public_ID,
       ecw.Payroll_Employee_Key,
       ecw.payroll_Source_System_ID, ecw.payroll_System_Code, ecw.payroll_Employee_ID
FROM Curr_Week_Caregivers AS cwc 
LEFT OUTER JOIN First_Service_Date AS fsd ON fsd.Employee_Key = cwc.Employee_Key
LEFT OUTER JOIN DW_Prod.Integration.Employee_Cross_Walk AS ecw ON cwc.Employee_Key = ecw.AMS_Employee_Key AND INACTIVE <> TRUE AND DUP_FLAG <> TRUE
WHERE ecw.Payroll_Employee_ID IS NULL
--AND ecw.Inactive = FALSE
--AND fsd.First_Service_Date >= CAST( '2023-09-01' AS DATE)
AND UPPER( cwc.Office) NOT LIKE '%TRAINING%'
AND cwc.Sum_Wk_Hrs > 0
ORDER BY cwc.Source_System, cwc.System_Code, Market, Office, cwc.Employee_Last_Name, cwc.Employee_First_Name
)
--SELECT emp.System_Code AS Pay_System_Code, emp.Employee_First_Name AS Pay_First_Name, emp.Employee_Last_Name AS Pay_Last_Name, amsemp.Employee_First_Name AS AMS_First_Name, amsemp.Employee_Last_Name AMS_Last_Name, emp.Employee_PID Payroll_PID, amsemp.Employee_PID AS AMS_PID, emp.Employee_DOB AS Pay_DOB, amsemp.Employee_DOB AS AMS_DOB
--SELECT emp.System_Code, emp.Employee_First_Name, emp.Employee_Last_Name, el.Employee_First_Name, el.Employee_Last_Name, emp.Employee_PID, el.Employee_PID, emp.Employee_DOB, el.Employee_DOB, el.*
SELECT el.*
FROM emp_list AS el
LEFT OUTER JOIN DW_Prod.Integration.DIM_Employee_Merged AS emp ON el.Payroll_ID = emp.Employee_ID AND Source_System_ID IN ( 5,6,11 )
--LEFT OUTER JOIN DW_Prod.Integration.DIM_Employee_Merged AS amsemp ON amsemp.Employee_Key = el.AMS_Employee_Key
WHERE ( IFNULL( emp.Employee_First_Name, '!#$') <> el.Employee_First_Name OR IFNULL( emp.Employee_Last_Name, '!#$') <> el.Employee_Last_Name OR IFNULL( emp.Employee_PID, '!#$') <> el.Employee_PID OR emp.Employee_DOB <> el.Employee_DOB)
--AND Emp.Employee_Last_Name IS NOT NULL
ORDER BY el.Source_System, el.System_Code, el.Market, el.Office, el.Employee_Last_Name, el.Employee_First_Name;
SQL
	or_replace = true 
	is_secure = false 
}

