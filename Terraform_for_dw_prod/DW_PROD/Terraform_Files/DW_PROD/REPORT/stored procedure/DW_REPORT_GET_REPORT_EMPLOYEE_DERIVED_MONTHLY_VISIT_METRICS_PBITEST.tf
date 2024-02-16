resource "snowflake_procedure" "DW_REPORT_GET_REPORT_EMPLOYEE_DERIVED_MONTHLY_VISIT_METRICS_PBITEST" {
	name ="GET_REPORT_EMPLOYEE_DERIVED_MONTHLY_VISIT_METRICS_PBITEST"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
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

DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
    --*****************************************************************************************************************************
-- NAME:  Employee_Derived_Monthly_Visit_Metrics
--
-- PURPOSE: Creates derived monthly metrics for each employee based on visit/service data
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 11/16/20    Frank Noordover       Initial development
-- 06/22/21	   Shraddha Sejpal		 Changed DIMs and FACTs to merged views, DIM CONTRACT join logic changed
-- 07/20/21	   Shraddha Sejpal	     Added Derived_Employee_Category field
-- 12/02/21    Prachi Shah           Added logic for acquisition status and flag
-- 06/27/22	   Devansh Patel		 Added billable only contracts logic and added employee ethnicity, DOB and gender
-- 07/12/22    Devansh Patel 		 Added UNION_FLAG for IL and IN  
-- 07/13/22	   Moin Saiyed			 Added other subcategory data
-- 07/13/22	   Deepen Gajjar	     Added preferred acquisition logic
-- 07/14/22	   Mohit Vaghadiya		 Removed UNION_FLAG for production release (Preferred)
-- 07/19/22    Mohit Vaghadiya		 Added UNION_FLAG for IL and IN back
-- 08/05/22	   Abhishek Sunil		 Added Condition to include actual emps who were considered as Bill Only emps (ASR)
-- 08/05/22    Deepen Gajjar		 Added acquistion flag for ASR
-- 10/10/22    Paras Bhavnani		 Added Rehired Date
-- 11/08/22    Meet Hariyani         Added applicant data
-- 11/10/22    Meet Hariyani         Added derived first service date
-- 11/11/22	   Shraddha Sejpal		 Replaced status description to confirmed flag in FACT_VISIT filter condition
-- 12/02/22    Deepen Gajjar		 Done acquisition flag changes
-- 12/20/22	   Saurav Purohit		 Reworked logic to include non - confirmed visits related data for employees, added New Schedule metrics 
--									 & NEXT_SCHEDULED_SERVICE_DATE field
-- 12/22/22    Saurav Purohit		 Added UNION_FLAG
--***********************************************************************************************************************************
--NOTE:			If Manual Refresh is required then SCHEDULE_METRICS_MONTHLY should be refreshed first before running this object
--***********************************************************************************************************************************
INSERT OVERWRITE INTO Report.Employee_Derived_Monthly_Visit_Metrics_PBITEST
WITH Bill_Only_Employees AS
(
SELECT *
FROM HAH.DIM_Employee AS emp
WHERE ((UPPER( Employee_First_Name) LIKE ''%BILL%'' AND UPPER( Employee_Last_Name) LIKE ''%ONLY%'')
OR UPPER( Employee_First_Name) LIKE ANY ( ''%BILL%ONLY%'', ''%FIELD%STAFF%'', ''%CAREGIVER%'', ''%TEST%PROFILE%'', ''%IMPLEMENT%'', ''%EMPLOYEE%'', ''%DO%NOT%USE%'', ''%OFFICE%'')
OR UPPER( Employee_Last_Name) LIKE ANY ( ''%BILL%ONLY%'', ''%FIELD%STAFF%'', ''%CAREGIVER%'', ''%TEST%PROFILE%'', ''%IMPLEMENT%'', ''%EMPLOYEE%'', ''%DO%NOT%USE%'', ''%OFFICE%'')
OR UPPER( Employee_First_Name) = ''TEST''
OR UPPER( Employee_Last_Name) = ''TEST'') AND SOURCE_SYSTEM_ID NOT IN (13)
ORDER BY Primary_Branch_State, Primary_Branch_Key
),
Calendar_Months AS  								-- get calendar months for months we have service/visit data
(
	SELECT DATE_TRUNC( MONTH, CALENDAR_DATE) AS Calendar_Month
    FROM HAH.DIM_DATE
    WHERE CALENDAR_DATE BETWEEN CAST( ''2013-01-01'' AS DATE) AND DATEADD( ''MONTH'', 2, CURRENT_DATE())		-- Need data upto 2 months into the future now
	GROUP BY 1
),
Emp_List AS  										-- Get a list of employees who provided visits within the calendar period
(
    SELECT DISTINCT 
           vis.Employee_Key
	FROM INTEGRATION.FACT_VISIT_MERGED AS vis
    INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Billable_Flag = ''TRUE''
    WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
    --AND vis.CONFIRMED_FLAG = ''YES'' 																			-- Need All Employees, including the ones who never provided any service
    AND vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
    AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
), 
Emp_Months AS  										-- Create a list of every month for each employee
(
SELECT cm.Calendar_Month AS Service_Month,
       el.Employee_Key
FROM Calendar_Months AS cm
FULL OUTER JOIN Emp_List AS el
WHERE cm.Calendar_Month IS NOT NULL
ORDER BY el.Employee_Key, cm.Calendar_Month
),
Emp_Visit_Max_Hours_By_Month AS  					-- Figure out which branch had the most hours for every service/visit month the employee delivered services/visits
(
SELECT Employee_Key, Service_Month,
       MAX( Sum_of_Hours_Served) AS Max_Hours_Served 
FROM
    (
     SELECT vis.Employee_Key, 
            vis.Branch_Key,
            DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
            SUM( vis.Hours_Served) AS Sum_of_Hours_Served
     FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
     INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Billable_Flag = ''TRUE''
     WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
     AND vis.CONFIRMED_FLAG = ''YES'' 
     AND vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
     AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
     GROUP BY vis.Employee_Key, Service_Month, vis.Branch_Key
    ) x
GROUP BY Employee_Key, Service_Month
),
Employee_Visit_Primary_Branch AS 
(
SELECT Employee_Key, Service_Month, Sum_of_Hours_Served, MAX( Branch_Key) AS Branch_Key
FROM
(
SELECT vis.Employee_Key, 
       vis.Branch_Key AS Branch_Key,
       brnch.Branch_Name AS Branch_Name,
       brnch.Office_State_Code AS Branch_State_Code,
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       SUM( vis.Hours_Served) AS Sum_of_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Billable_Flag = ''TRUE''
INNER JOIN Emp_Visit_Max_Hours_By_Month AS evmhbm ON vis.Employee_Key = evmhbm.Employee_Key AND DATE_TRUNC( ''MONTH'', vis.Service_Date) = evmhbm.Service_Month 
LEFT OUTER JOIN HAH.DIM_Branch AS brnch on brnch.Branch_Key = vis.Branch_Key
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' 
AND vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, vis.Branch_Key, brnch.Branch_Name, brnch.Office_State_Code, DATE_TRUNC( ''MONTH'', vis.Service_Date), evmhbm.Max_Hours_Served
HAVING SUM( vis.Hours_Served) = evmhbm.Max_Hours_Served
) x
GROUP BY Employee_Key, Service_Month, Sum_of_Hours_Served
),
Emp_Visits AS  -- Compile metrics for every service/visit month the employee delivered services/visits
(
SELECT vis.Employee_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
		IFF(MAX(VIS.CONFIRMED_FLAG) = ''YES'',DATE_TRUNC( ''MONTH'', vis.Service_Date),NULL) AS Confirmed_Service_month, 			-- Need to differ a month with atleast one confirmed service from the month without any Confirmed service
	   brnch.Branch_Key,				
       brnch2.Branch_Name,
       brnch2.Office_State_Code AS Branch_State_Code,
       CAST( COUNT(IFF(VIS.CONFIRMED_FLAG = ''YES'', vis.Visit_Key, NULL)) AS INTEGER) AS Number_of_Visits,							-- Need only confirmed no. of visits so added condition back here
       CAST( COUNT( DISTINCT iff(VIS.CONFIRMED_FLAG = ''YES'', vis.Client_Key, NULL)) AS INTEGER) AS Number_of_Distinct_Clients,	-- Need only Confirmed clients (from confirmed visits)
       SUM(NVL(IFF(VIS.CONFIRMED_FLAG = ''YES'',vis.Hours_Served,NULL),0)) AS Sum_of_Hours_Served									-- Confirmed hours only
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Billable_Flag = ''TRUE''
LEFT OUTER JOIN Employee_Visit_Primary_Branch AS brnch ON vis.Employee_Key = brnch.Employee_Key AND DATE_TRUNC( ''MONTH'', vis.Service_Date) = brnch.Service_Month
LEFT OUTER JOIN HAH.DIM_Branch AS brnch2 on brnch2.Branch_Key = brnch.Branch_Key
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
--AND vis.CONFIRMED_FLAG = ''YES'' 																									-- Had to remove this condition to include non confirmed data as well (No. of Future visits/Missed visits)
GROUP BY vis.Employee_Key, DATE_TRUNC( ''MONTH'', vis.Service_Date), brnch.Branch_Key, brnch2.Branch_Name, brnch2.Office_State_Code
),  
Emp_Monthly_Visits AS -- Put visits and monthly employees together
(
SELECT DISTINCT em.Service_Month,
		ev.Confirmed_Service_month,																									-- Adding this to use in place of Service_month from old logic		 
       em.Employee_Key,
       emp.Employee_ID, 
       emp.Source_System_ID, 
       -- Since the Employee_Key is now the new key (coming from Fact_Visit_Merged) select the key where the source system IDs DO NOT match, as the original source system ID
       FIRST_VALUE(emp.Original_Source_System_Id) OVER (PARTITION BY em.Employee_Key ORDER BY IFF(emp.Original_Source_System_ID <> emp.Source_System_ID, 0, 1)) AS Original_Source_System_ID, 
       emp.System_Code, emp.Employee_PID, emp.Employee_Number, emp.Payroll_ID,
       emp.Employee_Category,
       ev.Branch_Key,
       ev.Branch_Name,
       ev.Branch_State_Code,
       ev.Number_of_Visits,
       ev.Number_of_Distinct_Clients,
       ev.Sum_of_Hours_Served
FROM Emp_Months AS em
LEFT OUTER JOIN Emp_Visits AS ev ON em.Service_Month = ev.Service_Month AND em.Employee_Key = ev.Employee_Key
LEFT OUTER JOIN INTEGRATION.DIM_EMPLOYEE_MERGED AS emp ON em.Employee_Key = emp.Employee_Key
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Emp_Monthly_CLS_Visits AS
(
SELECT vis.Employee_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_CLS_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_CLS_Clients,
       SUM( vis.Hours_Served) AS Sum_of_CLS_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''CLS'' AND cntrct.Revenue_SubCategory_Code = ''RES'' 
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months) AND cntrct.Billable_Flag = ''TRUE''
AND vis.CONFIRMED_FLAG = ''YES'' 
AND vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Month
),
Emp_Monthly_HC_Visits AS
(
SELECT vis.Employee_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_HC_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_HC_Clients,
       SUM( vis.Hours_Served) AS Sum_of_HC_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''HC'' AND cntrct.Billable_Flag = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES''
AND vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Month
),
Emp_Monthly_HH_Visits AS
(
SELECT vis.Employee_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_HH_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_HH_Clients,
       SUM( vis.Hours_Served) AS Sum_of_HH_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''HH'' AND cntrct.Billable_Flag = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' 
AND vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Month
),
Emp_Monthly_OTHER_Visits AS
(
SELECT vis.Employee_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_OTHER_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_OTHER_Clients,
       SUM( vis.Hours_Served) AS Sum_of_OTHER_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) 
AND cntrct.Revenue_Category = ''OTHER'' AND cntrct.Billable_Flag = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' 
AND vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Month
),
Emp_Monthly_NA_Visits AS
(
SELECT vis.Employee_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_NA_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_NA_Clients,
       SUM( vis.Hours_Served) AS Sum_of_NA_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) 
