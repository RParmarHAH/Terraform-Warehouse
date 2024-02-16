resource "snowflake_procedure" "DW_REPORT_GET_REPORT_EMPLOYEE_DERIVED_WEEKLY_VISIT_METRICS" {
	name ="GET_REPORT_EMPLOYEE_DERIVED_WEEKLY_VISIT_METRICS"
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
    return_result VARCHAR;
BEGIN

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
-- 07/13/22    Moin Saiyed			 Added code for other category
-- 07/14/21    Deepen Gajjar		 Added acquisition flag for Preferred
-- 07/19/22	   Mohit Vaghadiya		 Fixed Service Week Logic to use HAH_CURRENT_WEEK_FIRST_DAY.
-- 08/05/22    Deepen Gajjar		 Added acquisition flag for ASR
-- 10/10/22    Paras Bhavnani	     Added Rehired Date
-- 11/08/22    Meet Hariyani         Added Applicant Data 
-- 11/10/22    Meet Hariyani         Added Derived first service date.
-- 11/11/22	   Shraddha Sejpal		 Replaced Status_description to confirmed_flag in FACT_VISIT filter condition
-- 12/01/22    Deepen Gajjar		 Made acquistion flag changes
-- 12/20/22	   Rajat Sapkal			 Reworked logic to include non - confirmed visits related employees as well & added new schedule metrics
-- 12/20/22	   Saurav Purohit		 Added NEXT_SCHEDULED_SERVICE_DATE field
-- 02/10/23    Deepen Gajjar         Added acquistion flag for Opensystem & OSHAH 
-- 02/28/23	   Shikhar Saxena		 Changed the Acquisition flag logic for OPENSYSTEMS and OSHAH
-- 03/17/23    Deepen Gajjar         Added acquistion flag for Axxess & Alliance 
-- 04/28/23    Deepen Gajjar 		 Added Acquisition flag for ALL GENERATIONS
-- 07/13/23    Darshan Gosai		 Added OVERTIME HOUR column
-- 10/09/23    Divesh Aneja          added mycare code
-- 10/10/23    Jashvant Patel		 Added BERKSHIRE data
-- 10/20/23	   Shikhar Saxena 		 Added ROMEO acquisition code
--*****************************************************************************************************************************
--NOTE:			If Manual Refresh is required then SCHEDULE_METRICS_WEEKLY should be refreshed first before running this object
--***********************************************************************************************************************************
INSERT OVERWRITE INTO Report.Employee_Derived_Weekly_Visit_Metrics
WITH Bill_Only_Employees AS
(
SELECT *
FROM HAH.DIM_EMPLOYEE AS emp
WHERE ((UPPER( Employee_First_Name) LIKE ''%BILL%'' AND UPPER( Employee_Last_Name) LIKE ''%ONLY%'')
OR UPPER( Employee_First_Name) LIKE ANY ( ''%BILL%ONLY%'', ''%FIELD%STAFF%'', ''%CAREGIVER%'', ''%TEST%PROFILE%'', ''%IMPLEMENT%'', ''%EMPLOYEE%'', ''%DO%NOT%USE%'', ''%OFFICE%'')
OR UPPER( Employee_Last_Name) LIKE ANY ( ''%BILL%ONLY%'', ''%FIELD%STAFF%'', ''%CAREGIVER%'', ''%TEST%PROFILE%'', ''%IMPLEMENT%'', ''%EMPLOYEE%'', ''%DO%NOT%USE%'', ''%OFFICE%'')
OR UPPER( Employee_First_Name) = ''TEST''
OR UPPER( Employee_Last_Name) = ''TEST'') AND SOURCE_SYSTEM_ID NOT IN (13)
ORDER BY Primary_Branch_State, Primary_Branch_Key
),
Calendar_Weeks AS  					-- get calendar months for months we have service/visit data
(
	SELECT HAH_CURRENT_WEEK_FIRST_DAY AS Calendar_Week_First_Day
    FROM HAH.DIM_DATE
    WHERE Calendar_Date BETWEEN CAST( ''2013-01-01'' AS DATE) AND DATEADD( ''WEEK'', 4, CURRENT_DATE())			-- Need data upto 4 weeks into the future now
	GROUP BY 1
    ORDER BY 1
),
Emp_List AS  						-- Get a list of employees who provided visits within the calendar period
(
    SELECT DISTINCT  vis.EMPLOYEE_KEY 
	FROM INTEGRATION.FACT_VISIT_MERGED AS vis
    INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_KEY = cntrct.Contract_KEY AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Billable_Flag = ''TRUE''
    WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
    --AND vis.CONFIRMED_FLAG = ''YES'' 					 														-- Need All Employees, including the ones who never provided any service
    AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
    AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Emp_Weeks AS  						-- Create a list of every week for each employee
(
SELECT cw.Calendar_Week_First_Day AS Service_Week,
       el.Employee_Key
FROM Calendar_Weeks AS cw
FULL OUTER JOIN Emp_List AS el
WHERE cw.Calendar_Week_First_Day IS NOT NULL
ORDER BY el.Employee_Key, cw.Calendar_Week_First_Day
),
Emp_Visit_Max_Hours_By_Week AS  	-- Figure out which branch had the most hours for every service/visit month the employee delivered services/visits
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
     INNER JOIN HAH.DIM_Contract AS cntrct ON vis.CONTRACT_KEY = cntrct.CONTRACT_KEY AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Billable_Flag = ''TRUE''
     WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
     AND vis.CONFIRMED_FLAG = ''YES'' 
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
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.CONTRACT_KEY = cntrct.CONTRACT_KEY AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Billable_Flag = ''TRUE''
INNER JOIN Emp_Visit_Max_Hours_By_Week AS evmhbw ON vis.Employee_Key = evmhbw.Employee_Key AND HAH_CURRENT_WEEK_FIRST_DAY = evmhbw.Service_Week 
LEFT OUTER JOIN HAH.DIM_BRANCH AS brnch on brnch.Branch_Key = vis.BRANCH_KEY
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES''
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
		IFF(MAX(vis.CONFIRMED_FLAG) = ''YES'',HAH_CURRENT_WEEK_FIRST_DAY,NULL) AS Confirmed_Service_Week, 						-- Need to differ the week with atleast one confirmed service, from the week without any Confirmed service
       brnch.Branch_Key,
       brnch2.Branch_Name,
       brnch2.Office_State_Code AS Branch_State_Code,
       CAST( COUNT(iff(CONFIRMED_FLAG = ''YES'',vis.Visit_Key,NULL)) AS INTEGER) AS Number_of_Visits,							-- Need only confirmed no. of visits so added condition back here
       CAST( COUNT( DISTINCT iff(CONFIRMED_FLAG = ''YES'', vis.Client_Key, NULL)) AS INTEGER) AS Number_of_Distinct_Clients,	-- Need only Confirmed clients (from confirmed visits)
       SUM(iff(CONFIRMED_FLAG = ''YES'',vis.HOURS_SERVED,0)) AS Sum_of_Hours_Served									-- Confirmed hours only
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_DATE DT ON DT.CALENDAR_dATE = VIS.SERVICE_DATE
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.CONTRACT_KEY = cntrct.CONTRACT_KEY AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Billable_Flag = ''TRUE''
LEFT OUTER JOIN Employee_Visit_Primary_Branch AS brnch ON vis.Employee_Key = brnch.Employee_Key AND HAH_CURRENT_WEEK_FIRST_DAY = brnch.Service_Week
LEFT OUTER JOIN HAH.DIM_BRANCH AS brnch2 on brnch2.Branch_Key = brnch.Branch_Key
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
--AND vis.CONFIRMED_FLAG = ''YES''																								-- Had to remove this condition to include non confirmed data as well (No. of Future visits/Missed visits)
GROUP BY vis.Employee_Key, HAH_CURRENT_WEEK_FIRST_DAY, brnch.Branch_Key, brnch2.Branch_Name, brnch2.Office_State_Code
),  
Emp_Weekly_Visits AS -- Put visits and monthly employees together
(
SELECT distinct ew.Service_Week,
		ev.Confirmed_Service_Week,																								-- Adding this to use in place of Service_week from old logic	
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
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_key = cntrct.Contract_key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''CLS'' AND cntrct.Billable_Flag = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES'' 
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
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_key = cntrct.Contract_key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''HC'' AND cntrct.Billable_Flag = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES'' 
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
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_key = cntrct.Contract_key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''HH'' AND cntrct.Billable_Flag = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES'' 
AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Week
),
Emp_Weekly_OTHER_Visits AS
(
SELECT vis.Employee_Key,
       HAH_CURRENT_WEEK_FIRST_DAY AS Service_Week,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_OTHER_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_OTHER_Clients,
       SUM( vis.Hours_Served) AS Sum_of_OTHER_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_DATE DT ON DT.CALENDAR_dATE = VIS.SERVICE_DATE
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_key = cntrct.Contract_key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''OTHER'' AND cntrct.Billable_Flag = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES'' 
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
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_key = cntrct.Contract_key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''NA'' AND cntrct.Billable_Flag = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES'' 
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
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_key = cntrct.Contract_key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''IS'' AND cntrct.Billable_Flag = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES'' 
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
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_key = cntrct.Contract_key  AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''NS'' AND cntrct.Billable_Flag = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES'' 
AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, Service_Week
),
Emp_Service_Line_Metrics AS
(
SELECT ew.Employee_Key, emp.SOURCE_SYSTEM_ID, emp.SYSTEM_CODE, ew.Service_Week,
			IFF(hcemp.Number_of_HC_Visits IS NOT NULL,1,0)::INT +
			IFF(hhemp.Number_of_HH_Visits IS NOT NULL,1,0)::INT +
			IFF(clsemp.Number_of_CLS_Visits IS NOT NULL,1,0)::INT +
			IFF(hoemp.Number_of_OTHER_Visits IS NOT NULL,1,0)::INT 
		AS Number_of_Service_Lines_Provided,
       emp.EMPLOYEE_ID, emp.EMPLOYEE_PID, emp.EMPLOYEE_NUMBER, emp.PAYROLL_ID, 
    --   CASE WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NULL AND clsemp.Number_of_CLS_Visits IS NULL THEN 0
    --        WHEN hcemp.Number_of_HC_Visits IS NOT NULL AND hhemp.Number_of_HH_Visits IS NULL AND clsemp.Number_of_CLS_Visits IS NULL THEN 1
    --        WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NULL THEN 1
    --        WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 1
    --        WHEN hcemp.Number_of_HC_Visits IS NOT NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NULL THEN 2
    --        WHEN hcemp.Number_of_HC_Visits IS NOT NULL AND hhemp.Number_of_HH_Visits IS NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 2
    --        WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 2
    --        WHEN hcemp.Number_of_HC_Visits IS NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 2
    --        WHEN hcemp.Number_of_HC_Visits IS NOT NULL AND hhemp.Number_of_HH_Visits IS NOT NULL AND clsemp.Number_of_CLS_Visits IS NOT NULL THEN 3
    --   END AS Number_of_Service_Lines_Provided,
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
FROM Emp_Weeks AS ew
LEFT OUTER JOIN HAH.DIM_EMPLOYEE AS emp ON ew.Employee_Key = emp.Employee_Key
LEFT OUTER JOIN Emp_Weekly_CLS_Visits AS clsemp ON ew.Employee_Key = clsemp.Employee_Key AND ew.Service_Week = clsemp.Service_Week
LEFT OUTER JOIN Emp_Weekly_HH_Visits AS hhemp ON ew.Employee_Key = hhemp.Employee_Key AND ew.Service_Week = hhemp.Service_Week
LEFT OUTER JOIN Emp_Weekly_HC_Visits AS hcemp ON ew.Employee_Key = hcemp.Employee_Key AND ew.Service_Week = hcemp.Service_Week
LEFT OUTER JOIN Emp_Weekly_NA_Visits AS naemp ON ew.Employee_Key = naemp.Employee_Key AND ew.Service_Week = naemp.Service_Week
LEFT OUTER JOIN Emp_Weekly_IS_Visits AS isemp ON ew.Employee_Key = isemp.Employee_Key AND ew.Service_Week = isemp.Service_Week
LEFT OUTER JOIN Emp_Weekly_NS_Visits AS nsemp ON ew.Employee_Key = nsemp.Employee_Key AND ew.Service_Week = nsemp.Service_Week
LEFT OUTER JOIN Emp_Weekly_OTHER_Visits AS hoemp ON ew.Employee_Key = hoemp.Employee_Key AND ew.Service_Week = hoemp.Service_Week
WHERE (hcemp.Number_of_HC_Visits IS NOT NULL OR hhemp.Number_of_HH_Visits IS NOT NULL OR clsemp.Number_of_CLS_Visits IS NOT NULL OR naemp.Number_of_NA_Visits IS NOT NULL OR isemp.Number_of_IS_Visits IS NOT NULL OR nsemp.Number_of_NS_Visits IS NOT NULL
OR hoemp.Number_of_OTHER_Visits IS NOT NULL)
),
Emp_Tenure_Metrics AS
(
SELECT ewv.Employee_Key,
       ewv.Source_System_ID,
       ewv.ORIGINAL_SOURCE_SYSTEM_ID,
       ewv.Employee_ID, ewv.System_Code, ewv.Employee_PID, ewv.Employee_Number, ewv.Payroll_ID,
       ewv.Employee_Category,
       MIN( ewv.Service_Week) AS ACTUAL_FIRST_SERVICE_WEEK,														-- Week for Employees without any confirmed visits - need to use in WHERE clause at the end
       MAX( ewv.Service_Week) AS ACTUAL_LAST_SERVICE_WEEK,														-- Week for Employees without any confirmed visits
       COUNT( ewv.Confirmed_Service_Week) AS Number_Weeks_with_Service,											-- Taking Confirmed week instead of service_week (as service_week now includes all weeks)
       MIN( ewv.Confirmed_Service_Week) AS First_Service_Week,
       MAX( ewv.Confirmed_Service_Week) AS Last_Service_Week,
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
       etm.ACTUAL_FIRST_SERVICE_WEEK,			-- Added to use in logic below 
       etm.ACTUAL_LAST_SERVICE_WEEK,			--
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
),
SERVICE_DATE_WEEKLY AS --NEW_TABLE
(
SELECT vis.EMPLOYEE_KEY, vis.SERVICE_DATE,   
LAG(vis.SERVICE_DATE) OVER(PARTITION BY vis.EMPLOYEE_KEY ORDER BY vis.SERVICE_DATE) AS LAST_SERVICE_DATE,
MIN(iff(VIS.CONFIRMED_FLAG IN (''NO'',''UNKNOWN'') 
		AND (VIS.VISIT_STATUS_NAME = ''Future'' OR 
			(VIS.SERVICE_DATE > CURRENT_DATE() AND NVL(VIS.SCHEDULE_STATUS_NAME,''NULL'') NOT IN (''Hold'',''Cancelled'') 
			AND nvl(VIS.VISIT_STATUS_NAME,''NULL'') NOT IN (''Did not happen'',''In Review'')
			)),vis.SERVICE_DATE,NULL))
	over(PARTITION BY vis.EMPLOYEE_KEY) AS NEXT_SCHEDULED_SERVICE_DATE									-- Next future scheduled date which should not be Cancelled/Hold/In Review
	FROM INTEGRATION.FACT_VISIT_MERGED vis
),
REHIRED_EMPLOYEE_WEEKLY AS --NEW_TABLE
(
SELECT SERVICE_DATE_WEEKLY.EMPLOYEE_KEY, SERVICE_DATE_WEEKLY.SERVICE_DATE, SERVICE_DATE_WEEKLY.LAST_SERVICE_DATE, DD.HAH_CURRENT_WEEK_FIRST_DAY AS SERVICE_WEEK,SERVICE_DATE_WEEKLY.SERVICE_DATE AS REHIRED_DATE,
DATEDIFF(DAY, SERVICE_DATE_WEEKLY.LAST_SERVICE_DATE, SERVICE_DATE_WEEKLY.SERVICE_DATE) AS DATE_DIFF
FROM SERVICE_DATE_WEEKLY
INNER JOIN HAH.DIM_DATE DD ON DD.CALENDAR_DATE = SERVICE_DATE_WEEKLY.SERVICE_DATE
WHERE DATE_DIFF > 90 
),
NEW_METRICS AS  																						-- New Metrics which includes data for non confirmed visits as well
(
SELECT 
	EMPLOYEE_KEY,
	BRANCH_KEY ,
	SERVICE_WEEK,
	sum(FUTURE_HOURS) AS FUTURE_HOURS,
	sum(HOURS_MISSED) AS HOURS_MISSED,
	sum(FUTURE_VISITS) AS FUTURE_VISITS,
	sum(VISITS_MISSED) AS VISITS_MISSED
FROM REPORT.SCHEDULE_METRICS_WEEKLY
GROUP BY 
	EMPLOYEE_KEY,
	BRANCH_KEY ,
	SERVICE_WEEK   
),
PAYROL_OVER_TIME_HOUR AS (
SELECT  
AMS.EMPLOYEE_KEY,
AMS.Service_Week,
SUM(nvl(PAYROL.FNL_OVER_TIME,0)) AS OVER_TIME_HOUR
FROM 
Emp_Lag_Lead_Metrics AMS
JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_AMS_PAYROLL_MAPPING AMS_PAYROL
ON AMS_PAYROL.AMS_EMPLOYEE_KEY = AMS.EMPLOYEE_KEY 
JOIN 
(SELECT 
PAYROL.EMPLOYEE_KEY,
HAH_CURRENT_WEEK_FIRST_DAY AS Service_Week,
sum(CASE WHEN PAYROL.OVER_TIME_HOURS = 0 THEN PAYROL_DTL.OVER_TIME_HOURS ELSE PAYROL.OVER_TIME_HOURS END) AS FNL_OVER_TIME
FROM 
(
SELECT 
PAYROLL_KEY ,EMPLOYEE_KEY,report_date,
round(nvl(OVERTIME_HOURS,0))::NUMBER(31,5) AS OVER_TIME_HOURS
FROM 
DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_PAYROLL_MERGED 
--WHERE OVERTIME_HOURS IS NOT NULL AND OVERTIME_HOURS <> 0
)PAYROL 
JOIN (SELECT
PAYROLL_KEY ,
sum(NVL(NUMBER_OF_UNITS,0)) AS OVER_TIME_HOURS
FROM 
DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_PAYROLL_DETAILS_MERGED 
WHERE upper(trim(PAY_CODE_DESCRIPTION)) LIKE ''%OVER%'' GROUP BY 1) PAYROL_DTL 
ON PAYROL.PAYROLL_KEY = PAYROL_DTL.PAYROLL_KEY

JOIN DW_${var.SF_ENVIRONMENT}."HAH".DIM_DATE DT 
ON DT.CALENDAR_dATE = PAYROL.report_date
WHERE 
PAYROL.report_date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM  Calendar_Weeks) 
AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks) 
GROUP BY 1,2 ) PAYROL
ON PAYROL.EMPLOYEE_KEY  = AMS_PAYROL.PAYROLL_EMPLOYEE_KEY 
AND AMS.Service_Week = PAYROL.Service_Week 
GROUP BY 1,2 )
SELECT DISTINCT ellm.SERVICE_Week,
 DATEADD( ''DAY'', 6, ellm.Service_Week) AS Service_Week_End_Date,
