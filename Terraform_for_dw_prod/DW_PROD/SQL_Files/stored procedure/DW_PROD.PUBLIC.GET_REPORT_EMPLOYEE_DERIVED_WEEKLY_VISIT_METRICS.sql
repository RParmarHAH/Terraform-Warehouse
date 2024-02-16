CREATE OR REPLACE PROCEDURE DW_PROD.PUBLIC.GET_REPORT_EMPLOYEE_DERIVED_WEEKLY_VISIT_METRICS("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
        var sql = `
    --*****************************************************************************************************************************
-- NAME:  Employee_Derived_Weekly_Visit_Metrics
--
-- PURPOSE: Creates derived weekly metrics for each employee based on visit/service data
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 11/16/20    Frank Noordover       Initial development
-- 06/24/21    Shraddha Sejpal		 Used merged view for FACTs and DIMs
--*****************************************************************************************************************************

INSERT OVERWRITE INTO Report.Employee_Derived_Weekly_Visit_Metrics
WITH Bill_Only_Employees AS
(
SELECT *
FROM HAH.DIM_EMPLOYEE AS emp
WHERE (UPPER( Employee_First_Name) LIKE ''%BILL%'' AND UPPER( Employee_Last_Name) LIKE ''%ONLY%'')
OR UPPER( Employee_First_Name) LIKE ANY ( ''%BILL%ONLY%'', ''%FIELD%STAFF%'', ''%CAREGIVER%'', ''%TEST%PROFILE%'', ''%IMPLEMENT%'', ''%EMPLOYEE%'', ''%DO%NOT%USE%'', ''%OFFICE%'')
OR UPPER( Employee_Last_Name) LIKE ANY ( ''%BILL%ONLY%'', ''%FIELD%STAFF%'', ''%CAREGIVER%'', ''%TEST%PROFILE%'', ''%IMPLEMENT%'', ''%EMPLOYEE%'', ''%DO%NOT%USE%'', ''%OFFICE%'')
OR UPPER( Employee_First_Name) = ''TEST''
OR UPPER( Employee_Last_Name) = ''TEST''
ORDER BY Primary_Branch_State, Primary_Branch_Key
),
Calendar_Weeks AS  -- get calendar months for months we have service/visit data
(
	SELECT HAH_CURRENT_WEEK_FIRST_DAY AS Calendar_Week_First_Day
    FROM HAH.DIM_DATE
    WHERE Calendar_Date BETWEEN CAST( ''2013-01-01'' AS DATE) AND DATEADD( ''WEEK'', 1, CURRENT_DATE())
	GROUP BY 1
    ORDER BY 1
),
Emp_List AS  -- Get a list of employees who provided visits within the calendar period
(
    SELECT DISTINCT  vis.EMPLOYEE_KEY 
	FROM INTEGRATION.FACT_VISIT_MERGED AS vis
    INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_KEY = cntrct.Contract_KEY AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0)
    WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
    AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
    AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
    AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Emp_Weeks AS  -- Create a list of every week for each employee
(
SELECT cw.Calendar_Week_First_Day AS Service_Week,
       el.Employee_Key
FROM Calendar_Weeks AS cw
FULL OUTER JOIN Emp_List AS el
WHERE cw.Calendar_Week_First_Day IS NOT NULL
ORDER BY el.Employee_Key, cw.Calendar_Week_First_Day
),
Emp_Visit_Max_Hours_By_Week AS  -- Figure out which branch had the most hours for every service/visit month the employee delivered services/visits
(
SELECT Employee_Key, Service_Week,
       MAX( Sum_of_Hours_Served) AS Max_Hours_Served 
FROM
    (
     SELECT vis.Employee_Key, VIS.BRANCH_KEY,
            HAH_CURRENT_WEEK_FIRST_DAY AS Service_Week,
            SUM( vis.Hours_Served) AS Sum_of_Hours_Served
     FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
     INNER JOIN HAH.DIM_DATE DT ON DT.CALENDAR_dATE = VIS.SERVICE_DATE
     INNER JOIN HAH.DIM_Contract AS cntrct ON vis.CONTRACT_KEY = cntrct.CONTRACT_KEY AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0)
     WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
     AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
     AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
     AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
     GROUP BY vis.Employee_Key, Service_Week, VIS.BRANCH_KEY
    ) x
GROUP BY Employee_Key, Service_Week
),
Employee_Visit_Primary_Branch AS 
(
SELECT Employee_Key, Service_Week, Sum_of_Hours_Served, MAX( Branch_Key) AS Branch_Key
FROM
(
SELECT vis.Employee_Key, 
       vis.Branch_Key AS Branch_Key,
       brnch.Branch_Name AS Branch_Name,
       brnch.Office_State_Code AS Branch_State_Code,
       HAH_CURRENT_WEEK_FIRST_DAY AS Service_Week,
       SUM( vis.Hours_Served) AS Sum_of_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis
  INNER JOIN HAH.DIM_DATE DT ON DT.CALENDAR_dATE = VIS.SERVICE_DATE
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.CONTRACT_KEY = cntrct.CONTRACT_KEY AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0)
INNER JOIN Emp_Visit_Max_Hours_By_Week AS evmhbw ON vis.Employee_Key = evmhbw.Employee_Key AND HAH_CURRENT_WEEK_FIRST_DAY = evmhbw.Service_Week 
LEFT OUTER JOIN HAH.DIM_BRANCH AS brnch on brnch.Branch_Key = vis.BRANCH_KEY
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, vis.Branch_Key, brnch.Branch_Name, brnch.Office_State_Code, HAH_CURRENT_WEEK_FIRST_DAY, evmhbw.Max_Hours_Served
HAVING SUM( vis.Hours_Served) = evmhbw.Max_Hours_Served
) x
GROUP BY Employee_Key, Service_Week, Sum_of_Hours_Served
),
Emp_Visits AS  -- Compile metrics for every service/visit month the employee delivered services/visits
(
SELECT vis.Employee_Key, 
       HAH_CURRENT_WEEK_FIRST_DAY AS Service_Week,
       brnch.Branch_Key,
       brnch2.Branch_Name,
       brnch2.Office_State_Code AS Branch_State_Code,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_Clients,
       SUM( vis.Hours_Served) AS Sum_of_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
  INNER JOIN HAH.DIM_DATE DT ON DT.CALENDAR_dATE = VIS.SERVICE_DATE
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.CONTRACT_KEY = cntrct.CONTRACT_KEY AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0)
LEFT OUTER JOIN Employee_Visit_Primary_Branch AS brnch ON vis.Employee_Key = brnch.Employee_Key AND HAH_CURRENT_WEEK_FIRST_DAY = brnch.Service_Week
LEFT OUTER JOIN HAH.DIM_BRANCH AS brnch2 on brnch2.Branch_Key = brnch.Branch_Key
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
GROUP BY vis.Employee_Key, HAH_CURRENT_WEEK_FIRST_DAY, brnch.Branch_Key, brnch2.Branch_Name, brnch2.Office_State_Code
),  
Emp_Weekly_Visits AS -- Put visits and monthly employees together
(
SELECT distinct ew.Service_Week,
       ew.Employee_Key,
       emp.Employee_ID, 
       emp.source_system_id,
       FIRST_VALUE(emp.Original_Source_System_Id) OVER (PARTITION BY ew.Employee_Key ORDER BY IFF(emp.Original_Source_System_ID <> emp.Source_System_ID, 0, 1)) AS Original_Source_System_ID, 
       emp.System_Code, emp.Employee_PID, emp.Employee_Number, emp.Payroll_ID,
       emp.Employee_Category,
       ev.Branch_Key,
       ev.Branch_Name,
       ev.Branch_State_Code,
       ev.Number_of_Visits,
       ev.Number_of_Distinct_Clients,
       ev.Sum_of_Hours_Served
FROM Emp_Weeks AS ew
LEFT OUTER JOIN Emp_Visits AS ev ON ew.Service_Week = ev.Service_Week AND ew.Employee_Key = ev.Employee_Key
LEFT OUTER JOIN INTEGRATION.DIM_EMPLOYEE_MERGED AS emp ON ew.Employee_Key = emp.Employee_Key
WHERE ew.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Emp_Weekly_CLS_Visits AS
(
SELECT vis.Employee_Key, 
       HAH_CURRENT_WEEK_FIRST_DAY AS Service_Week,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_CLS_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_CLS_Clients,
       SUM( vis.Hours_Served) AS Sum_of_CLS_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
   INNER JOIN HAH.DIM_DATE DT ON DT.CALENDAR_dATE = VIS.SERVICE_DATE
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_key = cntrct.Contract_key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''CLS''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Week
),
Emp_Weekly_HC_Visits AS
(
SELECT vis.Employee_Key, 
       HAH_CURRENT_WEEK_FIRST_DAY AS Service_Week,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_HC_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_HC_Clients,
       SUM( vis.Hours_Served) AS Sum_of_HC_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_DATE DT ON DT.CALENDAR_dATE = VIS.SERVICE_DATE
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_key = cntrct.Contract_key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''HC''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Week
),
Emp_Weekly_HH_Visits AS
(
SELECT vis.Employee_Key,
      HAH_CURRENT_WEEK_FIRST_DAY AS Service_Week,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_HH_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_HH_Clients,
       SUM( vis.Hours_Served) AS Sum_of_HH_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_DATE DT ON DT.CALENDAR_dATE = VIS.SERVICE_DATE
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_key = cntrct.Contract_key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''HH''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Week
),
Emp_Weekly_NA_Visits AS
(
SELECT vis.Employee_Key, 
       HAH_CURRENT_WEEK_FIRST_DAY AS Service_Week,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_NA_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_NA_Clients,
       SUM( vis.Hours_Served) AS Sum_of_NA_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_DATE DT ON DT.CALENDAR_dATE = VIS.SERVICE_DATE
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_key = cntrct.Contract_key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''NA''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Week
),
Emp_Weekly_IS_Visits AS
(
SELECT vis.Employee_Key, 
       HAH_CURRENT_WEEK_FIRST_DAY AS Service_Week,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_IS_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_IS_Clients,
       SUM( vis.Hours_Served) AS Sum_of_IS_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
  INNER JOIN HAH.DIM_DATE DT ON DT.CALENDAR_dATE = VIS.SERVICE_DATE
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_key = cntrct.Contract_key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''IS''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Week
),
Emp_Weekly_NS_Visits AS
(
SELECT vis.Employee_Key, 
       HAH_CURRENT_WEEK_FIRST_DAY AS Service_Week,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_NS_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_NS_Clients,
       SUM( vis.Hours_Served) AS Sum_of_NS_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
  INNER JOIN HAH.DIM_DATE DT ON DT.CALENDAR_dATE = VIS.SERVICE_DATE
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_key = cntrct.Contract_key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''NS''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Week
),
Emp_Service_Line_Metrics AS
(
SELECT ew.Employee_Key, emp.SOURCE_SYSTEM_ID, emp.SYSTEM_CODE, ew.Service_Week,
       emp.EMPLOYEE_ID, emp.EMPLOYEE_PID, emp.EMPLOYEE_NUMBER, emp.PAYROLL_ID, 
       CASE WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NULL AND clsemp.Number_of_CLS_Visits IS NULL THEN 0
            WHEN hcemp.Number_of_HC_Visits IS NOT NULL AND hhemp.Number_of_HH_Visits IS NULL AND clsemp.Number_of_CLS_Visits IS NULL THEN 1
            WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NULL THEN 1
            WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 1
            WHEN hcemp.Number_of_HC_Visits IS NOT NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NULL THEN 2
            WHEN hcemp.Number_of_HC_Visits IS NOT NULL AND hhemp.Number_of_HH_Visits IS NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 2
            WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 2
            WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 2
            WHEN hcemp.Number_of_HC_Visits IS NOT NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 3
       END AS Number_of_Service_Lines_Provided,
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
       nsemp.Sum_of_NS_Hours_Served
FROM Emp_Weeks AS ew
LEFT OUTER JOIN HAH.DIM_EMPLOYEE AS emp ON ew.Employee_Key = emp.Employee_Key
LEFT OUTER JOIN Emp_Weekly_CLS_Visits AS clsemp ON ew.Employee_Key = clsemp.Employee_Key AND ew.Service_Week = clsemp.Service_Week
LEFT OUTER JOIN Emp_Weekly_HH_Visits AS hhemp ON ew.Employee_Key = hhemp.Employee_Key AND ew.Service_Week = hhemp.Service_Week
LEFT OUTER JOIN Emp_Weekly_HC_Visits AS hcemp ON ew.Employee_Key = hcemp.Employee_Key AND ew.Service_Week = hcemp.Service_Week
LEFT OUTER JOIN Emp_Weekly_NA_Visits AS naemp ON ew.Employee_Key = naemp.Employee_Key AND ew.Service_Week = naemp.Service_Week
LEFT OUTER JOIN Emp_Weekly_IS_Visits AS isemp ON ew.Employee_Key = isemp.Employee_Key AND ew.Service_Week = isemp.Service_Week
LEFT OUTER JOIN Emp_Weekly_NS_Visits AS nsemp ON ew.Employee_Key = nsemp.Employee_Key AND ew.Service_Week = nsemp.Service_Week
WHERE (hcemp.Number_of_HC_Visits IS NOT NULL OR hhemp.Number_of_HH_Visits IS NOT NULL OR clsemp.Number_of_CLS_Visits IS NOT NULL OR naemp.Number_of_NA_Visits IS NOT NULL OR isemp.Number_of_IS_Visits IS NOT NULL OR nsemp.Number_of_NS_Visits IS NOT NULL)
),
Emp_Tenure_Metrics AS
(
SELECT ewv.Employee_Key,
       ewv.Source_System_ID,
       ewv.ORIGINAL_SOURCE_SYSTEM_ID,
       ewv.Employee_ID, ewv.System_Code, ewv.Employee_PID, ewv.Employee_Number, ewv.Payroll_ID,
       ewv.Employee_Category,
       COUNT( ewv.Service_Week) AS Number_Weeks_with_Service,
       MIN( ewv.Service_Week) AS First_Service_Week,
       MAX( ewv.Service_Week) AS Last_Service_Week,
       DATEDIFF( ''WEEK'', First_Service_Week, Last_Service_Week) + 1 AS Tenure_In_Weeks,
       Tenure_In_Weeks - Number_Weeks_with_Service AS Number_Weeks_wo_Service
FROM Emp_Weekly_Visits AS ewv
WHERE ewv.Number_of_Visits IS NOT NULL
GROUP BY ewv.Employee_Key, ewv.Source_System_ID, ewv.original_Source_System_ID, ewv.Employee_ID, ewv.System_Code, ewv.Employee_PID, ewv.Employee_Number, ewv.Payroll_ID, ewv.Employee_Category --, ewv.Branch_Key, ewv.Branch_Name, ewv.Branch_State_Code;
),
Emp_Lag_Lead_Metrics AS -- Compute LAG and LEAD Metrics
(
SELECT ewv.Service_Week,
       ewv.Employee_Key,
       ewv.Source_System_ID,
       ewv.Original_Source_System_ID,
       ewv.Employee_ID, ewv.System_Code, ewv.Employee_PID, ewv.Employee_Number, ewv.Payroll_ID,
       ewv.Employee_Category,
       ewv.Branch_Key,
       ewv.Branch_Name,
       ewv.Branch_State_Code,
       etm.Number_Weeks_with_Service,
       etm.First_Service_Week,
       etm.Last_Service_Week,
       etm.Tenure_In_Weeks,
       etm.Number_Weeks_wo_Service,
       ewv.Number_of_Visits, 
       LAG( ewv.Number_of_Visits, 1, 0) over (PARTITION BY ewv.employee_key ORDER BY ewv.Service_Week) AS Previous_Week_Number_Of_Visits,
       LAG( ewv.Number_of_Visits, 2, 0) over (PARTITION BY ewv.employee_key ORDER BY ewv.Service_Week) AS Previous_2_Week_Number_Of_Visits,
       LEAD( ewv.Number_of_Visits, 1, 0) over (PARTITION BY ewv.employee_key ORDER BY ewv.Service_Week) AS Next_Week_Number_Of_Visits,
       LEAD( ewv.Number_of_Visits, 2, 0) over (PARTITION BY ewv.employee_key ORDER BY ewv.Service_Week) AS Next_2_Week_Number_Of_Visits,
       ROW_NUMBER() OVER (PARTITION BY ewv.employee_key ORDER BY ewv.Service_Week) AS SeqNum,
       CASE WHEN NVL( ewv.Number_of_Visits, 0) <> 0 THEN ROW_NUMBER() OVER (PARTITION BY ewv.employee_key ORDER BY ewv.Service_Week) ELSE NULL END AS SeqNum_Non_Gap,
       ewv.Number_of_Distinct_Clients, 
       LAG( ewv.Number_of_Distinct_Clients, 1, 0) over (PARTITION BY ewv.employee_key ORDER BY ewv.Service_Week) AS Previous_Week_Number_Of_Distinct_Clients,
       LAG( ewv.Number_of_Distinct_Clients, 2, 0) over (PARTITION BY ewv.employee_key ORDER BY ewv.Service_Week) AS Previous_2_Week_Number_Of_Distinct_Clients,
       LEAD( ewv.Number_of_Distinct_Clients, 1, 0) over (PARTITION BY ewv.employee_key ORDER BY ewv.Service_Week) AS Next_Week_Number_Of_Distinct_Clients,
       LEAD( ewv.Number_of_Distinct_Clients, 2, 0) over (PARTITION BY ewv.employee_key ORDER BY ewv.Service_Week) AS Next_2_Week_Number_Of_Distinct_Clients,
       ewv.Sum_of_Hours_Served,
       LAG( ewv.Sum_of_Hours_Served, 1, 0) over (PARTITION BY ewv.employee_key ORDER BY ewv.Service_Week) AS Previous_Week_Sum_of_Hours_Served,
       LAG( ewv.Sum_of_Hours_Served, 2, 0) over (PARTITION BY ewv.employee_key ORDER BY ewv.Service_Week) AS Previous_2_Week_Sum_of_Hours_Served,
       LEAD( ewv.Sum_of_Hours_Served, 1, 0) over (PARTITION BY ewv.employee_key ORDER BY ewv.Service_Week) AS Next_Week_Sum_of_Hours_Served,
       LEAD( ewv.Sum_of_Hours_Served, 2, 0) over (PARTITION BY ewv.employee_key ORDER BY ewv.Service_Week) AS Next_2_Week_Sum_of_Hours_Served,
       CASE WHEN NVL( ewv.Sum_of_Hours_Served, 0) <> 0 THEN ''TRUE''
            ELSE ''FALSE''
       END AS Active_Flag,
       CASE WHEN etm.First_Service_Week < ewv.Service_Week AND NVL( Previous_Week_Sum_of_Hours_Served, 0) = 0 AND NVL( ewv.Sum_of_Hours_Served, 0) > 0 THEN ''TRUE''
            ELSE ''FALSE''
       END AS Reactivated_Flag
FROM Emp_Weekly_Visits AS ewv
LEFT OUTER JOIN Emp_Tenure_Metrics AS etm ON ewv.employee_key = etm.employee_key
),
Compute_Emp_Max_Min_Gap AS
(
SELECT x.employee_key,x.Source_System_ID, x.Employee_ID, x.System_Code, x.Employee_PID, x.Employee_Number, x.Payroll_ID,
       COUNT( Continuous_Weeks_wo_Service) AS Number_of_Gaps_in_Service,
       MIN( Continuous_Weeks_wo_Service) AS Smallest_Gap_in_Service,
       MAX( Continuous_Weeks_wo_Service) AS Largest_Gap_in_Service
FROM
(
SELECT ellm.employee_key,
       ellm.Source_System_ID,
       ellm.Employee_ID, ellm.System_Code, ellm.Employee_PID, ellm.Employee_Number, ellm.Payroll_ID,
       ellm.SeqNum,
       ellm.SeqNum_Non_Gap,
       (SELECT MIN(ellm2.SeqNum_Non_Gap) FROM Emp_Lag_Lead_Metrics AS ellm2 WHERE ellm2.employee_key = ellm.employee_key AND ellm2.SeqNum_Non_Gap > ellm.SeqNum_Non_Gap) - 1 AS EndSeqNum,
       EndSeqNum - ellm.SeqNum_Non_Gap AS Continuous_Weeks_wo_Service
FROM Emp_Lag_Lead_Metrics AS ellm
WHERE NOT EXISTS ( SELECT * FROM Emp_Lag_Lead_Metrics AS ellm3 
                   WHERE ellm3.employee_key = ellm.employee_key
                   AND ellm3.SeqNum_Non_Gap = ellm.SeqNum_Non_Gap + 1)
AND ellm.SeqNum_Non_Gap IS NOT NULL    
AND EndSeqNum IS NOT NULL
) x
GROUP BY x.employee_key,x.Source_System_ID, x.Employee_ID, x.System_Code, x.Employee_PID, x.Employee_Number, x.Payroll_ID
)
SELECT DISTINCT ellm.SERVICE_Week,
 DATEADD( ''DAY'', 6, ellm.Service_Week) AS Service_Week_End_Date,
ellm.EMPLOYEE_KEY, ellm.SOURCE_SYSTEM_ID, ELLM.ORIGINAL_SOURCE_SYSTEM_ID, ellm.EMPLOYEE_ID, ellm.SYSTEM_CODE, ellm.EMPLOYEE_PID, ellm.EMPLOYEE_NUMBER, ellm.PAYROLL_ID, 
ellm.Employee_Category,
CASE WHEN emp.CASE_MANAGER_FLAG = TRUE THEN ''Admin'' ELSE ellm.Employee_Category END AS Derived_Employee_Category,
emp.Employee_First_Name AS First_Name, 
emp.Employee_Last_Name AS Last_Name,
        NVL( ellm.Branch_Key, emp.Primary_Branch_Key) AS Branch_Key,
       NVL( ellm.Branch_Name, emp.Primary_Branch_Name) AS Branch_Name,
       NVL( ellm.Branch_State_Code, emp.Primary_Branch_State) AS Branch_State_Code,
       ellm.FIRST_SERVICE_Week, 
       DATEADD( ''DAY'', 6, ellm.First_Service_Week) AS First_Service_Week_End_Date,
       ellm.LAST_SERVICE_Week, 
       DATEADD( ''DAY'', 6, ellm.Last_Service_Week) AS Last_Service_Week_End_Date,
       CAST( ellm.TENURE_IN_Weeks AS INTEGER) AS Tenure_In_Weeks, 
       CAST( ellm.NUMBER_Weeks_WITH_SERVICE AS INTEGER) AS NUMBER_Weeks_WITH_SERVICE, 
       CAST( ellm.NUMBER_Weeks_WO_SERVICE AS INTEGER) AS Number_Weeks_wo_Service, 
       CAST( NVL( cemmg.Number_of_Gaps_In_Service, 0) AS INTEGER) AS Number_of_Gaps_In_Service, 
       CAST( cemmg.Smallest_Gap_In_Service AS INTEGER) AS Smallest_Gap_In_Service, 
       CAST( cemmg.Largest_Gap_In_Service AS INTEGER) AS Largest_Gap_In_Service,
       CAST( CASE WHEN ellm.FIRST_SERVICE_Week = ellm.SERVICE_Week THEN ''TRUE''
                  ELSE ''FALSE''
             END 
            AS BOOLEAN) AS New_Hire_Flag,
       CAST( CASE WHEN NVL( ellm.Number_of_Visits, 0) = 0 AND NVL( ellm.Previous_Week_Number_of_Visits, 0) <> 0 THEN ''TRUE''
                  ELSE ''FALSE''
             END
            AS BOOLEAN) AS First_Week_Inactive_Flag,
       CAST( ellm.ACTIVE_FLAG AS BOOLEAN) AS Active_Flag, 
       CAST( REACTIVATED_FLAG AS BOOLEAN) AS Reactivated_Flag,
       CAST( eslm.Number_of_Service_Lines_Provided AS INTEGER) AS Number_of_Service_Lines_Provided,     
       CAST( eslm.HC_Contract_Services_Provided AS BOOLEAN) AS HC_Service_Line_Provided,
       CAST( eslm.HH_Contract_Services_Provided AS BOOLEAN) AS HH_Service_Line_Provided,
       CAST( eslm.CLS_Contract_Services_Provided AS BOOLEAN) AS CLS_Service_Line_Provided,
       CAST( eslm.NA_Contract_Services_Provided AS BOOLEAN) AS NA_Service_Line_Provided,
       CAST( eslm.IS_Contract_Services_Provided AS BOOLEAN) AS IS_Service_Line_Provided,
       CAST( eslm.NS_Contract_Services_Provided AS BOOLEAN) AS NS_Service_Line_Provided,
       ellm.NUMBER_OF_VISITS, ellm.PREVIOUS_Week_NUMBER_OF_VISITS, ellm.PREVIOUS_2_Week_NUMBER_OF_VISITS, ellm.NEXT_Week_NUMBER_OF_VISITS, ellm.NEXT_2_Week_NUMBER_OF_VISITS, 
       ellm.NUMBER_OF_DISTINCT_CLIENTS, ellm.PREVIOUS_Week_NUMBER_OF_DISTINCT_CLIENTS, ellm.PREVIOUS_2_Week_NUMBER_OF_DISTINCT_CLIENTS, ellm.NEXT_Week_NUMBER_OF_DISTINCT_CLIENTS, ellm.NEXT_2_Week_NUMBER_OF_DISTINCT_CLIENTS, 
       CAST( ellm.SUM_OF_HOURS_SERVED AS NUMBER( 9,3)) AS Sum_Of_Hours_Served, 
       CAST( ellm.PREVIOUS_Week_SUM_OF_HOURS_SERVED AS NUMBER( 9,3)) AS Previous_Week_Sum_of_Hours_Served, 
       CAST( ellm.PREVIOUS_2_Week_SUM_OF_HOURS_SERVED AS NUMBER( 9,3)) AS Previous_2_Week_Sum_of_Hours_Served, 
       CAST( ellm.NEXT_Week_SUM_OF_HOURS_SERVED AS NUMBER( 9,3)) AS Next_Week_Sum_Of_Hours_Served, 
       CAST( ellm.NEXT_2_Week_SUM_OF_HOURS_SERVED AS NUMBER( 9,3)) AS Next_2_Week_Sum_of_Hours_Served, 
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
	   IFF(COALESCE(CCSI_BRANCH.BRANCH_KEY,CCSI_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY,MATRIXCARE_BRANCH.BRANCH_KEY,ALTAMAHA_EMPLOYEE.EMPLOYEE_KEY,PRAETORIAN_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY) IS NULL, FALSE, TRUE) AS EMPLOYEE_ACQUIRED_FLAG,
       CASE WHEN COALESCE(CCSI_BRANCH.BRANCH_KEY,CCSI_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY) IS NOT NULL THEN ''CCSI''
       WHEN MATRIXCARE_BRANCH.BRANCH_KEY IS NOT NULL THEN ''ADAPTIVE'' 
       WHEN ALTAMAHA_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''ALTAMAHA'' 
	   WHEN PRAETORIAN_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''PRAETORIAN''
		ELSE NULL END AS EMPLOYEE_ACQUISITION_NAME
FROM Emp_Lag_Lead_Metrics AS ellm
LEFT OUTER JOIN INTEGRATION.DIM_EMPLOYEE_MERGED AS emp ON ellm.employee_key = emp.employee_key
LEFT OUTER JOIN Compute_Emp_Max_Min_Gap AS cemmg ON ellm.employee_key = cemmg.employee_key
LEFT OUTER JOIN Emp_Service_Line_Metrics AS eslm ON ellm.employee_key = eslm.employee_key AND ellm.Service_Week = eslm.Service_Week
LEFT OUTER JOIN (SELECT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID = 8) CCSI_BRANCH
                        ON CCSI_BRANCH.BRANCH_KEY = NVL( ellm.Branch_Key, emp.Primary_Branch_Key)
     LEFT OUTER JOIN (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_EMPLOYEE_ACQUIRED_MERGED WHERE NOTES = ''CCSI Acquired'') CCSI_ACQUIRED_EMPLOYEE
          ON CCSI_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY = ellm.EMPLOYEE_KEY AND ellm.SERVICE_Week >= ''2021-07-01''
    LEFT OUTER JOIN (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_EMPLOYEE_ACQUIRED_MERGED WHERE NOTES = ''Altamaha'') ALTAMAHA_EMPLOYEE
          ON ALTAMAHA_EMPLOYEE.EMPLOYEE_KEY = ellm.EMPLOYEE_KEY
  LEFT OUTER JOIN (SELECT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID = 7 AND BRANCH_NAME LIKE ''A_%'') MATRIXCARE_BRANCH
                        ON MATRIXCARE_BRANCH.BRANCH_KEY = NVL( ellm.Branch_Key, emp.Primary_Branch_Key)
LEFT OUTER JOIN (SELECT EMPLOYEE_KEY FROM HAH.FACT_EMPLOYEE_ACQUIRED_MERGED WHERE NOTES = ''Praetorian'') PRAETORIAN_ACQUIRED_EMPLOYEE
          ON PRAETORIAN_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY = ellm.EMPLOYEE_KEY and ellm.SERVICE_WEEK >= ''2022-01-01''
WHERE ellm.Service_Week BETWEEN ellm.First_Service_Week AND DATEADD( ''WEEK'', 1, ellm.Last_Service_Week);`;
          try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                return "Succeeded.";   // Return a success/error indicator.
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                }  
          ';