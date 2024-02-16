resource "snowflake_procedure" "DW_REPORT_EMPLOYEE_DERIVED_MONTHLY_METRICS_BY_SERVICE_LINE" {
	name ="EMPLOYEE_DERIVED_MONTHLY_METRICS_BY_SERVICE_LINE"
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
    return_result varchar(1000);
BEGIN

--*****************************************************************************************************************************
--
-- NAME:  Employee_Derived_Monthly_Metrics_By_Service_Line
--
-- PURPOSE: Creates derived monthly metrics by service line (HH, HC, CLS) for each employee based on visit/service data
--          NOTE: this table could have multiple entries for each employee in a given month because they could have served
--                clients who have different service line contracts.
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 11/16/20    Frank Noordover       Initial development
-- 06/17/21	   Shraddha Sejpal		 Added merged views for DIMs and FACTs
-- 12/02/21    Prachi Shah           Added logic for acquisition flag
--5/31/2022    DEEPEN GAJJAR         ADDED LOGIC FOR ACQUISOTION FLAG FOR PREFERRED AND EDISON 
-- 6/2/2022	   Mohit Vaghadiya		 Added Filter of Bill Unit Type
-- 6/21/2022   Deepen Gajjar		 Updated aquisition flag logic for matrixcare
-- 6/23/2022   Deepen Gajjar		 Updated aquisition flag logic for ccsi
-- 6/23/2022   Deepen Gajjar		 Updated aquisition flag logic for Altamaha and Praetorian
-- 7/06/2022   Deepen Gajjar		 Updated aquisition flag logic for Meridius and Longevity
-- 07-13-2022  Moin Saiyed			 Added other sub category in sub query
-- 08-01-2022  Deepen Gajjar		 Modified Acquisition flags
-- 08-25-2022  Deepen Gajjar		 added Acquisition flag for Prospercare
--*****************************************************************************************************************************


INSERT OVERWRITE INTO Report.Employee_Derived_Monthly_Metrics_By_Service_Line
WITH Bill_Only_Employees AS
(
SELECT *
FROM HAH.DIM_Employee AS emp
WHERE (UPPER( Employee_First_Name) LIKE ''%BILL%'' AND UPPER( Employee_Last_Name) LIKE ''%ONLY%'')
OR UPPER( Employee_First_Name) LIKE ''%BILL%ONLY%''
OR UPPER( Employee_Last_Name) LIKE ''%BILL%ONLY%''
),
Calendar_Months AS  -- get calendar months for months we have service/visit data
(
	SELECT DATE_TRUNC( MONTH, CALENDAR_DATE) AS Calendar_Month
    FROM HAH.DIM_DATE
    WHERE CALENDAR_DATE BETWEEN CAST( ''2013-01-01'' AS DATE) AND CURRENT_DATE() 
	GROUP BY 1
),
Emp_Data AS (
	SELECT DISTINCT VIS.EMPLOYEE_KEY,EMP.SOURCE_SYSTEM_ID,
	FIRST_VALUE(EMP.Original_Source_System_Id) OVER (PARTITION BY VIS.Employee_Key ORDER BY 
            IFF(EMP.Original_Source_System_ID <> EMP.Source_System_ID, 0, 1)) AS Original_Source_System_ID,
    EMP.SYSTEM_CODE,
    EMP.EMPLOYEE_ID, EMP.EMPLOYEE_PID, EMP.EMPLOYEE_NUMBER, EMP.PAYROLL_ID, 
    EMP.Employee_First_Name,
    EMP.Employee_Last_Name,
    DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month
	FROM INTEGRATION.FACT_VISIT_MERGED VIS
	LEFT OUTER JOIN INTEGRATION.DIM_EMPLOYEE_MERGED EMP ON VIS.EMPLOYEE_KEY = EMP.EMPLOYEE_KEY
	),
Emp_Visit_Max_Hours_By_Month AS  -- Figure out which branch had the most hours for every service/visit month the employee delivered services/visits
(
SELECT Employee_Key, Service_Month,
       MAX( Sum_of_Hours_Served) AS Max_Hours_Served 
FROM
    (
     SELECT vis.Employee_Key, 
            vis.Branch_Key,
            DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
            SUM( vis.Hours_Served) AS Sum_of_Hours_Served
     FROM INTEGRATION.Fact_Visit_Merged AS vis 
     INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category IN (''HH'', ''HC'', ''CLS'',''OTHER'')
     WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
     AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
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
FROM INTEGRATION.Fact_Visit_Merged AS vis
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category IN (''HH'', ''HC'', ''CLS'',''OTHER'')
INNER JOIN Emp_Visit_Max_Hours_By_Month AS evmhbm ON vis.Employee_Key = evmhbm.Employee_Key AND DATE_TRUNC( ''MONTH'', vis.Service_Date) = evmhbm.Service_Month 
LEFT OUTER JOIN HAH.DIM_Branch AS brnch on brnch.Branch_Key = vis.Branch_Key
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
AND vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY vis.Employee_Key, vis.Branch_Key, brnch.Branch_Name, brnch.Office_State_Code, DATE_TRUNC( ''MONTH'', vis.Service_Date), evmhbm.Max_Hours_Served
HAVING SUM( vis.Hours_Served) = evmhbm.Max_Hours_Served
) x
GROUP BY Employee_Key, Service_Month, Sum_of_Hours_Served
)
SELECT DISTINCT DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       vis.EMPLOYEE_KEY, emp.SOURCE_SYSTEM_ID, emp.original_source_system_id, emp.SYSTEM_CODE, 
       emp.EMPLOYEE_ID, emp.EMPLOYEE_PID, emp.EMPLOYEE_NUMBER, emp.PAYROLL_ID, 
       emp.Employee_First_Name AS First_Name,
       emp.Employee_Last_Name AS Last_Name,
       evpb.Branch_Key AS Branch_Key,
       brnch.Branch_Name,
       brnch.Office_State_Code AS Branch_State_Code,
       cntrct.Revenue_Category AS Service_Line,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_Visits,
       CAST( COUNT( DISTINCT vis.Client_Key) AS INTEGER) AS Number_of_Distinct_Clients,
       CAST( SUM( vis.Hours_Served) AS NUMBER(9,3)) 
       AS Sum_of_Hours_Served,
	   IFF(COALESCE(CCSI_BRANCH.BRANCH_KEY,CCSI_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY,MATRIXCARE_EMPLOYEE.EMPLOYEE_KEY ,ALAYACARE_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY,PRAETORIAN_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY,PREFERRED_EMPLOYEE.EMPLOYEE_KEY,LONGEVITY_EMPLOYEE.EMPLOYEE_KEY,MERIDIUS_EMPLOYEE.EMPLOYEE_KEY) IS NULL, FALSE, TRUE) AS EMPLOYEE_ACQUIRED_FLAG,
       CASE WHEN COALESCE(CCSI_BRANCH.BRANCH_KEY,CCSI_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY) IS NOT NULL THEN ''CCSI''
       WHEN MATRIXCARE_EMPLOYEE.EMPLOYEE_KEY  IS NOT NULL THEN ''ADAPTIVE'' 
       WHEN ALAYACARE_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN UPPER(ALAYACARE_ACQUIRED_EMPLOYEE.AQUISITION_NAME)
	   WHEN PRAETORIAN_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''PRAETORIAN''
	   WHEN PREFERRED_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''PREFERRED''
	   WHEN LONGEVITY_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''LONGEVITY''
	   WHEN MERIDIUS_EMPLOYEE.EMPLOYEE_KEY IS NOT NULL THEN ''MERIDIUS''
       ELSE NULL END AS EMPLOYEE_ACQUISITION_NAME
FROM INTEGRATION.FACT_VISIT_MERGED AS vis
INNER JOIN HAH.DIM_Contract AS cntrct ON cntrct.Contract_Key = vis.Contract_Key AND cntrct.Revenue_Category IN (''HH'', ''HC'', ''CLS'',''OTHER'') AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0)
LEFT OUTER JOIN Employee_Visit_Primary_Branch AS evpb ON vis.Employee_Key = evpb.Employee_Key AND DATE_TRUNC( ''MONTH'', vis.Service_Date) = evpb.Service_Month
LEFT OUTER JOIN EMP_DATA AS emp ON vis.Employee_Key = emp.Employee_Key AND DATE_TRUNC( ''MONTH'', vis.Service_Date)= emp.service_month
LEFT OUTER JOIN HAH.DIM_Branch AS brnch ON evpb.Branch_Key = brnch.Branch_Key

LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED CCSI_BRANCH ON 
	CCSI_BRANCH.EMPLOYEE_KEY = EVPB.EMPLOYEE_KEY AND
	CCSI_BRANCH.BRANCH_KEY = EVPB.BRANCH_KEY AND
	CCSI_BRANCH.AQUISITION_NAME =''CCSI'' AND 
	CCSI_BRANCH.SERVICE_MONTH  = DATE_TRUNC(''MONTH'',EVPB.SERVICE_MONTH)

LEFT OUTER JOIN (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_EMPLOYEE_ACQUIRED_MERGED WHERE NOTES = ''CCSI Acquired'') CCSI_ACQUIRED_EMPLOYEE
            ON CCSI_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY = vis.EMPLOYEE_KEY AND DATE_TRUNC( ''MONTH'', vis.Service_Date) >= ''2021-07-01''

LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED ALAYACARE_ACQUIRED_EMPLOYEE ON 
	ALAYACARE_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY = EVPB.EMPLOYEE_KEY AND
	ALAYACARE_ACQUIRED_EMPLOYEE.BRANCH_KEY = EVPB.BRANCH_KEY AND
	ALAYACARE_ACQUIRED_EMPLOYEE.SOURCE_SYSTEM_ID = 9 AND 
	ALAYACARE_ACQUIRED_EMPLOYEE.SERVICE_MONTH  = DATE_TRUNC(''MONTH'',EVPB.SERVICE_MONTH)

LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED MATRIXCARE_EMPLOYEE ON 
	MATRIXCARE_EMPLOYEE.EMPLOYEE_KEY = EVPB.EMPLOYEE_KEY AND
	MATRIXCARE_EMPLOYEE.BRANCH_KEY = EVPB.BRANCH_KEY AND
	MATRIXCARE_EMPLOYEE.AQUISITION_NAME =''ADAPTIVE'' AND 
	MATRIXCARE_EMPLOYEE.SERVICE_MONTH  = DATE_TRUNC(''MONTH'',EVPB.SERVICE_MONTH)


LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED PRAETORIAN_ACQUIRED_EMPLOYEE ON 
	PRAETORIAN_ACQUIRED_EMPLOYEE.EMPLOYEE_KEY = EVPB.EMPLOYEE_KEY AND
	PRAETORIAN_ACQUIRED_EMPLOYEE.BRANCH_KEY = EVPB.BRANCH_KEY AND
	PRAETORIAN_ACQUIRED_EMPLOYEE.AQUISITION_NAME =''Praetorian'' AND 
	PRAETORIAN_ACQUIRED_EMPLOYEE.SERVICE_MONTH  = DATE_TRUNC(''MONTH'',EVPB.SERVICE_MONTH) AND
	DATE_TRUNC( ''MONTH'', vis.Service_Date) >= ''2022-01-01''


LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED PREFERRED_EMPLOYEE  ON 
	PREFERRED_EMPLOYEE.EMPLOYEE_KEY = EVPB.EMPLOYEE_KEY AND
	PREFERRED_EMPLOYEE.BRANCH_KEY = EVPB.BRANCH_KEY AND
	PREFERRED_EMPLOYEE.AQUISITION_NAME =''PREFERRED'' AND 
	PREFERRED_EMPLOYEE.SERVICE_MONTH  = DATE_TRUNC(''MONTH'',EVPB.SERVICE_MONTH)

LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED LONGEVITY_EMPLOYEE  ON 
	LONGEVITY_EMPLOYEE.EMPLOYEE_KEY = EVPB.EMPLOYEE_KEY AND
	LONGEVITY_EMPLOYEE.BRANCH_KEY = EVPB.BRANCH_KEY AND
	LONGEVITY_EMPLOYEE.AQUISITION_NAME =''Longevity'' AND 
	LONGEVITY_EMPLOYEE.SERVICE_MONTH  = DATE_TRUNC(''MONTH'',EVPB.SERVICE_MONTH)
LEFT OUTER JOIN HAH.FACT_EMPLOYEE_ACQUIRED MERIDIUS_EMPLOYEE   ON 
	MERIDIUS_EMPLOYEE.EMPLOYEE_KEY = EVPB.EMPLOYEE_KEY AND
	MERIDIUS_EMPLOYEE.BRANCH_KEY = EVPB.BRANCH_KEY AND
	MERIDIUS_EMPLOYEE.AQUISITION_NAME =''Meridius'' AND 
	MERIDIUS_EMPLOYEE.SERVICE_MONTH  = DATE_TRUNC(''MONTH'',EVPB.SERVICE_MONTH)
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
GROUP BY 1, vis.EMPLOYEE_KEY, emp.SOURCE_SYSTEM_ID, emp.original_source_system_id,emp.SYSTEM_CODE, emp.EMPLOYEE_ID, emp.EMPLOYEE_PID, emp.EMPLOYEE_NUMBER, emp.PAYROLL_ID, emp.Employee_First_Name, emp.Employee_Last_Name, cntrct.Revenue_Category, evpb.Branch_Key, brnch.Branch_Name, brnch.Office_State_Code, EMPLOYEE_ACQUIRED_FLAG, EMPLOYEE_ACQUISITION_NAME;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