ellm.EMPLOYEE_KEY, ellm.SOURCE_SYSTEM_ID, ELLM.ORIGINAL_SOURCE_SYSTEM_ID, ellm.EMPLOYEE_ID, ellm.SYSTEM_CODE, ellm.EMPLOYEE_PID, ellm.EMPLOYEE_NUMBER, ellm.PAYROLL_ID, 
upper(ellm.Employee_Category),
CASE WHEN emp.CASE_MANAGER_FLAG = TRUE THEN ''ADMIN'' ELSE upper(ellm.Employee_Category) END AS Derived_Employee_Category,
emp.Employee_First_Name AS First_Name, 
emp.Employee_Last_Name AS Last_Name,
emp.Employee_DOB, emp.Employee_Gender, emp.Employee_Ethnicity,
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
	   CAST( eslm.OTHER_Contract_Services_Provided AS BOOLEAN) AS OTHER_Contract_Services_Provided,
       ellm.NUMBER_OF_VISITS, ellm.PREVIOUS_Week_NUMBER_OF_VISITS, ellm.PREVIOUS_2_Week_NUMBER_OF_VISITS, ellm.NEXT_Week_NUMBER_OF_VISITS, ellm.NEXT_2_Week_NUMBER_OF_VISITS, 
       ellm.NUMBER_OF_DISTINCT_CLIENTS, ellm.PREVIOUS_Week_NUMBER_OF_DISTINCT_CLIENTS, ellm.PREVIOUS_2_Week_NUMBER_OF_DISTINCT_CLIENTS, ellm.NEXT_Week_NUMBER_OF_DISTINCT_CLIENTS, ellm.NEXT_2_Week_NUMBER_OF_DISTINCT_CLIENTS, 
       CAST( ellm.SUM_OF_HOURS_SERVED AS NUMBER( 9,3)) AS Sum_Of_Hours_Served, 
	   CAST( NM.FUTURE_HOURS AS NUMBER( 9,3)) AS FUTURE_HOURS,											-- New fields
       CAST( NM.HOURS_MISSED AS NUMBER( 9,3)) AS HOURS_MISSED,											-- New fields
       CAST( NM.FUTURE_VISITS AS NUMBER( 9,3)) AS FUTURE_VISITS,										-- New fields
       CAST( NM.VISITS_MISSED AS NUMBER( 9,3)) AS VISITS_MISSED,										-- New fields				
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
	   CAST( NVL( eslm.Number_of_OTHER_Visits, 0) AS INTEGER) AS Number_of_OTHER_Visits,
       CAST( NVL( eslm.Number_of_Distinct_OTHER_Clients, 0) AS INTEGER) AS Number_of_Distinct_OTHER_Clients,
       CAST( NVL( eslm.Sum_of_OTHER_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_OTHER_Hours_Served,
	   IFF(COALESCE(CCSI_EMPLOYEE.EMPLOYEE_KEY,CCSI_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY,MATRIXCARE_EMPLOYEE.EMPLOYEE_KEY,PREFERRED_EMPLOYEE.EMPLOYEE_KEY,ALAYACARE_EMPLOYEE.EMPLOYEE_KEY,PRAETORIAN_EMPLOYEE.EMPLOYEE_KEY,EDISON_EMPLOYEE.EMPLOYEE_KEY,LONGEVITY_EMPLOYEE.EMPLOYEE_KEY,MERIDIUS_EMPLOYEE.EMPLOYEE_KEY,ASR_EMPLOYEE.EMPLOYEE_KEY,CLEARCARE_EMPLOYEE.EMPLOYEE_KEY,BERKSHIRE_EMPLOYEE.EMPLOYEE_KEY,OPENSYSTEMS_EMPLOYEE.EMPLOYEE_KEY,OSHAH_EMPLOYEE.EMPLOYEE_KEY,AXXESS_EMPLOYEE.EMPLOYEE_KEY,ALLIANCE_EMPLOYEE.EMPLOYEE_KEY,MYCARE_EMPLOYEE.EMPLOYEE_KEY,ALL_GEN_EMPLOYEE.EMPLOYEE_KEY,RECCO_EMPLOYEE.EMPLOYEE_KEY) IS NULL, FALSE, TRUE) AS EMPLOYEE_ACQUIRED_FLAG,
       CASE WHEN COALESCE(CCSI_EMPLOYEE.EMPLOYEE_KEY,CCSI_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY) IS NOT NULL THEN ''CCSI''
       WHEN MATRIXCARE_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''ADAPTIVE'' 
       WHEN PREFERRED_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''PREFERRED''
       WHEN ALAYACARE_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN UPPER(ALAYACARE_EMPLOYEE.AQUISITION_NAME) 
       WHEN PRAETORIAN_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''PRAETORIAN''
       WHEN EDISON_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''EDISON''
	   WHEN LONGEVITY_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''LONGEVITY''
	   WHEN MERIDIUS_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''MERIDIUS''
	   WHEN ASR_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''ASR''
	   WHEN CLEARCARE_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''CLEARCARE''
	   WHEN BERKSHIRE_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''BERKSHIRE''
	   WHEN OPENSYSTEMS_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''OPENSYSTEMS''
	   WHEN OSHAH_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''OPENSYSTEMS''
	   WHEN AXXESS_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''AXXESS''
	   WHEN ALLIANCE_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''ALLIANCE''
	   WHEN MYCARE_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''MYCARE''
       WHEN ALL_GEN_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''ALL GENERATIONS''
	   WHEN RECCO_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''RECCO''
       ELSE NULL END AS EMPLOYEE_ACQUISITION_NAME,
       CASE
          WHEN (CAST( ellm.ACTIVE_FLAG AS BOOLEAN) = FALSE OR CAST(New_Hire_Flag AS BOOLEAN) = TRUE) THEN ''FALSE''
          WHEN REW.EMPLOYEE_KEY IS NOT NULL THEN ''TRUE''
          ELSE ''FALSE''
          END AS REHIRED_FLAG,
      REW.REHIRED_DATE,
	  EDM.APPLICANT_ID,
      EDM.APPLICANT_HIRED_DATE,
      EDM.DATE_APPLIED,
      EDM.APPLICATION_TO_HIRE_DAYS,
      EDM.FIRST_SERVICE_AFTER_REHIRE,
      EDM.HIRE_TO_FIRST_SERVICE_DAYS,
	  EDM.DERIVED_FIRST_SERVICE_DATE,
	SD.NEXT_SCHEDULED_SERVICE_DATE,							  											-- New field
	CAST( NVL( OVER_TIME.OVER_TIME_HOUR, 0) AS NUMBER( 9,3)) AS OVER_TIME_HOUR
	
FROM Emp_Lag_Lead_Metrics AS ellm
LEFT OUTER JOIN INTEGRATION.DIM_EMPLOYEE_MERGED AS emp ON ellm.employee_key = emp.employee_key
LEFT OUTER JOIN Compute_Emp_Max_Min_Gap AS cemmg ON ellm.employee_key = cemmg.employee_key
LEFT OUTER JOIN Emp_Service_Line_Metrics AS eslm ON ellm.employee_key = eslm.employee_key AND ellm.Service_Week = eslm.Service_Week
LEFT JOIN DW_${var.SF_ENVIRONMENT}.REPORT.EMPLOYEE_DERIVED_METRICS EDM ON EDM.EMPLOYEE_KEY = ellm.employee_Key

LEFT JOIN PAYROL_OVER_TIME_HOUR OVER_TIME ON ellm.EMPLOYEE_KEY = OVER_TIME.EMPLOYEE_KEY 
		AND ELLM.SERVICE_WEEK  = OVER_TIME.Service_Week

--LEFT OUTER JOIN (SELECT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID = 8) CCSI_BRANCH
--                        ON CCSI_BRANCH.BRANCH_KEY = NVL( ellm.Branch_Key, emp.Primary_Branch_Key)
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY CCSI_EMPLOYEE
ON (CCSI_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key
OR CCSI_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key
)
	AND CCSI_EMPLOYEE.EMPLOYEE_KEY = ellm.Employee_Key
	AND CCSI_EMPLOYEE.AQUISITION_NAME = ''CCSI''
	AND CCSI_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT OUTER JOIN (SELECT EMPLOYEE_KEY FROM HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY WHERE AQUISITION_NAME = ''CCSI'') CCSI_ACQUIRED_EMPLOYEE
          ON CCSI_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY = ellm.EMPLOYEE_KEY AND ellm.SERVICE_Week >= ''2021-07-01''
--LEFT OUTER JOIN (SELECT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID = 7 AND BRANCH_NAME LIKE ''A_%'') MATRIXCARE_BRANCH
--                        ON MATRIXCARE_BRANCH.BRANCH_KEY = NVL( ellm.Branch_Key, emp.Primary_Branch_Key)
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY MATRIXCARE_EMPLOYEE
ON (MATRIXCARE_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR MATRIXCARE_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
	AND MATRIXCARE_EMPLOYEE.EMPLOYEE_KEY = ellm.Employee_Key
	AND MATRIXCARE_EMPLOYEE.AQUISITION_NAME = ''ADAPTIVE''
   AND MATRIXCARE_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
--LEFT OUTER JOIN (SELECT DISTINCT EMPLOYEE_KEY  FROM HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY_MERGED WHERE notes = ''Preferred'') PREFERRED_EMPLOYEE ON
--PREFERRED_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY PREFERRED_EMPLOYEE ON 
   PREFERRED_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (PREFERRED_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR PREFERRED_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND PREFERRED_EMPLOYEE.AQUISITION_NAME =''PREFERRED''
   AND PREFERRED_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
--LEFT OUTER JOIN (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY_MERGED WHERE NOTES = ''Edison'') EDISON_EMPLOYEE
--         ON EDISON_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY 
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY EDISON_EMPLOYEE ON 
   EDISON_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (EDISON_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR EDISON_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND EDISON_EMPLOYEE.AQUISITION_NAME =''EDISON''
AND EDISON_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY ALAYACARE_EMPLOYEE
ON (ALAYACARE_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key or ALAYACARE_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
	AND ALAYACARE_EMPLOYEE.EMPLOYEE_KEY = ellm.Employee_Key
	AND ALAYACARE_EMPLOYEE.SOURCE_SYSTEM_ID = 9  
	AND ALAYACARE_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY PRAETORIAN_EMPLOYEE
ON (PRAETORIAN_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR PRAETORIAN_EMPLOYEE.ORIGINAL_BRANCH_KEY= emp.Primary_Branch_Key)
	AND PRAETORIAN_EMPLOYEE.EMPLOYEE_KEY = ellm.Employee_Key 
	and ellm.SERVICE_WEEK >= ''2022-01-01''
	AND PRAETORIAN_EMPLOYEE.AQUISITION_NAME = ''Praetorian''
	AND PRAETORIAN_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY LONGEVITY_EMPLOYEE ON 
   LONGEVITY_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (LONGEVITY_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR LONGEVITY_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND LONGEVITY_EMPLOYEE.AQUISITION_NAME =''Longevity''
   AND LONGEVITY_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY MERIDIUS_EMPLOYEE ON 
   MERIDIUS_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (MERIDIUS_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR MERIDIUS_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND MERIDIUS_EMPLOYEE.AQUISITION_NAME =''Meridius''
   AND MERIDIUS_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY ASR_EMPLOYEE ON 
   ASR_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (ASR_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR ASR_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND ASR_EMPLOYEE.AQUISITION_NAME =''ASR''
   AND ASR_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY CLEARCARE_EMPLOYEE ON 
   CLEARCARE_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (CLEARCARE_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR CLEARCARE_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND CLEARCARE_EMPLOYEE.AQUISITION_NAME =''CLEARCARE''
   AND CLEARCARE_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY BERKSHIRE_EMPLOYEE ON 
   BERKSHIRE_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (BERKSHIRE_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR BERKSHIRE_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND BERKSHIRE_EMPLOYEE.AQUISITION_NAME =''BERKSHIRE''
   AND BERKSHIRE_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY OPENSYSTEMS_EMPLOYEE ON 
   OPENSYSTEMS_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (OPENSYSTEMS_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR OPENSYSTEMS_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND OPENSYSTEMS_EMPLOYEE.AQUISITION_NAME =''OPENSYSTEMS''
   AND OPENSYSTEMS_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY OSHAH_EMPLOYEE ON 
   OSHAH_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (OSHAH_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR OSHAH_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND OSHAH_EMPLOYEE.AQUISITION_NAME =''OPENSYSTEMS''
   AND OSHAH_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY AXXESS_EMPLOYEE ON 
   AXXESS_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (AXXESS_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR AXXESS_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND AXXESS_EMPLOYEE.AQUISITION_NAME =''AXXESS''
   AND AXXESS_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY ALLIANCE_EMPLOYEE ON 
   ALLIANCE_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (ALLIANCE_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR ALLIANCE_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND ALLIANCE_EMPLOYEE.AQUISITION_NAME =''ALLIANCE''
   AND ALLIANCE_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY MYCARE_EMPLOYEE ON 
   MYCARE_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (MYCARE_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR MYCARE_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND MYCARE_EMPLOYEE.AQUISITION_NAME =''MYCARE''
   AND MYCARE_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK   
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY ALL_GEN_EMPLOYEE ON 
   ALL_GEN_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (ALL_GEN_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR ALL_GEN_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND ALL_GEN_EMPLOYEE.AQUISITION_NAME =''All Generations''
   AND ALL_GEN_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY RECCO_EMPLOYEE ON 
   RECCO_EMPLOYEE.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY
   AND (RECCO_EMPLOYEE.BRANCH_KEY = ellm.Branch_Key OR RECCO_EMPLOYEE.ORIGINAL_BRANCH_KEY = emp.Primary_Branch_Key)
   AND RECCO_EMPLOYEE.AQUISITION_NAME =''RECCO''
   AND RECCO_EMPLOYEE.SERVICE_WEEK = ELLM.SERVICE_WEEK
LEFT JOIN REHIRED_EMPLOYEE_WEEKLY REW ON REW.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY AND ELLM.SERVICE_WEEK = REW.SERVICE_WEEK   
LEFT JOIN NEW_METRICS NM  ON ellm.EMPLOYEE_KEY = NM.EMPLOYEE_KEY 
	AND NVL(ellm.Branch_Key, emp.Primary_Branch_Key)=NM.BRANCH_KEY AND ellm.SERVICE_WEEK = NM.SERVICE_WEEK	
LEFT JOIN SERVICE_DATE_WEEKLY SD ON SD.EMPLOYEE_KEY = ELLM.EMPLOYEE_KEY																
WHERE ellm.Service_Week BETWEEN coalesce(ellm.First_Service_Week,ellm.ACTUAL_FIRST_SERVICE_WEEK) 
		AND DATEADD( ''WEEK'', 1, coalesce(ellm.Last_Service_Week,ellm.ACTUAL_LAST_SERVICE_WEEK))				-- Using Actual weeks for Employees w/o any Conf_Visits
;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}