AND cntrct.Revenue_Category = ''NA'' AND cntrct.Billable_Flag = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' 
AND vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Month
),
Emp_Monthly_IS_Visits AS
(
SELECT vis.Employee_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_IS_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_IS_Clients,
       SUM( vis.Hours_Served) AS Sum_of_IS_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''IS'' AND cntrct.Billable_Flag = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' 
AND vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Month
),
Emp_Monthly_NS_Visits AS
(
SELECT vis.Employee_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_NS_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_NS_Clients,
       SUM( vis.Hours_Served) AS Sum_of_NS_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''NS'' AND cntrct.Billable_Flag = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' 
AND vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Month
),
Emp_Service_Line_Metrics AS
(
SELECT em.Employee_Key, emp.SOURCE_SYSTEM_ID, emp.SYSTEM_CODE, em.Service_Month,
       emp.EMPLOYEE_ID, emp.EMPLOYEE_PID, emp.EMPLOYEE_NUMBER, emp.PAYROLL_ID, 
	IFF(hcemp.Number_of_HC_Visits IS NOT NULL,1,0)::INT + 
			IFF(hhemp.Number_of_HH_Visits IS NOT NULL,1,0)::INT + 
			IFF(clsemp.Number_of_CLS_Visits IS NOT NULL,1,0)::INT + 
			IFF(hoemp.Number_of_OTHER_Visits IS NOT NULL,1,0)::INT 
 		AS Number_of_Service_Lines_Provided,
     -- CASE WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NULL AND clsemp.Number_of_CLS_Visits IS NULL THEN 0
--            WHEN hcemp.Number_of_HC_Visits IS NOT NULL AND hhemp.Number_of_HH_Visits IS NULL AND clsemp.Number_of_CLS_Visits IS NULL THEN 1
--            WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NULL THEN 1
--            WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 1
--            WHEN hcemp.Number_of_HC_Visits IS NOT NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NULL THEN 2
--            WHEN hcemp.Number_of_HC_Visits IS NOT NULL AND hhemp.Number_of_HH_Visits IS NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 2
--            WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 2
--            WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 2
--            WHEN hcemp.Number_of_HC_Visits IS NOT NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 3
--       END
-- AS Number_of_Service_Lines_Provided,
       CASE WHEN hcemp.Number_of_HC_Visits IS NOT NULL THEN ''TRUE''
            ELSE ''FALSE''
       END HC_Contract_Services_Provided,
       CASE WHEN hhemp.Number_of_HH_Visits IS NOT NULL THEN ''TRUE''
            ELSE ''FALSE''
       END HH_Contract_Services_Provided,
       CASE WHEN clsemp.Number_of_CLS_Visits IS NOT NULL THEN ''TRUE''
            ELSE ''FALSE''
       END CLS_Contract_Services_Provided,
       CASE WHEN naemp.Number_of_NA_Visits IS NOT NULL THEN ''TRUE''
            ELSE ''FALSE''
       END NA_Contract_Services_Provided,
       CASE WHEN isemp.Number_of_IS_Visits IS NOT NULL THEN ''TRUE''
            ELSE ''FALSE''
       END IS_Contract_Services_Provided,
       CASE WHEN nsemp.Number_of_NS_Visits IS NOT NULL THEN ''TRUE''
            ELSE ''FALSE''
       END NS_Contract_Services_Provided,
	   CASE WHEN hoemp.Number_of_OTHER_Visits IS NOT NULL THEN ''TRUE''
            ELSE ''FALSE''
       END OTHER_Contract_Services_Provided,
       hcemp.Number_of_HC_Visits,
       hcemp.Number_of_Distinct_HC_Clients,
       hcemp.Sum_of_HC_Hours_Served,
       hhemp.Number_of_HH_Visits,
       hhemp.Number_of_Distinct_HH_Clients,
       hhemp.Sum_of_HH_Hours_Served,
       clsemp.Number_of_CLS_Visits,
       clsemp.Number_of_Distinct_CLS_Clients,
       clsemp.Sum_of_CLS_Hours_Served,
       naemp.Number_of_NA_Visits,
       naemp.Number_of_Distinct_NA_Clients,
       naemp.Sum_of_NA_Hours_Served,
       isemp.Number_of_IS_Visits,
       isemp.Number_of_Distinct_IS_Clients,
       isemp.Sum_of_IS_Hours_Served,
       nsemp.Number_of_NS_Visits,
       nsemp.Number_of_Distinct_NS_Clients,
       nsemp.Sum_of_NS_Hours_Served,
	   hoemp.Number_of_OTHER_Visits,
       hoemp.Number_of_Distinct_OTHER_Clients,
       hoemp.Sum_of_OTHER_Hours_Served
FROM Emp_Months AS em
LEFT OUTER JOIN HAH.DIM_Employee AS emp ON em.Employee_Key = emp.Employee_Key
LEFT OUTER JOIN Emp_Monthly_CLS_Visits AS clsemp ON em.Employee_Key = clsemp.Employee_Key AND em.Service_Month = clsemp.Service_Month
LEFT OUTER JOIN Emp_Monthly_HH_Visits AS hhemp ON em.Employee_Key = hhemp.Employee_Key AND em.Service_Month = hhemp.Service_Month
LEFT OUTER JOIN Emp_Monthly_HC_Visits AS hcemp ON em.Employee_Key = hcemp.Employee_Key AND em.Service_Month = hcemp.Service_Month
LEFT OUTER JOIN Emp_Monthly_NA_Visits AS naemp ON em.Employee_Key = naemp.Employee_Key AND em.Service_Month = naemp.Service_Month
LEFT OUTER JOIN Emp_Monthly_IS_Visits AS isemp ON em.Employee_Key = isemp.Employee_Key AND em.Service_Month = isemp.Service_Month
LEFT OUTER JOIN Emp_Monthly_NS_Visits AS nsemp ON em.Employee_Key = nsemp.Employee_Key AND em.Service_Month = nsemp.Service_Month
LEFT OUTER JOIN Emp_Monthly_OTHER_Visits AS hoemp ON em.Employee_Key = hoemp.Employee_Key AND em.Service_Month = hoemp.Service_Month
WHERE (hcemp.Number_of_HC_Visits IS NOT NULL OR hhemp.Number_of_HH_Visits IS NOT NULL OR clsemp.Number_of_CLS_Visits IS NOT NULL OR naemp.Number_of_NA_Visits IS NOT NULL OR isemp.Number_of_IS_Visits IS NOT NULL OR nsemp.Number_of_NS_Visits IS NOT NULL
OR hoemp.Number_of_OTHER_Visits IS NOT NULL)
),
Emp_Tenure_Metrics AS
(
SELECT emv.Employee_Key,
       emv.Source_System_ID,
       emv.Original_Source_System_ID,
       emv.Employee_ID, emv.System_Code, emv.Employee_PID, emv.Employee_Number, emv.Payroll_ID,
       emv.Employee_Category, 
       MIN( emv.Service_Month) AS ACTUAL_FIRST_SERVICE_MONTH,														-- Month for Employees without any confirmed visits - need to use in WHERE clause at the end
       MAX( emv.Service_Month) AS ACTUAL_LAST_SERVICE_MONTH,														-- Month for Employees without any confirmed visits
       COUNT( emv.Confirmed_Service_month) AS Number_Months_with_Service,											-- Taking Confirmed month instead of service_month (as service_month now includes all months)
       MIN( emv.Confirmed_Service_month) AS First_Service_Month,
       MAX( emv.Confirmed_Service_month) AS Last_Service_Month,
       DATEDIFF( ''MONTH'', First_Service_Month, Last_Service_Month) + 1 AS Tenure_In_Months,
       Tenure_In_Months - Number_Months_with_Service AS Number_Months_wo_Service
FROM Emp_Monthly_Visits AS emv
WHERE emv.Number_of_Visits IS NOT NULL
GROUP BY emv.Employee_Key, emv.Source_System_ID, emv.Original_Source_System_ID, emv.Employee_ID, emv.System_Code, emv.Employee_PID, emv.Employee_Number, emv.Payroll_ID, emv.Employee_Category --, emv.Branch_Key, emv.Branch_Name, emv.Branch_State_Code;
),
Emp_Lag_Lead_Metrics AS 						-- Compute LAG and LEAD Metrics
(
SELECT emv.Service_Month,
       emv.Employee_Key,
       emv.Source_System_ID,
       emv.Original_Source_System_ID,
       emv.Employee_ID, emv.System_Code, emv.Employee_PID, emv.Employee_Number, emv.Payroll_ID,
       emv.Employee_Category,
       emv.Branch_Key,
       emv.Branch_Name,
       emv.Branch_State_Code,
       etm.Number_Months_with_Service,
       etm.First_Service_Month,
       etm.Last_Service_Month,
       ETM.ACTUAL_FIRST_SERVICE_MONTH,								-- Added to use in logic below 
	   ETM.ACTUAL_LAST_SERVICE_MONTH,								-- Added 
       etm.Tenure_In_Months,
       etm.Number_Months_wo_Service,
       emv.Number_of_Visits, 
       LAG( emv.Number_of_Visits, 1, 0) over (PARTITION BY emv.Employee_Key ORDER BY emv.Service_Month) AS Previous_Month_Number_Of_Visits,
       LAG( emv.Number_of_Visits, 2, 0) over (PARTITION BY emv.Employee_Key ORDER BY emv.Service_Month) AS Previous_2_Month_Number_Of_Visits,
       LEAD( emv.Number_of_Visits, 1, 0) over (PARTITION BY emv.Employee_Key ORDER BY emv.Service_Month) AS Next_Month_Number_Of_Visits,
       LEAD( emv.Number_of_Visits, 2, 0) over (PARTITION BY emv.Employee_Key ORDER BY emv.Service_Month) AS Next_2_Month_Number_Of_Visits,
       ROW_NUMBER() OVER (PARTITION BY emv.Employee_Key ORDER BY emv.Service_Month) AS SeqNum,
       CASE WHEN NVL( emv.Number_of_Visits, 0) <> 0 THEN ROW_NUMBER() OVER (PARTITION BY emv.Employee_Key ORDER BY emv.Service_Month) ELSE NULL END AS SeqNum_Non_Gap,
       emv.Number_of_Distinct_Clients, 
       LAG( emv.Number_of_Distinct_Clients, 1, 0) over (PARTITION BY emv.Employee_Key ORDER BY emv.Service_Month) AS Previous_Month_Number_Of_Distinct_Clients,
       LAG( emv.Number_of_Distinct_Clients, 2, 0) over (PARTITION BY emv.Employee_Key ORDER BY emv.Service_Month) AS Previous_2_Month_Number_Of_Distinct_Clients,
       LEAD( emv.Number_of_Distinct_Clients, 1, 0) over (PARTITION BY emv.Employee_Key ORDER BY emv.Service_Month) AS Next_Month_Number_Of_Distinct_Clients,
       LEAD( emv.Number_of_Distinct_Clients, 2, 0) over (PARTITION BY emv.Employee_Key ORDER BY emv.Service_Month) AS Next_2_Month_Number_Of_Distinct_Clients,
       emv.Sum_of_Hours_Served,
       LAG( emv.Sum_of_Hours_Served, 1, 0) over (PARTITION BY emv.Employee_Key ORDER BY emv.Service_Month) AS Previous_Month_Sum_of_Hours_Served,
       LAG( emv.Sum_of_Hours_Served, 2, 0) over (PARTITION BY emv.Employee_Key ORDER BY emv.Service_Month) AS Previous_2_Month_Sum_of_Hours_Served,
       LEAD( emv.Sum_of_Hours_Served, 1, 0) over (PARTITION BY emv.Employee_Key ORDER BY emv.Service_Month) AS Next_Month_Sum_of_Hours_Served,
       LEAD( emv.Sum_of_Hours_Served, 2, 0) over (PARTITION BY emv.Employee_Key ORDER BY emv.Service_Month) AS Next_2_Month_Sum_of_Hours_Served,
       CASE WHEN NVL( emv.Sum_of_Hours_Served, 0) <> 0 THEN ''TRUE''
            ELSE ''FALSE''
       END AS Active_Flag,
       CASE WHEN etm.First_Service_Month < emv.Service_Month AND NVL( Previous_Month_Sum_of_Hours_Served, 0) = 0 AND NVL( emv.Sum_of_Hours_Served, 0) > 0 THEN ''TRUE''
            ELSE ''FALSE''
       END AS Reactivated_Flag
FROM Emp_Monthly_Visits AS emv
LEFT OUTER JOIN Emp_Tenure_Metrics AS etm ON emv.Employee_Key = etm.Employee_Key
),
Compute_Emp_Max_Min_Gap AS
(
SELECT x.Employee_Key,x.Source_System_ID, x.Employee_ID, x.System_Code, x.Employee_PID, x.Employee_Number, x.Payroll_ID,
       COUNT( Continuous_Months_wo_Service) AS Number_of_Gaps_in_Service,
       MIN( Continuous_Months_wo_Service) AS Smallest_Gap_in_Service,
       MAX( Continuous_Months_wo_Service) AS Largest_Gap_in_Service
FROM
(
SELECT ellm.Employee_Key,
       ellm.Source_System_ID,
       ellm.Employee_ID, ellm.System_Code, ellm.Employee_PID, ellm.Employee_Number, ellm.Payroll_ID,
       ellm.SeqNum,
       ellm.SeqNum_Non_Gap,
       (SELECT MIN(ellm2.SeqNum_Non_Gap) FROM Emp_Lag_Lead_Metrics AS ellm2 WHERE ellm2.Employee_Key = ellm.Employee_Key AND ellm2.SeqNum_Non_Gap > ellm.SeqNum_Non_Gap) - 1 AS EndSeqNum,
       EndSeqNum - ellm.SeqNum_Non_Gap AS Continuous_Months_wo_Service
FROM Emp_Lag_Lead_Metrics AS ellm
WHERE NOT EXISTS ( SELECT * FROM Emp_Lag_Lead_Metrics AS ellm3 
                   WHERE ellm3.Employee_Key = ellm.Employee_Key
                   AND ellm3.SeqNum_Non_Gap = ellm.SeqNum_Non_Gap + 1)
AND ellm.SeqNum_Non_Gap IS NOT NULL    
AND EndSeqNum IS NOT NULL
) x
GROUP BY x.Employee_Key,x.Source_System_ID, x.Employee_ID, x.System_Code, x.Employee_PID, x.Employee_Number, x.Payroll_ID
),
SERVICE_DATE_DESC AS --NEW_TABLE
(
SELECT vis.EMPLOYEE_KEY, vis.SERVICE_DATE, DATE_TRUNC( ''MONTH'', SERVICE_DATE) AS SERVICE_MONTH, 
LAG(vis.SERVICE_DATE) OVER(PARTITION BY vis.EMPLOYEE_KEY ORDER BY vis.SERVICE_DATE) AS LAST_SERVICE_DATE,
MIN(iff(VIS.CONFIRMED_FLAG IN (''NO'',''UNKNOWN'') 
		AND (VIS.VISIT_STATUS_NAME = ''Future'' OR 
			(VIS.SERVICE_DATE > CURRENT_DATE() AND NVL(VIS.SCHEDULE_STATUS_NAME,''NULL'') NOT IN (''Hold'',''Cancelled'') 
			AND nvl(VIS.VISIT_STATUS_NAME,''NULL'') NOT IN (''Did not happen'',''In Review'')
			)),vis.SERVICE_DATE,NULL))
	over(PARTITION BY vis.EMPLOYEE_KEY) AS NEXT_SCHEDULED_SERVICE_DATE									-- Next future scheduled date which should not be Cancelled/Hold/In Review
FROM INTEGRATION.FACT_VISIT_MERGED vis
),
REHIRED_EMPLOYEE AS --NEW_TABLE
(
SELECT EMPLOYEE_KEY, SERVICE_DATE, SERVICE_MONTH,LAST_SERVICE_DATE 
,SERVICE_DATE_DESC.SERVICE_dATE AS REHIRED_DATE,
DATEDIFF(DAY, SERVICE_DATE_DESC.LAST_SERVICE_DATE, SERVICE_DATE_DESC.SERVICE_dATE) AS DATE_DIFF
FROM SERVICE_DATE_DESC
WHERE DATE_DIFF > 90 
),
NEW_METRICS AS 																							-- New Metrics which includes data for non confirmed visits as well
(
SELECT 
	EMPLOYEE_KEY,
	REPORT_DATE,
	sum(FUTURE_HOURS) AS FUTURE_HOURS,
	sum(HOURS_MISSED) AS HOURS_MISSED,
	sum(FUTURE_VISITS) AS FUTURE_VISITS,
	sum(VISITS_MISSED) AS VISITS_MISSED
FROM REPORT.SCHEDULE_METRICS_MONTHLY 
GROUP BY 
	EMPLOYEE_KEY,
	REPORT_DATE  
)
SELECT DISTINCT ellm.SERVICE_MONTH, 
       ellm.EMPLOYEE_KEY, ellm.SOURCE_SYSTEM_ID, ellm.ORIGINAL_SOURCE_SYSTEM_ID, ellm.EMPLOYEE_ID, ellm.SYSTEM_CODE, ellm.EMPLOYEE_PID, ellm.EMPLOYEE_NUMBER, ellm.PAYROLL_ID, 
       ellm.Employee_Category,
	   CASE WHEN emp.CASE_MANAGER_FLAG = TRUE THEN ''Admin'' ELSE ellm.Employee_Category END AS Derived_Employee_Category,
       emp.Employee_First_Name AS First_Name, 
       emp.Employee_Last_Name AS Last_Name,
       emp.Employee_DOB, emp.Employee_Gender, emp.Employee_Ethnicity,
       NVL( ellm.Branch_Key, emp.Primary_Branch_Key) AS Branch_Key,
       NVL( ellm.Branch_Name, emp.Primary_Branch_Name) AS Branch_Name,
       NVL( ellm.Branch_State_Code, emp.Primary_Branch_State) AS Branch_State_Code,
       ellm.FIRST_SERVICE_MONTH, ellm.LAST_SERVICE_MONTH, 
       CAST( ellm.TENURE_IN_MONTHS AS INTEGER) AS Tenure_In_Months, 
       CAST( ellm.NUMBER_MONTHS_WITH_SERVICE AS INTEGER) AS NUMBER_MONTHS_WITH_SERVICE, 
       CAST( ellm.NUMBER_MONTHS_WO_SERVICE AS INTEGER) AS Number_Months_wo_Service, 
       CAST( NVL( cemmg.Number_of_Gaps_In_Service, 0) AS INTEGER) AS Number_of_Gaps_In_Service, 
       CAST( cemmg.Smallest_Gap_In_Service AS INTEGER) AS Smallest_Gap_In_Service, 
       CAST( cemmg.Largest_Gap_In_Service AS INTEGER) AS Largest_Gap_In_Service,
       CAST( CASE WHEN ellm.FIRST_SERVICE_MONTH = ellm.SERVICE_MONTH THEN ''TRUE''
                  ELSE ''FALSE''
             END 
            AS BOOLEAN) AS New_Hire_Flag,
       CAST( CASE WHEN NVL( ellm.Number_of_Visits, 0) = 0 AND NVL( ellm.Previous_Month_Number_of_Visits, 0) <> 0 THEN ''TRUE''
                  ELSE ''FALSE''
             END
            AS BOOLEAN) AS First_Month_Inactive_Flag,
       CAST( ellm.ACTIVE_FLAG AS BOOLEAN) AS Active_Flag, 
       CAST( REACTIVATED_FLAG AS BOOLEAN) AS Reactivated_Flag,
       CAST( eslm.Number_of_Service_Lines_Provided AS INTEGER) AS Number_of_Service_Lines_Provided,     
       CAST( eslm.HC_Contract_Services_Provided AS BOOLEAN) AS HC_Service_Line_Provided,
       CAST( eslm.HH_Contract_Services_Provided AS BOOLEAN) AS HH_Service_Line_Provided,
       CAST( eslm.CLS_Contract_Services_Provided AS BOOLEAN) AS CLS_Service_Line_Provided,
       CAST( eslm.NA_Contract_Services_Provided AS BOOLEAN) AS NA_Service_Line_Provided,
       CAST( eslm.IS_Contract_Services_Provided AS BOOLEAN) AS IS_Service_Line_Provided,
       CAST( eslm.NS_Contract_Services_Provided AS BOOLEAN) AS NS_Service_Line_Provided,
	   CAST( eslm.OTHER_Contract_Services_Provided AS BOOLEAN) AS OTHER_Service_Line_Provided,
       ellm.NUMBER_OF_VISITS, ellm.PREVIOUS_MONTH_NUMBER_OF_VISITS, ellm.PREVIOUS_2_MONTH_NUMBER_OF_VISITS, ellm.NEXT_MONTH_NUMBER_OF_VISITS, ellm.NEXT_2_MONTH_NUMBER_OF_VISITS, 
       ellm.NUMBER_OF_DISTINCT_CLIENTS, ellm.PREVIOUS_MONTH_NUMBER_OF_DISTINCT_CLIENTS, ellm.PREVIOUS_2_MONTH_NUMBER_OF_DISTINCT_CLIENTS, ellm.NEXT_MONTH_NUMBER_OF_DISTINCT_CLIENTS, ellm.NEXT_2_MONTH_NUMBER_OF_DISTINCT_CLIENTS, 
       CAST( ellm.SUM_OF_HOURS_SERVED AS NUMBER( 9,3)) AS Sum_Of_Hours_Served, 
       CAST( ellm.PREVIOUS_MONTH_SUM_OF_HOURS_SERVED AS NUMBER( 9,3)) AS Previous_Month_Sum_of_Hours_Served, 
       CAST( ellm.PREVIOUS_2_MONTH_SUM_OF_HOURS_SERVED AS NUMBER( 9,3)) AS Previous_2_Month_Sum_of_Hours_Served, 
       CAST( ellm.NEXT_MONTH_SUM_OF_HOURS_SERVED AS NUMBER( 9,3)) AS Next_Month_Sum_Of_Hours_Served, 
       CAST( ellm.NEXT_2_MONTH_SUM_OF_HOURS_SERVED AS NUMBER( 9,3)) AS Next_2_Month_Sum_of_Hours_Served, 
       CAST( NVL( eslm.Number_of_HC_Visits, 0) AS INTEGER) AS Number_of_HC_Visits,
       CAST( NVL( eslm.Number_of_Distinct_HC_Clients, 0) AS INTEGER) AS Number_of_Distinct_HC_Clients,
       CAST( NVL( eslm.Sum_of_HC_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_HC_Hours_Served,
       CAST( NVL( eslm.Number_of_HH_Visits, 0) AS INTEGER) AS Number_of_HH_Visits,
       CAST( NVL( eslm.Number_of_Distinct_HH_Clients, 0) AS INTEGER) AS Number_of_Distinct_HH_Clients,
       CAST( NVL( eslm.Sum_of_HH_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_HH_Hours_Served,
       CAST( NVL( eslm.Number_of_CLS_Visits, 0) AS INTEGER) AS Number_of_CLS_Visits,
       CAST( NVL( eslm.Number_of_Distinct_CLS_Clients, 0) AS INTEGER) AS Number_of_Distinct_CLS_Clients,
       CAST( NVL( eslm.Sum_of_CLS_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_CLS_Hours_Served,
       CAST( NVL( eslm.Number_of_NA_Visits, 0) AS INTEGER) AS Number_of_NA_Visits,
       CAST( NVL( eslm.Number_of_Distinct_NA_Clients, 0) AS INTEGER) AS Number_of_Distinct_NA_Clients,
       CAST( NVL( eslm.Sum_of_NA_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_NA_Hours_Served,
       CAST( NVL( eslm.Number_of_IS_Visits, 0) AS INTEGER) AS Number_of_IS_Visits,
       CAST( NVL( eslm.Number_of_Distinct_IS_Clients, 0) AS INTEGER) AS Number_of_Distinct_IS_Clients,
       CAST( NVL( eslm.Sum_of_IS_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_IS_Hours_Served,
       CAST( NVL( eslm.Number_of_NS_Visits, 0) AS INTEGER) AS Number_of_NS_Visits,
       CAST( NVL( eslm.Number_of_Distinct_NS_Clients, 0) AS INTEGER) AS Number_of_Distinct_NS_Clients,
       CAST( NVL( eslm.Sum_of_NS_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_NS_Hours_Served,
		CAST( NVL( eslm.Number_of_OTHER_Visits, 0) AS INTEGER) AS Number_of_OTHER_Visits,
       CAST( NVL( eslm.Number_of_Distinct_OTHER_Clients, 0) AS INTEGER) AS Number_of_Distinct_OTHER_Clients,
       CAST( NVL( eslm.Sum_of_OTHER_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_OTHER_Hours_Served,
       NM.FUTURE_HOURS,												-- New fields
       NM.HOURS_MISSED,												-- New fields
	   NM.FUTURE_VISITS,											-- New fields
	   NM.VISITS_MISSED,											-- New fields
		IFF(COALESCE(CCSI_BRANCH.EMPLOYEE_KEY,CCSI_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY,MATRIXCARE_EMPLOYEE.EMPLOYEE_KEY,ALAYACARE_EMPLOYEE.EMPLOYEE_KEY,PRAETORIAN_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY,PREFERRED_ACQUIRE_EMPLOYEE.EMPLOYEE_KEY,EDISON_EMPLOYEE.EMPLOYEE_KEY,LONGEVITY_EMPLOYEE.EMPLOYEE_KEY,MERIDIUS_EMPLOYEE.EMPLOYEE_KEY,ASR_EMPLOYEE.EMPLOYEE_KEY,CLEARCARE_EMPLOYEE.EMPLOYEE_KEY) IS NULL, FALSE, TRUE) AS EMPLOYEE_ACQUIRED_FLAG,
      CASE WHEN COALESCE(CCSI_BRANCH.EMPLOYEE_KEY,CCSI_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY) IS NOT NULL THEN ''CCSI'' 
        WHEN MATRIXCARE_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''ADAPTIVE''
        WHEN ALAYACARE_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN UPPER(ALAYACARE_EMPLOYEE.AQUISITION_NAME)
        WHEN PRAETORIAN_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''PRAETORIAN''
        WHEN PREFERRED_ACQUIRE_EMPLOYEE.EMPLOYEE_KEY  IS NOT NULL THEN ''PREFERRED''
        WHEN EDISON_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''EDISON''
        WHEN LONGEVITY_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''LONGEVITY''
        WHEN MERIDIUS_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''MERIDIUS''
		WHEN ASR_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''ASR''
        WHEN CLEARCARE_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''CLEARCARE''
	    ELSE NULL END  AS EMPLOYEE_ACQUISITION_NAME,
		CASE WHEN U.EMPLOYEE_ID IS NOT NULL THEN ''TRUE'' ELSE ''FALSE'' END AS UNION_FLAG,
        CASE 
			WHEN (CAST( ellm.ACTIVE_FLAG AS BOOLEAN) = FALSE OR CAST(New_Hire_Flag AS BOOLEAN) = TRUE) THEN ''FALSE''
          WHEN RE.EMPLOYEE_KEY IS NOT NULL THEN ''TRUE''
          ELSE ''FALSE''
          END AS REHIRED_FLAG,  
		RE.REHIRED_DATE,
        EDM.APPLICANT_ID,
        EDM.APPLICANT_HIRED_DATE,
        EDM.DATE_APPLIED,
        EDM.APPLICATION_TO_HIRE_DAYS,
        EDM.FIRST_SERVICE_AFTER_REHIRE,
        EDM.HIRE_TO_FIRST_SERVICE_DAYS,
		EDM.DERIVED_FIRST_SERVICE_DATE,
		SD.NEXT_SCHEDULED_SERVICE_DATE							  											-- New field
FROM Emp_Lag_Lead_Metrics AS ellm
LEFT OUTER JOIN INTEGRATION.DIM_EMPLOYEE_MERGED AS emp ON ellm.Employee_Key = emp.Employee_Key
LEFT OUTER JOIN Compute_Emp_Max_Min_Gap AS cemmg ON ellm.Employee_Key = cemmg.Employee_Key
LEFT OUTER JOIN Emp_Service_Line_Metrics AS eslm ON ellm.Employee_Key = eslm.Employee_Key AND ellm.Service_Month = eslm.Service_Month
LEFT JOIN DW_${var.SF_ENVIRONMENT}.REPORT.EMPLOYEE_DERIVED_METRICS EDM ON EDM.EMPLOYEE_KEY = ellm.Employee_Key
-- LEFT OUTER JOIN (SELECT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID = 8) CCSI_BRANCH
--                        ON CCSI_BRANCH.BRANCH_KEY = NVL( ellm.Branch_Key, emp.Primary_Branch_Key)
   LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED CCSI_BRANCH ON 
   CCSI_BRANCH.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (CCSI_BRANCH.BRANCH_KEY = ellm.Branch_Key OR  
   		CCSI_BRANCH.original_branch_key = emp.Primary_Branch_Key )  
   AND CCSI_BRANCH.AQUISITION_NAME =''CCSI''
   AND CCSI_BRANCH.SERVICE_MONTH = ellm.SERVICE_MONTH
LEFT OUTER JOIN (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_EMPLOYEE_ACQUIRED WHERE AQUISITION_NAME = ''CCSI'') CCSI_ACQUIRED_EMPLOYEE
            ON CCSI_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY = ellm.EMPLOYEE_KEY AND ellm.SERVICE_MONTH >= ''2021-07-01''
--   LEFT OUTER JOIN (SELECT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID = 7 AND BRANCH_NAME LIKE ''A_%'') MATRIXCARE_BRANCH
--                        ON MATRIXCARE_BRANCH.BRANCH_KEY = NVL( ellm.Branch_Key, emp.Primary_Branch_Key)
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED MATRIXCARE_EMPLOYEE ON 
   MATRIXCARE_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (MATRIXCARE_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR MATRIXCARE_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND MATRIXCARE_EMPLOYEE.AQUISITION_NAME =''ADAPTIVE''
   AND MATRIXCARE_EMPLOYEE.SERVICE_MONTH = ellm.SERVICE_MONTH
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED ALAYACARE_EMPLOYEE ON 
   ALAYACARE_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (ALAYACARE_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR ALAYACARE_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key) 
   AND ALAYACARE_EMPLOYEE.SOURCE_SYSTEM_ID  =9
   AND ALAYACARE_EMPLOYEE.SERVICE_MONTH = ellm.SERVICE_MONTH
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED PRAETORIAN_ACQUIRED_EMPLOYEE ON 
   PRAETORIAN_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (PRAETORIAN_ACQUIRED_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR PRAETORIAN_ACQUIRED_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key) 
   AND PRAETORIAN_ACQUIRED_EMPLOYEE.AQUISITION_NAME =''Praetorian''
   AND PRAETORIAN_ACQUIRED_EMPLOYEE.SERVICE_MONTH = ellm.SERVICE_MONTH
   AND ellm.SERVICE_MONTH >= ''2022-01-01''
--LEFT OUTER JOIN (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_EMPLOYEE_ACQUIRED_MERGED WHERE NOTES = ''Preferred'') PREFERRED_EMPLOYEE
--         ON PREFERRED_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY 
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED PREFERRED_ACQUIRE_EMPLOYEE ON 
   PREFERRED_ACQUIRE_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (PREFERRED_ACQUIRE_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR PREFERRED_ACQUIRE_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND PREFERRED_ACQUIRE_EMPLOYEE.AQUISITION_NAME =''PREFERRED''
   AND PREFERRED_ACQUIRE_EMPLOYEE.SERVICE_MONTH = ellm.SERVICE_MONTH
--       LEFT OUTER JOIN (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_EMPLOYEE_ACQUIRED_MERGED WHERE NOTES = ''Edison'') EDISON_EMPLOYEE
--         ON EDISON_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY 
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED EDISON_EMPLOYEE ON 
   EDISON_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (EDISON_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR EDISON_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND EDISON_EMPLOYEE.AQUISITION_NAME =''EDISON''
   AND EDISON_EMPLOYEE.SERVICE_MONTH = ellm.SERVICE_MONTH
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED LONGEVITY_EMPLOYEE ON 
   LONGEVITY_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (LONGEVITY_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR LONGEVITY_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND LONGEVITY_EMPLOYEE.AQUISITION_NAME =''Longevity''
   AND LONGEVITY_EMPLOYEE.SERVICE_MONTH = ellm.SERVICE_MONTH
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED MERIDIUS_EMPLOYEE ON 
   MERIDIUS_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (MERIDIUS_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR MERIDIUS_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND MERIDIUS_EMPLOYEE.AQUISITION_NAME =''Meridius''
   AND MERIDIUS_EMPLOYEE.SERVICE_MONTH = ellm.SERVICE_MONTH
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED ASR_EMPLOYEE ON 
   ASR_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (ASR_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR ASR_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND ASR_EMPLOYEE.AQUISITION_NAME =''ASR''
   AND ASR_EMPLOYEE.SERVICE_MONTH  = ellm.SERVICE_MONTH
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED CLEARCARE_EMPLOYEE ON 
   CLEARCARE_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (CLEARCARE_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR CLEARCARE_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND CLEARCARE_EMPLOYEE.AQUISITION_NAME =''CLEARCARE''
   AND CLEARCARE_EMPLOYEE.SERVICE_MONTH  = ellm.SERVICE_MONTH
LEFT JOIN HAH.FACT_PAYROLL PAY ON PAY.EMPLOYEE_KEY = ellm.EMPLOYEE_KEY AND DATE_TRUNC(''MONTH'',PAY.REPORT_DATE)=ellm.SERVICE_MONTH
LEFT JOIN (SELECT DISTINCT UPPER(TRIM(DFE.DBNAME)) SYSTEM_CODE, UPPER(TRIM(DFE.NUMBER)) EMPLOYEE_ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.GPSYNCDATA.EMPLOYEE_MASTER_LIST M  
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_Master AS m1 ON m1.DB||''-''||m1.EMPLOYEEID = M.MASTER_ID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_DetailLine dl1 ON m1.CheckID = dl1.CheckID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DfEmployees AS dfe ON TRIM( dfe.PayrollID) = TRIM( M.Employee_ID) AND TRIM( dfe.DBName) = TRIM( M.Office_State) 
	--JOIN INTEGRATION.DIM_EMPLOYEE_MERGED E ON E.SYSTEM_CODE = UPPER(TRIM(DFE.DBNAME)) AND UPPER(TRIM(DFE.NUMBER)) = E.EMPLOYEE_ID 
WHERE UPPER( TRIM( dl1.PayCode)) IN ( ''INDUES'', ''UNION'', ''DUESM'')) U ON U.SYSTEM_CODE=ELLM.SYSTEM_CODE AND U.EMPLOYEE_ID=ELLM.EMPLOYEE_ID
LEFT JOIN REHIRED_EMPLOYEE RE ON RE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY AND ELLM.SERVICE_MONTH = RE.SERVICE_MONTH
LEFT JOIN NEW_METRICS NM ON NM.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY AND NM.REPORT_DATE = ELLM.SERVICE_MONTH					--
LEFT JOIN SERVICE_DATE_DESC SD ON SD.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY													-- 
WHERE ellm.Service_Month BETWEEN COALESCE(ellm.First_Service_Month, ELLM.ACTUAL_FIRST_SERVICE_MONTH) 					-- Using Actual months for Employees w/o any Conf_Visits
								AND DATEADD( ''MONTH'', 1, COALESCE(ellm.Last_Service_Month, ELLM.ACTUAL_LAST_SERVICE_MONTH ));
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

