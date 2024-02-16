resource "snowflake_procedure" "DW_REPORT_GET_REPORT_EMPLOYEE_DERIVED_WEEKLY_METRICS_BY_SERVICE_LINE" {
	name ="GET_REPORT_EMPLOYEE_DERIVED_WEEKLY_METRICS_BY_SERVICE_LINE"
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
--
-- NAME:  Employee_Derived_Weeky_Metrics_By_Service_Line
--
-- PURPOSE: Creates derived seekly metrics by service line (HH, HC, CLS) for each employee based on visit/service data
--          NOTE: this table could have multiple entries for each employee in a given week because they could have served
--                clients who have different service line contracts.
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 3/15/21     Frank Noordover       Initial development
-- 7/12/22	   Mohit Vaghadiya		 Added OTHER Revenue Category for PREFERRED
-- 11/11/22	   Shraddha Sejpal		 Replaced Status_description to confirmed_flag in FACT_VISIT filter condition
--*****************************************************************************************************************************


INSERT OVERWRITE INTO Report.Employee_Derived_Weekly_Metrics_By_Service_Line
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
Calendar_Weeks AS  -- get calendar weeks for weeks we have service/visit data
(
	SELECT HAH_CURRENT_WEEK_FIRST_DAY AS Calendar_Week
    FROM HAH.DIM_DATE
    WHERE CALENDAR_DATE BETWEEN CAST( ''2013-01-01'' AS DATE) AND DATEADD( ''WEEK'', 1, CURRENT_DATE())
	GROUP BY 1
),
Emp_Visit_Max_Hours_By_Week AS  -- Figure out which branch had the most hours for every service/visit week the employee delivered services/visits
(
SELECT Employee_Key, Source_System_ID, Service_Week,
       MAX( Sum_of_Hours_Served) AS Max_Hours_Served 
FROM
    (
     SELECT vis.Employee_Key, 
            vis.Source_System_ID,
            vis.Branch_Key,
            HAH_CURRENT_WEEK_FIRST_DAY AS Service_Week,
            SUM( vis.Hours_Served) AS Sum_of_Hours_Served
     FROM HAH.Fact_Visit AS vis
     INNER JOIN HAH.DIM_DATE DT ON DT.CALENDAR_DATE = VIS.SERVICE_DATE
     INNER JOIN HAH.DIM_Contract AS cntrct ON vis.System_Code = cntrct.System_Code AND vis.Contract_Code = cntrct.Contract_Code AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category IN (''HH'', ''HC'', ''CLS'', ''OTHER'')
     WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
     AND vis.CONFIRMED_FLAG = ''YES''
     AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)

     GROUP BY vis.Employee_Key, vis.Source_System_ID, Service_Week, vis.Branch_Key
     ORDER BY vis.Employee_Key, vis.Source_System_ID, Service_Week, vis.Branch_Key
    ) x
GROUP BY Employee_Key, Source_System_ID, Service_Week
ORDER BY Employee_Key, Source_System_ID, Service_Week
),
Employee_Visit_Primary_Branch AS 
(
SELECT vis.Employee_Key, 
       vis.Source_System_ID,
       vis.Branch_Key AS Branch_Key,
       brnch.Branch_Name AS Branch_Name,
       brnch.Office_State_Code AS Branch_State_Code,
       HAH_CURRENT_WEEK_FIRST_DAY AS Service_Week,
       SUM( vis.Hours_Served) AS Sum_of_Hours_Served
FROM HAH.Fact_Visit AS vis
INNER JOIN HAH.DIM_DATE DT ON DT.CALENDAR_DATE = VIS.SERVICE_DATE
INNER JOIN HAH.DIM_Contract AS cntrct ON cntrct.Contract_Key = vis.Contract_Key AND cntrct.Revenue_Category IN (''HH'', ''HC'', ''CLS'', ''OTHER'') AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0)
INNER JOIN Emp_Visit_Max_Hours_By_Week AS evmhbm ON vis.Employee_Key = evmhbm.Employee_Key AND vis.Source_System_Id = evmhbm.Source_System_ID AND HAH_CURRENT_WEEK_FIRST_DAY = evmhbm.Service_Week 
LEFT OUTER JOIN HAH.DIM_Branch AS brnch on brnch.Source_System_ID = vis.Source_System_ID AND brnch.Branch_Key = vis.Branch_Key
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES''
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, vis.Source_System_ID, vis.Branch_Key, brnch.Branch_Name, brnch.Office_State_Code, HAH_CURRENT_WEEK_FIRST_DAY, evmhbm.Max_Hours_Served
HAVING SUM( vis.Hours_Served) = evmhbm.Max_Hours_Served
ORDER BY vis.Employee_Key, Service_Week
)
SELECT HAH_CURRENT_WEEK_FIRST_DAY AS Service_Week,
	vis.EMPLOYEE_KEY, vis.SOURCE_SYSTEM_ID, vis.SYSTEM_CODE, 
	emp.EMPLOYEE_ID, emp.EMPLOYEE_PID, emp.EMPLOYEE_NUMBER, emp.PAYROLL_ID, 
	evpb.Branch_Key AS Branch_Key,
	brnch.Branch_Name,
	brnch.Office_State_Code AS Branch_State_Code,
	cntrct.Revenue_Category AS Service_Line,
	CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_Visits,
	CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_Clients,
	CAST( SUM( vis.Hours_Served) AS NUMBER(9,3)) AS Sum_of_Hours_Served,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY ,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY,
	0 as ETL_DELETED_FLAG
FROM HAH.Fact_Visit AS vis
INNER JOIN HAH.DIM_DATE DT ON DT.CALENDAR_DATE = vis.Service_Date
INNER JOIN HAH.DIM_Contract AS cntrct ON cntrct.Contract_Key = vis.Contract_Key AND cntrct.Revenue_Category IN (''HH'', ''HC'', ''CLS'', ''OTHER'') AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0)
LEFT OUTER JOIN Employee_Visit_Primary_Branch AS evpb ON vis.Source_System_ID = evpb.Source_System_ID AND vis.Employee_Key = evpb.Employee_Key AND HAH_CURRENT_WEEK_FIRST_DAY = evpb.Service_Week
LEFT OUTER JOIN HAH.DIM_Employee AS emp ON vis.Source_System_ID = emp.Source_System_ID AND vis.Employee_Key = emp.Employee_Key
LEFT OUTER JOIN HAH.DIM_Branch AS brnch ON evpb.Source_System_ID = brnch.Source_System_ID AND evpb.Branch_Key = brnch.Branch_Key
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.CONFIRMED_FLAG = ''YES''
GROUP BY 1, vis.EMPLOYEE_KEY, vis.SOURCE_SYSTEM_ID, vis.SYSTEM_CODE, emp.EMPLOYEE_ID, emp.EMPLOYEE_PID, emp.EMPLOYEE_NUMBER, emp.PAYROLL_ID, emp.Employee_First_Name, emp.Employee_Last_Name, cntrct.Revenue_Category, evpb.Branch_Key, brnch.Branch_Name, brnch.Office_State_Code
ORDER BY vis.Employee_Key, HAH_CURRENT_WEEK_FIRST_DAY, cntrct.Revenue_Category;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}

