CREATE OR REPLACE PROCEDURE DW_PROD.REPORT.GET_REPORT_EMPLOYEE_DERIVED_METRICS_W_BILLABLE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN

    INSERT OVERWRITE INTO Report.Employee_Derived_Metrics_w_Billable
WITH Bill_Only_Employees AS
(
SELECT *
FROM HAH.DIM_Employee AS emp
WHERE (UPPER( Employee_First_Name) LIKE ''%BILL%'' AND UPPER( Employee_Last_Name) LIKE ''%ONLY%'')
OR UPPER( Employee_First_Name) LIKE ANY ( ''%BILL%ONLY%'', ''%FIELD%STAFF%'', ''%CAREGIVER%'', ''%TEST%PROFILE%'', ''%IMPLEMENT%'', ''%EMPLOYEE%'', ''%DO%NOT%USE%'', ''%OFFICE%'')
OR UPPER( Employee_Last_Name) LIKE ANY ( ''%BILL%ONLY%'', ''%FIELD%STAFF%'', ''%CAREGIVER%'', ''%TEST%PROFILE%'', ''%IMPLEMENT%'', ''%EMPLOYEE%'', ''%DO%NOT%USE%'', ''%OFFICE%'')
OR UPPER( Employee_First_Name) = ''TEST''
OR UPPER( Employee_Last_Name) = ''TEST''
ORDER BY Primary_Branch_State, Primary_Branch_Key
),
Calendar_Months AS  -- get calendar months for months we have service/visit data
(
SELECT DATE_TRUNC( MONTH, CALENDAR_DATE) AS Calendar_Month
    FROM HAH.DIM_DATE
    WHERE CALENDAR_DATE BETWEEN CAST( ''2013-01-01'' AS DATE) AND DATEADD( ''MONTH'', 1, CURRENT_DATE())
GROUP BY 1
),
--
-- Capture all employees across all source systems
--
List_Of_Employees AS
(
--
-- Employees from Carevoyant, Dataflex and Sandata
--
SELECT emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number
FROM HAH.DIM_Employee AS emp
WHERE emp.Source_System_ID IN (1,2,3,4,7,8,16,17,19)
AND emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
UNION
--
-- Employees from HAH Great Plains that aren''t in the query above
--
SELECT emp2.Employee_Key, emp2.Employee_ID, emp2.System_Code, emp2.Source_System_ID, emp2.Employee_PID, emp2.Employee_Number
FROM HAH.DIM_Employee AS emp2
WHERE emp2.Source_System_ID IN (5)
AND emp2.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND NVL( emp2.Employee_ID, ''999'') NOT IN (SELECT NVL( emp3.Payroll_ID, ''111'')
                                          FROM HAH.DIM_Employee AS emp3
                                          WHERE emp3.Source_System_ID IN (1,2,3,4,7,8,16,17,19))
),
--
-- Derived service dates
--
Emp_Service_Dates AS
(
SELECT emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number,
       MIN( vis.Service_Date) AS Derived_First_Service_Date,
       MAX( vis.Service_Date) AS Derived_Last_Service_Date
FROM HAH.DIM_Employee AS emp
INNER JOIN HAH.Fact_Visit AS vis ON vis.Employee_Key = emp.Employee_Key AND vis.Source_System_ID IN (1,2,3,4,7,8,16,17,19) AND vis.CONFIRMED_FLAG = ''YES''
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Billable_Flag = ''TRUE''
LEFT OUTER JOIN HAH.DIM_Branch AS brnch ON vis.Branch_Key = brnch.Branch_Key
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number
),
Emp_Months_of_Service AS
(
SELECT Employee_Key, COUNT(DISTINCT Service_Month) AS Months_of_Active_Service
FROM
(
     SELECT vis.Employee_Key,
            DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
            SUM( vis.Hours_Served) AS Sum_of_Hours_Served
     FROM INTEGRATION.FACT_VISIT_MERGED AS vis
     INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Billable_Flag = ''TRUE''
     WHERE vis.CONFIRMED_FLAG = ''YES''
     AND vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
     AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
     GROUP BY vis.Employee_Key, Service_Month
     HAVING SUM( vis.Hours_Served) > 0
) tbl
GROUP BY Employee_Key
),
Emp_Work_State AS
(
SELECT emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number,
       MAX( brnch.Office_State_Code) AS Derived_Work_State
FROM HAH.DIM_Employee AS emp
INNER JOIN HAH.Fact_Visit AS vis ON vis.Employee_Key = emp.Employee_Key AND vis.Source_System_ID IN (1,2,3,4,7,8,16,17,19) AND vis.CONFIRMED_FLAG = ''YES''
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Billable_Flag = ''TRUE''
INNER JOIN Emp_Service_Dates AS esd ON emp.Employee_Key = esd.Employee_Key AND vis.Service_Date = esd.Derived_Last_Service_Date
LEFT OUTER JOIN HAH.DIM_Branch AS brnch ON vis.Branch_Key = brnch.Branch_Key
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number
),
--
-- Derived payroll dates
--
-- Note: Even though the following query has emp.Employee_Key;
-- this employee key is based on the payroll system because of the inner join and the restriction to source systems that are payroll systems
-- So this Employee_Key will be different than the transaction system Employee_Key
--
Emp_Payroll_Dates AS
(
--
-- Great Plains HAH
--
SELECT emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number,
       MIN( pyrl.Payroll_Date) AS Derived_First_Check_Date,
       MAX( pyrl.Payroll_Date) AS Derived_Last_Check_Date
    --    DATEDIFF( ''DAY'', Derived_Last_Check_Date, CURRENT_DATE) AS Days_Since_Last_Paycheck
FROM HAH.DIM_Employee AS emp
INNER JOIN HAH.Fact_Payroll AS pyrl ON pyrl.Employee_Key = emp.Employee_Key AND pyrl.Source_System_ID IN (5)
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number
UNION
--
-- Trustpoint/Excel
--
SELECT emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number,
       MIN( pyrl.Payroll_Date) AS Derived_First_Check_Date,
       MAX( pyrl.Payroll_Date) AS Derived_Last_Check_Date
    --    DATEDIFF( ''DAY'', Derived_Last_Check_Date, CURRENT_DATE) AS Days_Since_Last_Paycheck
FROM HAH.DIM_Employee AS emp
INNER JOIN HAH.Fact_Payroll AS pyrl ON pyrl.Employee_ID = emp.Employee_ID AND pyrl.Source_System_ID IN (6)
WHERE emp.Source_System_ID IN (4)
AND emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number
UNION
--
-- Coastal
--
SELECT emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number,
       MIN( pyrl.Payroll_Date) AS Derived_First_Check_Date,
       MAX( pyrl.Payroll_Date) AS Derived_Last_Check_Date
    --    DATEDIFF( ''DAY'', Derived_Last_Check_Date, CURRENT_DATE) AS Days_Since_Last_Paycheck
FROM HAH.DIM_Employee AS emp
INNER JOIN HAH.Fact_Payroll AS pyrl ON pyrl.Employee_Key = emp.Employee_Key AND pyrl.Source_System_ID IN (1,2)
WHERE emp.Source_System_ID IN (1,2)
AND emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number
UNION
--
-- Preferred/Edison
--
SELECT emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number,
       MIN( pyrl.Payroll_Date) AS Derived_First_Check_Date,
       MAX( pyrl.Payroll_Date) AS Derived_Last_Check_Date
    --    DATEDIFF( ''DAY'', Derived_Last_Check_Date, CURRENT_DATE) AS Days_Since_Last_Paycheck
FROM HAH.DIM_Employee AS emp
INNER JOIN HAH.Fact_Payroll AS pyrl ON pyrl.Employee_Key = emp.Employee_Key AND pyrl.Source_System_ID IN (17)
WHERE emp.Source_System_ID IN (17)
AND emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number
UNION
--
-- CLEARCARE
--
SELECT emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number,
       MIN( pyrl.Payroll_Date) AS Derived_First_Check_Date,
       MAX( pyrl.Payroll_Date) AS Derived_Last_Check_Date
    --    DATEDIFF( ''DAY'', Derived_Last_Check_Date, CURRENT_DATE) AS Days_Since_Last_Paycheck
FROM HAH.DIM_Employee AS emp
INNER JOIN HAH.Fact_Payroll AS pyrl ON pyrl.Employee_Key = emp.Employee_Key AND pyrl.Source_System_ID IN (16)
WHERE emp.Source_System_ID IN (16)
AND emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number
UNION
--
-- Alliance
--
SELECT emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number,
       MIN( pyrl.Payroll_Date) AS Derived_First_Check_Date,
       MAX( pyrl.Payroll_Date) AS Derived_Last_Check_Date
    --    DATEDIFF( ''DAY'', Derived_Last_Check_Date, CURRENT_DATE) AS Days_Since_Last_Paycheck
FROM HAH.DIM_Employee AS emp
INNER JOIN HAH.Fact_Payroll AS pyrl ON pyrl.Employee_Key = emp.Employee_Key AND pyrl.Source_System_ID IN (19)
WHERE emp.Source_System_ID IN (19)
AND emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
GROUP BY emp.Employee_Key, emp.Employee_ID, emp.System_Code, emp.Source_System_ID, emp.Employee_PID, emp.Employee_Number
),
Coastal_Employees AS
(
SELECT emp.Employee_Key, 
       esd.Derived_First_Service_Date,
       esd.Derived_Last_Service_Date,
       epd.Employee_ID AS Payroll_Employee_ID, epd.System_Code AS Payroll_System_Code, epd.Source_System_ID AS Payroll_Source_System_ID,
       epd.Employee_PID AS Payroll_Employee_PID, epd.Employee_Number AS Payroll_Employee_Number,
       epd.Derived_First_Check_Date,
       epd.Derived_Last_Check_Date,
       NVL( NVL( NVL( ews.Derived_Work_State, emp.Primary_Branch_State), emp.SUTA_State), emp.Employee_State_Code) AS Derived_Work_State
FROM HAH.DIM_Employee AS emp
INNER JOIN List_Of_Employees AS loe ON emp.Employee_Key = loe.Employee_Key AND emp.Source_System_Id = loe.Source_System_ID AND loe.Source_System_ID IN (1,2)
LEFT OUTER JOIN Emp_Service_Dates AS esd ON emp.Source_System_ID = esd.Source_System_ID AND emp.Employee_Key = esd.Employee_Key
LEFT OUTER JOIN Emp_Work_State AS ews  ON emp.Source_System_ID = ews.Source_System_ID AND emp.Employee_Key = ews.Employee_Key
LEFT OUTER JOIN Emp_Payroll_Dates AS epd ON emp.Employee_Key = epd.Employee_Key--emp.Payroll_ID = epd.Employee_ID AND epd.Employee_PID = emp.Employee_PID AND emp.Source_System_ID IN (1,2) --
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Dataflex_Employees_in_ILL AS
(
SELECT emp.Employee_Key, 
       esd.Derived_First_Service_Date,
       esd.Derived_Last_Service_Date,
       epd.Employee_ID AS Payroll_Employee_ID, epd.System_Code AS Payroll_System_Code, epd.Source_System_ID AS Payroll_Source_System_ID,
       epd.Employee_PID AS Payroll_Employee_PID, epd.Employee_Number AS Payroll_Employee_Number,
       epd.Derived_First_Check_Date,
       epd.Derived_Last_Check_Date,
       NVL( NVL( NVL( ews.Derived_Work_State, emp.Primary_Branch_State), emp.SUTA_State), emp.Employee_State_Code) AS Derived_Work_State
FROM HAH.DIM_Employee AS emp
INNER JOIN List_Of_Employees AS loe ON emp.Employee_Key = loe.Employee_Key AND emp.Source_System_Id = loe.Source_System_ID AND loe.Source_System_ID IN (3) AND loe.System_Code IN (''IL'',''IN'',''KY'',''MO'',''TN'')
LEFT OUTER JOIN Emp_Service_Dates AS esd ON emp.Source_System_ID = esd.Source_System_ID AND emp.Employee_Key = esd.Employee_Key
LEFT OUTER JOIN Emp_Work_State AS ews  ON emp.Source_System_ID = ews.Source_System_ID AND emp.Employee_Key = ews.Employee_Key
LEFT OUTER JOIN Emp_Payroll_Dates AS epd ON emp.Payroll_ID = epd.Employee_ID AND epd.Employee_PID = emp.Employee_PID AND epd.Source_System_ID IN (5) AND epd.System_Code = ''ILL''
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Dataflex_Employees_in_MICH AS
(
SELECT emp.Employee_Key, 
       esd.Derived_First_Service_Date,
       esd.Derived_Last_Service_Date,
       epd.Employee_ID AS Payroll_Employee_ID, epd.System_Code AS Payroll_System_Code, epd.Source_System_ID AS Payroll_Source_System_ID,
       epd.Employee_PID AS Payroll_Employee_PID, epd.Employee_Number AS Payroll_Employee_Number,
       epd.Derived_First_Check_Date,
       epd.Derived_Last_Check_Date,
       NVL( NVL( NVL( ews.Derived_Work_State, emp.Primary_Branch_State), emp.SUTA_State), emp.Employee_State_Code) AS Derived_Work_State
FROM HAH.DIM_Employee AS emp
INNER JOIN List_Of_Employees AS loe ON emp.Employee_Key = loe.Employee_Key AND emp.Source_System_Id = loe.Source_System_ID AND loe.Source_System_ID IN (3) AND loe.System_Code IN (''MI'')
LEFT OUTER JOIN Emp_Service_Dates AS esd ON emp.Source_System_ID = esd.Source_System_ID AND emp.Employee_Key = esd.Employee_Key
LEFT OUTER JOIN Emp_Work_State AS ews  ON emp.Source_System_ID = ews.Source_System_ID AND emp.Employee_Key = ews.Employee_Key
LEFT OUTER JOIN Emp_Payroll_Dates AS epd ON emp.Payroll_ID = epd.Employee_ID AND epd.Employee_PID = emp.Employee_PID AND epd.Source_System_ID IN (5) AND epd.System_Code = ''MICH''
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Dataflex_Employees_in_STW AS
(
SELECT emp.Employee_Key, 
       esd.Derived_First_Service_Date,
       esd.Derived_Last_Service_Date,
       epd.Employee_ID AS Payroll_Employee_ID, epd.System_Code AS Payroll_System_Code, epd.Source_System_ID AS Payroll_Source_System_ID,
       epd.Employee_PID AS Payroll_Employee_PID, epd.Employee_Number AS Payroll_Employee_Number,
       epd.Derived_First_Check_Date,
       epd.Derived_Last_Check_Date,
       NVL( NVL( NVL( ews.Derived_Work_State, emp.Primary_Branch_State), emp.SUTA_State), emp.Employee_State_Code) AS Derived_Work_State
FROM HAH.DIM_Employee AS emp
INNER JOIN List_Of_Employees AS loe ON emp.Employee_Key = loe.Employee_Key AND emp.Source_System_Id = loe.Source_System_ID AND loe.Source_System_ID IN (3) AND loe.System_Code IN (''AL'',''MS'')
LEFT OUTER JOIN Emp_Service_Dates AS esd ON emp.Source_System_ID = esd.Source_System_ID AND emp.Employee_Key = esd.Employee_Key
LEFT OUTER JOIN Emp_Work_State AS ews  ON emp.Source_System_ID = ews.Source_System_ID AND emp.Employee_Key = ews.Employee_Key
LEFT OUTER JOIN Emp_Payroll_Dates AS epd ON emp.Payroll_ID = epd.Employee_ID AND epd.Employee_PID = emp.Employee_PID AND epd.Source_System_ID IN (5) AND epd.System_Code = ''STW''
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Dataflex_Employees_in_Coastal AS
(
SELECT emp.Employee_Key,
       esd.Derived_First_Service_Date,
       esd.Derived_Last_Service_Date,
       epd.Employee_ID AS Payroll_Employege_ID, epd.System_Code AS Payroll_System_Code, epd.Source_System_ID AS Payroll_Source_System_ID,
       epd.Employee_PID AS Payroll_Employee_PID, epd.Employee_Number AS Payroll_Employee_Number,
       epd.Derived_First_Check_Date,
       epd.Derived_Last_Check_Date,
       NVL( NVL( NVL( ews.Derived_Work_State, emp.Primary_Branch_State), emp.SUTA_State), emp.Employee_State_Code) AS Derived_Work_State
FROM HAH.DIM_Employee AS emp
INNER JOIN List_Of_Employees AS loe ON emp.Employee_Key = loe.Employee_Key AND emp.Source_System_Id = loe.Source_System_ID AND loe.Source_System_ID IN (3) AND loe.System_Code IN (''GA'',''SC'')
LEFT OUTER JOIN Emp_Service_Dates AS esd ON emp.Source_System_ID = esd.Source_System_ID AND emp.Employee_Key = esd.Employee_Key
LEFT OUTER JOIN Emp_Work_State AS ews  ON emp.Source_System_ID = ews.Source_System_ID AND emp.Employee_Key = ews.Employee_Key
LEFT OUTER JOIN Emp_Payroll_Dates AS epd ON emp.Payroll_ID = epd.Employee_ID /* AND epd.Employee_PID = emp.Employee_PID */ AND epd.Source_System_ID IN (5) AND epd.System_Code = ''ILL''
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Sandata_Employees AS
(
SELECT emp.Employee_Key, 
       esd.Derived_First_Service_Date,
       esd.Derived_Last_Service_Date,
       epd.Employee_ID AS Payroll_Employee_ID, epd.System_Code AS Payroll_System_Code, epd.Source_System_ID AS Payroll_Source_System_ID,
       epd.Employee_PID AS Payroll_Employee_PID, epd.Employee_Number AS Payroll_Employee_Number,
       epd.Derived_First_Check_Date,
       epd.Derived_Last_Check_Date,
       NVL( NVL( NVL( ews.Derived_Work_State, emp.Primary_Branch_State), emp.SUTA_State), emp.Employee_State_Code) AS Derived_Work_State
FROM HAH.DIM_Employee AS emp
INNER JOIN List_Of_Employees AS loe ON emp.Employee_Key = loe.Employee_Key AND emp.Source_System_Id = loe.Source_System_ID AND loe.Source_System_ID IN (4)
LEFT OUTER JOIN Emp_Service_Dates AS esd ON emp.Source_System_ID = esd.Source_System_ID AND emp.Employee_Key = esd.Employee_Key
LEFT OUTER JOIN Emp_Work_State AS ews  ON emp.Source_System_ID = ews.Source_System_ID AND emp.Employee_Key = ews.Employee_Key
LEFT OUTER JOIN Emp_Payroll_Dates AS epd ON emp.Employee_ID = epd.Employee_ID /* AND epd.Employee_PID = emp.Employee_PID */ AND epd.Source_System_ID IN (4,6)
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Great_Plains_Corporate_Employees AS
(
SELECT emp.Employee_Key, 
       esd.Derived_First_Service_Date,
       esd.Derived_Last_Service_Date,
       epd.Employee_ID AS Payroll_Employege_ID, epd.System_Code AS Payroll_System_Code, epd.Source_System_ID AS Payroll_Source_System_ID,
       epd.Employee_PID AS Payroll_Employee_PID, epd.Employee_Number AS Payroll_Employee_Number,
       epd.Derived_First_Check_Date,
       epd.Derived_Last_Check_Date,
       NVL( NVL( NVL( ews.Derived_Work_State, emp.Primary_Branch_State), emp.SUTA_State), emp.Employee_State_Code) AS Derived_Work_State
FROM HAH.DIM_Employee AS emp
INNER JOIN List_Of_Employees AS loe ON emp.Employee_Key = loe.Employee_Key AND emp.Source_System_Id = loe.Source_System_ID AND loe.Source_System_ID IN (5) AND loe.System_Code IN (''HAHIL'')
LEFT OUTER JOIN Emp_Service_Dates AS esd ON emp.Source_System_ID = esd.Source_System_ID AND emp.Employee_Key = esd.Employee_Key
LEFT OUTER JOIN Emp_Work_State AS ews  ON emp.Source_System_ID = ews.Source_System_ID AND emp.Employee_Key = ews.Employee_Key
LEFT OUTER JOIN Emp_Payroll_Dates AS epd ON emp.Employee_ID = epd.Employee_ID AND emp.Source_System_Id = epd.Source_System_ID AND /* epd.Employee_PID = emp.Employee_PID AND */ epd.Source_System_ID IN (5) AND epd.System_Code = ''HAHIL''
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Great_Plains_Admin_Employees AS
(
SELECT emp.Employee_Key, 
       esd.Derived_First_Service_Date,
       esd.Derived_Last_Service_Date,
       epd.Employee_ID AS Payroll_Employege_ID, epd.System_Code AS Payroll_System_Code, epd.Source_System_ID AS Payroll_Source_System_ID,
       epd.Employee_PID AS Payroll_Employee_PID, epd.Employee_Number AS Payroll_Employee_Number,
       epd.Derived_First_Check_Date,
       epd.Derived_Last_Check_Date,
       NVL( NVL( NVL( ews.Derived_Work_State, emp.Primary_Branch_State), emp.SUTA_State), emp.Employee_State_Code) AS Derived_Work_State
FROM HAH.DIM_Employee AS emp
INNER JOIN List_Of_Employees AS loe ON emp.Employee_Key = loe.Employee_Key AND emp.Source_System_Id = loe.Source_System_ID AND loe.Source_System_ID IN (5) AND loe.System_Code IN (''ILL'',''STW'',''MICH'')
LEFT OUTER JOIN Emp_Service_Dates AS esd ON emp.Source_System_ID = esd.Source_System_ID AND emp.Employee_Key = esd.Employee_Key
LEFT OUTER JOIN Emp_Work_State AS ews  ON emp.Source_System_ID = ews.Source_System_ID AND emp.Employee_Key = ews.Employee_Key
LEFT OUTER JOIN Emp_Payroll_Dates AS epd ON emp.Employee_ID = epd.Employee_ID AND emp.Source_System_Id = epd.Source_System_ID AND /* epd.Employee_PID = emp.Employee_PID AND */ epd.Source_System_ID IN (5) AND epd.System_Code IN (''ILL'',''STW'',''MICH'')
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
MatrixCare_Employees AS
(
SELECT emp.Employee_Key, 
       esd.Derived_First_Service_Date,
       esd.Derived_Last_Service_Date,
       epd.Employee_ID AS Payroll_Employege_ID, epd.System_Code AS Payroll_System_Code, epd.Source_System_ID AS Payroll_Source_System_ID,
       epd.Employee_PID AS Payroll_Employee_PID, epd.Employee_Number AS Payroll_Employee_Number,
       epd.Derived_First_Check_Date,
       epd.Derived_Last_Check_Date,
       NVL( NVL( NVL( ews.Derived_Work_State, emp.Primary_Branch_State), emp.SUTA_State), emp.Employee_State_Code) AS Derived_Work_State
FROM HAH.DIM_Employee AS emp
INNER JOIN List_Of_Employees AS loe ON emp.Employee_Key = loe.Employee_Key AND emp.Source_System_Id = loe.Source_System_ID AND loe.Source_System_ID IN (7) 
LEFT OUTER JOIN Emp_Service_Dates AS esd ON emp.Source_System_ID = esd.Source_System_ID AND emp.Employee_Key = esd.Employee_Key
LEFT OUTER JOIN Emp_Work_State AS ews ON emp.Source_System_ID = ews.Source_System_ID AND emp.Employee_Key = ews.Employee_Key
LEFT OUTER JOIN Emp_Payroll_Dates AS epd ON emp.Employee_ID = epd.Employee_ID AND emp.Source_System_Id = epd.Source_System_ID AND /* epd.Employee_PID = emp.Employee_PID AND */ epd.Source_System_ID IN (7)
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
CCSI_Employees AS
(
SELECT emp.Employee_Key, 
       esd.Derived_First_Service_Date,
       esd.Derived_Last_Service_Date,
       epd.Employee_ID AS Payroll_Employege_ID, epd.System_Code AS Payroll_System_Code, epd.Source_System_ID AS Payroll_Source_System_ID,
       epd.Employee_PID AS Payroll_Employee_PID, epd.Employee_Number AS Payroll_Employee_Number,
       epd.Derived_First_Check_Date,
       epd.Derived_Last_Check_Date,
       NVL( NVL( NVL( ews.Derived_Work_State, emp.Primary_Branch_State), emp.SUTA_State), emp.Employee_State_Code) AS Derived_Work_State
FROM HAH.DIM_Employee AS emp
INNER JOIN List_Of_Employees AS loe ON emp.Employee_Key = loe.Employee_Key AND emp.Source_System_Id = loe.Source_System_ID AND loe.Source_System_ID IN (8) 
LEFT OUTER JOIN Emp_Service_Dates AS esd ON emp.Source_System_ID = esd.Source_System_ID AND emp.Employee_Key = esd.Employee_Key
LEFT OUTER JOIN Emp_Work_State AS ews ON emp.Source_System_ID = ews.Source_System_ID AND emp.Employee_Key = ews.Employee_Key
LEFT OUTER JOIN Emp_Payroll_Dates AS epd ON emp.Employee_ID = epd.Employee_ID AND emp.Source_System_Id = epd.Source_System_ID AND /* epd.Employee_PID = emp.Employee_PID AND */ epd.Source_System_ID IN (7)
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Preferred_Employees AS
(
SELECT emp.Employee_Key, 
       esd.Derived_First_Service_Date,
       esd.Derived_Last_Service_Date,
       epd.Employee_ID AS Payroll_Employege_ID, epd.System_Code AS Payroll_System_Code, epd.Source_System_ID AS Payroll_Source_System_ID,
       epd.Employee_PID AS Payroll_Employee_PID, epd.Employee_Number AS Payroll_Employee_Number,
       epd.Derived_First_Check_Date,
       epd.Derived_Last_Check_Date,
       NVL( NVL( NVL( ews.Derived_Work_State, emp.Primary_Branch_State), emp.SUTA_State), emp.Employee_State_Code) AS Derived_Work_State
FROM HAH.DIM_Employee AS emp
INNER JOIN List_Of_Employees AS loe ON emp.Employee_Key = loe.Employee_Key AND emp.Source_System_Id = loe.Source_System_ID AND loe.Source_System_ID IN (17) 
LEFT OUTER JOIN Emp_Service_Dates AS esd ON emp.Source_System_ID = esd.Source_System_ID AND emp.Employee_Key = esd.Employee_Key
LEFT OUTER JOIN Emp_Work_State AS ews ON emp.Source_System_ID = ews.Source_System_ID AND emp.Employee_Key = ews.Employee_Key
LEFT OUTER JOIN Emp_Payroll_Dates AS epd ON emp.Employee_ID = epd.Employee_ID AND emp.Source_System_Id = epd.Source_System_ID AND /* epd.Employee_PID = emp.Employee_PID AND */ epd.Source_System_ID IN (17) -- AND epd.System_Code IN (''PREFERRED'')
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
CLEARCARE_Employees AS
(
SELECT emp.Employee_Key, 
       esd.Derived_First_Service_Date,
       esd.Derived_Last_Service_Date,
       epd.Employee_ID AS Payroll_Employege_ID, epd.System_Code AS Payroll_System_Code, epd.Source_System_ID AS Payroll_Source_System_ID,
       epd.Employee_PID AS Payroll_Employee_PID, epd.Employee_Number AS Payroll_Employee_Number,
       epd.Derived_First_Check_Date,
       epd.Derived_Last_Check_Date,
       NVL( NVL( NVL( ews.Derived_Work_State, emp.Primary_Branch_State), emp.SUTA_State), emp.Employee_State_Code) AS Derived_Work_State
FROM HAH.DIM_Employee AS emp
INNER JOIN List_Of_Employees AS loe ON emp.Employee_Key = loe.Employee_Key AND emp.Source_System_Id = loe.Source_System_ID AND loe.Source_System_ID IN (16) 
LEFT OUTER JOIN Emp_Service_Dates AS esd ON emp.Source_System_ID = esd.Source_System_ID AND emp.Employee_Key = esd.Employee_Key
LEFT OUTER JOIN Emp_Work_State AS ews ON emp.Source_System_ID = ews.Source_System_ID AND emp.Employee_Key = ews.Employee_Key
LEFT OUTER JOIN Emp_Payroll_Dates AS epd ON emp.Employee_ID = epd.Employee_ID AND emp.Source_System_Id = epd.Source_System_ID AND /* epd.Employee_PID = emp.Employee_PID AND */ epd.Source_System_ID IN (16) -- AND epd.System_Code IN (''CLEARCARE'')
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Alliance_Employees AS
(
SELECT emp.Employee_Key, 
       esd.Derived_First_Service_Date,
       esd.Derived_Last_Service_Date,
       epd.Employee_ID AS Payroll_Employege_ID, epd.System_Code AS Payroll_System_Code, epd.Source_System_ID AS Payroll_Source_System_ID,
       epd.Employee_PID AS Payroll_Employee_PID, epd.Employee_Number AS Payroll_Employee_Number,
       epd.Derived_First_Check_Date,
       epd.Derived_Last_Check_Date,
       NVL( NVL( NVL( ews.Derived_Work_State, emp.Primary_Branch_State), emp.SUTA_State), emp.Employee_State_Code) AS Derived_Work_State
FROM HAH.DIM_Employee AS emp
INNER JOIN List_Of_Employees AS loe ON emp.Employee_Key = loe.Employee_Key AND emp.Source_System_Id = loe.Source_System_ID AND loe.Source_System_ID IN (19) 
LEFT OUTER JOIN Emp_Service_Dates AS esd ON emp.Source_System_ID = esd.Source_System_ID AND emp.Employee_Key = esd.Employee_Key
LEFT OUTER JOIN Emp_Work_State AS ews ON emp.Source_System_ID = ews.Source_System_ID AND emp.Employee_Key = ews.Employee_Key
LEFT OUTER JOIN Emp_Payroll_Dates AS epd ON emp.Employee_ID = epd.Employee_ID AND emp.Source_System_Id = epd.Source_System_ID AND /* epd.Employee_PID = emp.Employee_PID AND */ epd.Source_System_ID IN (19) -- AND epd.System_Code IN (''PREFERRED'')
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Employee_Derived_Attributes AS
(
SELECT *
FROM Coastal_Employees
UNION
SELECT *
FROM Dataflex_Employees_in_ILL
UNION
SELECT *
FROM Dataflex_Employees_in_MICH
UNION
SELECT *
FROM Dataflex_Employees_in_STW
UNION
SELECT *
FROM Dataflex_Employees_in_Coastal
UNION
SELECT *
FROM Sandata_Employees
UNION
SELECT *
FROM Great_Plains_Admin_Employees
UNION
SELECT *
FROM Great_Plains_Corporate_Employees
UNION
SELECT *
FROM MatrixCare_Employees
UNION
SELECT *
FROM CCSI_EMPLOYEES
UNION
SELECT * 
FROM Preferred_Employees
UNION
SELECT * 
FROM CLEARCARE_Employees
UNION
SELECT *
FROM Alliance_Employees
),
Employee_Tenure_Dates AS
(
SELECT DISTINCT merged_emp.Employee_Key, 
       FIRST_VALUE(merged_emp.Original_Employee_Key) OVER (PARTITION BY merged_emp.Employee_Key ORDER BY merged_emp.Original_Source_System_ID) AS Employee_Key_1,
       LAST_VALUE(merged_emp.Original_Employee_Key) OVER (PARTITION BY merged_emp.Employee_Key ORDER BY merged_emp.Original_Source_System_ID) AS Employee_Key_2,
       merged_emp.Employee_ID, merged_emp.System_Code, 
       merged_emp.Source_System_ID,
       -- Since the Employee_Key is now the new key (coming from Fact_Visit_Merged) select the key where the source system IDs DO NOT match, as the original source system ID
       FIRST_VALUE(merged_emp.Original_Source_System_Id) OVER (PARTITION BY merged_emp.Employee_Key ORDER BY IFF(merged_emp.Original_Source_System_ID <> merged_emp.Source_System_ID, 0, 1)) AS Original_Source_System_ID, 
       merged_emp.MDM_DIM_Employee_Key AS MDM_Employee_Key,
       merged_emp.Employee_PID, merged_emp.Employee_Number, merged_emp.Payroll_ID,merged_emp.Employee_First_Name AS First_Name, merged_emp.Employee_Last_Name AS Last_Name,
       emp.Payroll_Employee_ID, emp.Payroll_System_Code, emp.Payroll_Source_System_ID, emp.Payroll_Employee_PID, emp.Payroll_Employee_Number,
       merged_emp.Employee_Category,
	   CASE WHEN merged_emp.CASE_MANAGER_FLAG = TRUE THEN ''ADMIN'' ELSE merged_emp.Employee_Category END AS Derived_Employee_Category,
	   merged_emp.Employee_Type,
       merged_emp.Employee_Office_Code, merged_emp.Primary_Branch_Key, merged_emp.Primary_Branch_State, merged_emp.Primary_Branch_Name, merged_emp.Primary_Branch_System_Code,
       NULL AS Primary_Supervisor_Key, NULL AS Primary_Supervisor_System_Code, NULL AS Primary_Supervisor_Name,
       merged_emp.Employee_DOB,
       merged_emp.Derived_Employee_Hire_Date AS Employee_Hire_Date, merged_emp.Derived_Employee_Rehire_Date AS Employee_Rehire_Date, merged_emp.Derived_Employee_Benefit_Start_Date AS Employee_Benefit_Start_Date, merged_emp.Derived_Employee_First_Check_Date AS Employee_First_Check_Date,
       MIN(emp.Derived_First_Service_Date) OVER (PARTITION BY emp.Employee_Key) AS Derived_First_Service_Date, 
       MIN(emp.Derived_First_Check_Date) OVER (PARTITION BY emp.Employee_Key) AS Derived_First_Check_Date, 
       merged_emp.Derived_Employee_Last_Worked_Date AS Employee_Last_Worked_Date, 
       merged_emp.Derived_Employee_Terminate_Date AS Employee_Terminate_Date, 
       merged_emp.Derived_Employee_Last_Check_Date AS Employee_Last_Check_Date,
       MAX(emp.Derived_Last_Service_Date) OVER (PARTITION BY emp.Employee_Key) AS Derived_Last_Service_Date, 
       MAX(emp.Derived_Last_Check_Date) OVER (PARTITION BY emp.Employee_Key) AS Derived_Last_Check_Date, 
       merged_emp.Derived_Active_Employee_Flag AS Active_Employee_Flag,
       LAST_VALUE(emp.Derived_Work_State) OVER (PARTITION BY emp.Employee_Key ORDER BY emp.DERIVED_LAST_SERVICE_DATE) AS Derived_Work_State,
       NULLIF( LEAST( NVL( merged_emp.Derived_Employee_Hire_Date, CURRENT_DATE), NVL( merged_emp.Derived_Employee_Rehire_Date, CURRENT_DATE), NVL( merged_emp.Derived_Employee_Benefit_Start_Date, CURRENT_DATE), NVL( merged_emp.Derived_Employee_First_Check_Date, CURRENT_DATE), NVL( MIN(emp.Derived_First_Service_Date) OVER (PARTITION BY emp.Employee_Key), CURRENT_DATE), NVL( MIN(emp.Derived_First_Check_Date) OVER (PARTITION BY emp.Employee_Key), CURRENT_DATE)), CURRENT_DATE) AS Derived_Least_Hire_Date,
       NULLIF( GREATEST( NVL( merged_emp.Derived_Employee_Hire_Date, CAST( ''1950-01-01'' AS DATE)), NVL( merged_emp.Derived_Employee_Rehire_Date, CAST( ''1950-01-01'' AS DATE)), NVL( merged_emp.Derived_Employee_Benefit_Start_Date, CAST( ''1950-01-01'' AS DATE)), NVL( merged_emp.Derived_Employee_First_Check_Date, CAST( ''1950-01-01'' AS DATE)), NVL( MIN(emp.Derived_First_Service_Date) OVER (PARTITION BY emp.Employee_Key), CAST( ''1950-01-01'' AS DATE)), NVL( MIN(emp.Derived_First_Check_Date) OVER (PARTITION BY emp.Employee_Key), CAST( ''1950-01-01'' AS DATE))), CAST( ''1950-01-01'' AS DATE)) AS Derived_Greatest_Hire_Date,
       DATEDIFF( ''DAY'', Derived_Least_Hire_Date, Derived_Greatest_Hire_Date) AS Hire_Date_Range,
       CASE WHEN DATEDIFF( ''DAY'', Derived_Least_Hire_Date, NVL( merged_emp.Derived_Employee_Hire_Date, Derived_Least_Hire_Date)) > 90
              OR DATEDIFF( ''DAY'', Derived_Least_Hire_Date, NVL( merged_emp.Derived_Employee_ReHire_Date, Derived_Least_Hire_Date)) > 90
              OR DATEDIFF( ''DAY'', Derived_Least_Hire_Date, NVL( merged_emp.Derived_Employee_Benefit_Start_Date, Derived_Least_Hire_Date)) > 90
            THEN ''TRUE''
            ELSE ''FALSE''
       END AS Derived_Rehire_Flag,
       Derived_Least_Hire_Date AS Derived_Hire_Date,
       CASE WHEN Derived_Rehire_Flag = ''TRUE'' THEN GREATEST( NVL( merged_emp.Derived_Employee_Hire_Date, CAST( ''1950-01-01'' AS DATE)), NVL( merged_emp.Derived_Employee_Rehire_Date, CAST( ''1950-01-01'' AS DATE)), NVL( merged_emp.Derived_Employee_Benefit_Start_Date, CAST( ''1950-01-01'' AS DATE)))
            ELSE NULL
       END AS Derived_Latest_Rehire_Date,
       NULLIF( GREATEST( NVL( merged_emp.Derived_Employee_Last_Worked_Date, CAST( ''1950-01-01'' AS DATE)), NVL( merged_emp.Employee_Last_Check_Date, CAST( ''1950-01-01'' AS DATE)), NVL( merged_emp.Employee_Terminate_Date, CAST( ''1950-01-01'' AS DATE)), NVL( emp.Derived_Last_Service_Date, CAST( ''1950-01-01'' AS DATE)), NVL( emp.Derived_Last_Check_Date, CAST( ''1950-01-01'' AS DATE))), CAST( ''1950-01-01'' AS DATE)) AS Derived_Greatest_Terminate_Date,
       NULLIF( LEAST( NVL( merged_emp.Derived_Employee_Last_Worked_Date, CURRENT_DATE), NVL( merged_emp.Derived_Employee_Last_Check_Date, CURRENT_DATE), NVL( merged_emp.Derived_Employee_Terminate_Date, CURRENT_DATE), NVL( MAX(emp.Derived_Last_Service_Date) OVER (PARTITION BY emp.Employee_Key), CURRENT_DATE), NVL( MAX(emp.Derived_Last_Check_Date) OVER (PARTITION BY emp.Employee_Key), CURRENT_DATE)), CURRENT_DATE) AS Derived_Least_Terminate_Date,
       DATEDIFF( ''DAY'', Derived_Least_Terminate_Date, Derived_Greatest_Terminate_Date) AS Terminate_Date_Range,
       CASE WHEN Terminate_Date_Range > 90 THEN NVL( GREATEST( merged_emp.Derived_Employee_Last_Worked_Date, MAX(emp.Derived_Last_Service_Date) OVER (PARTITION BY emp.Employee_Key)), NVL( MAX(emp.Derived_Last_Check_Date) OVER (PARTITION BY emp.Employee_Key), merged_emp.Derived_Employee_Last_Check_Date))
            ELSE Derived_Greatest_Terminate_Date
       END AS Derived_Corrected_Greatest_Terminate_Date,
       CASE WHEN DATEDIFF( ''DAY'', Derived_Corrected_Greatest_Terminate_Date, CURRENT_DATE) < 30 THEN NULL
            ELSE NVL( Derived_Corrected_Greatest_Terminate_Date, NVL( Derived_Least_Terminate_Date, Derived_Greatest_Terminate_Date))
       END AS Derived_Latest_Terminate_Date,
       CAST( DATEDIFF( ''DAY'', MAX(emp.Derived_Last_Check_Date) OVER (PARTITION BY emp.Employee_Key), CURRENT_DATE) AS INTEGER) AS Days_Since_Last_Paycheck,
       CAST( CASE WHEN Derived_Hire_Date IS NULL THEN ''FALSE''
                  WHEN Derived_Hire_Date IS NOT NULL AND DATEDIFF( ''DAY'', NVL( Derived_Latest_Terminate_Date, CURRENT_DATE), CURRENT_DATE) >= 30 THEN ''FALSE''
                  ELSE ''TRUE''
             END AS BOOLEAN) AS Derived_Active_Employee_Flag,
       CAST( DATEDIFF( ''YEAR'', merged_emp.Employee_DOB, CURRENT_DATE) AS INTEGER) AS Current_Age,
       CAST( DATEDIFF( ''YEAR'', merged_emp.Employee_DOB, NVL( Derived_Latest_Terminate_Date, CURRENT_DATE)) AS INTEGER) AS Age_At_Termination,
       CAST( DATEDIFF( ''MONTH'', Derived_Hire_Date, NVL( Derived_Latest_Terminate_Date, CURRENT_DATE)) AS INTEGER) AS Tenure_In_Months,
       CASE WHEN Tenure_In_Months < 6 THEN ''1: < 6 Months''
            WHEN Tenure_In_Months BETWEEN 6 AND 11 THEN ''2: 6 - 12 Months''
            WHEN Tenure_In_Months BETWEEN 12 AND 23 THEN ''3: 1 Year''
            WHEN Tenure_In_Months BETWEEN 24 AND 35 THEN ''4: 2 Years''
            WHEN Tenure_In_Months BETWEEN 36 AND 47 THEN ''5: 3 Years''
            WHEN Tenure_In_Months BETWEEN 48 AND 59 THEN ''6: 4 Years''
            WHEN Tenure_In_Months BETWEEN 60 AND 119 THEN ''7: 5 - 10 Years''
            WHEN Tenure_In_Months BETWEEN 120 AND 179 THEN ''8: 10 - 15 Years''
            WHEN Tenure_In_Months BETWEEN 180 AND 239 THEN ''9: 15 - 20 Years''
            WHEN Tenure_In_Months >= 240 THEN ''10: > 20+ Years''
            ELSE ''Unknown''
       END AS EMPLOYEE_TENURE_BUCKET
  FROM Employee_Derived_Attributes AS emp
  JOIN INTEGRATION.DIM_EMPLOYEE_MERGED AS merged_emp
    ON merged_emp.Employee_Key = emp.Employee_Key
),
Employee_Service_Line_List AS
(
SELECT DISTINCT vis.Employee_Key
FROM INTEGRATION.FACT_VISIT_MERGED AS vis
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category IN (''CLS'',''HC'',''HH'',''IS'',''NS'',''OTHER'') AND cntrct.Billable_Flag = ''TRUE''
WHERE vis.CONFIRMED_FLAG = ''YES''
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
CLS_Employees AS
(
SELECT DISTINCT vis.Employee_Key,
    CASE WHEN cntrct.Revenue_Category = ''CLS'' THEN ''TRUE'' END AS CLS_Revenue_Category
FROM INTEGRATION.FACT_VISIT_MERGED AS vis
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category IN (''CLS'') AND cntrct.Revenue_SubCategory_Code IN (''RES'') AND cntrct.Billable_Flag = ''TRUE''
INNER JOIN Employee_Service_Line_List AS esll ON vis.Employee_Key = esll.Employee_Key
WHERE vis.CONFIRMED_FLAG = ''YES''
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
HC_Employees AS
(
SELECT DISTINCT vis.Employee_Key,
    CASE WHEN cntrct.Revenue_Category = ''HC'' THEN ''TRUE'' END AS HC_Revenue_Category
FROM INTEGRATION.FACT_VISIT_MERGED AS vis
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category IN (''HC'') AND cntrct.Billable_Flag = ''TRUE''
INNER JOIN Employee_Service_Line_List AS esll ON vis.Employee_Key = esll.Employee_Key
WHERE vis.CONFIRMED_FLAG = ''YES''
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
HH_Employees AS
(
SELECT DISTINCT vis.Employee_Key,
	CASE WHEN cntrct.Revenue_Category = ''HH'' THEN ''TRUE'' END AS HH_Revenue_Category
FROM INTEGRATION.FACT_VISIT_MERGED AS vis
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category IN (''HH'') AND cntrct.Billable_Flag = ''TRUE''
INNER JOIN Employee_Service_Line_List AS esll ON vis.Employee_Key = esll.Employee_Key
WHERE vis.CONFIRMED_FLAG = ''YES''
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
OTHER_Employees AS
(
SELECT DISTINCT vis.Employee_Key,
	CASE WHEN cntrct.Revenue_Category = ''OTHER'' THEN ''TRUE'' END AS OTHER_Revenue_Category
FROM INTEGRATION.FACT_VISIT_MERGED AS vis
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category IN (''OTHER'') AND cntrct.Billable_Flag = ''TRUE''
INNER JOIN Employee_Service_Line_List AS esll ON vis.Employee_Key = esll.Employee_Key
WHERE vis.CONFIRMED_FLAG = ''YES''
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Employee_Service_Line_Summary AS
(
SELECT esll.Employee_Key,
       emp.EMPLOYEE_ID, emp.EMPLOYEE_PID, emp.EMPLOYEE_NUMBER, emp.PAYROLL_ID, emp.class_id,
       CAST( NVL( clsemp.CLS_Revenue_Category, ''FALSE'') AS BOOLEAN) AS Delivered_CLS_Services_Flag,
       CAST( NVL( hhemp.HH_Revenue_Category, ''FALSE'') AS BOOLEAN) AS Delivered_HH_Services_Flag,
       CAST( NVL( hcemp.HC_Revenue_Category, ''FALSE'') AS BOOLEAN) AS Delivered_HC_Services_Flag,
       CAST( NVL( otheremp.OTHER_Revenue_Category, ''FALSE'') AS BOOLEAN) AS Delivered_OTHER_Services_Flag
FROM Employee_Service_Line_List AS esll
LEFT OUTER JOIN HAH.DIM_Employee AS emp ON esll.Employee_Key = emp.Employee_Key 
LEFT OUTER JOIN CLS_Employees AS clsemp ON esll.Employee_Key = clsemp.Employee_Key
LEFT OUTER JOIN HH_Employees AS hhemp ON esll.Employee_Key = hhemp.Employee_Key
LEFT OUTER JOIN HC_Employees AS hcemp ON esll.Employee_Key = hcemp.Employee_Key
LEFT OUTER JOIN OTHER_Employees AS otheremp ON esll.Employee_Key = otheremp.Employee_Key
WHERE emp.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
Union_Employees AS (
SELECT DISTINCT TRIM( m.DB) AS DB, TRIM( m.EmployeeID) AS Payroll_ID,
       TRIM( LTRIM( m.OfficeNumber, ''0'')) AS Payroll_Office_Number, TRIM( m.SSN) AS Payroll_SSN,
       CAST( ''TRUE'' AS BOOLEAN) AS Union_Flag,
       etd.Employee_Key, etd.Employee_ID, etd.System_Code, etd.Source_System_ID,
       etd.MDM_Employee_Key,
       etd.Employee_PID, etd.Employee_Number,
       etd.Payroll_Employee_ID, etd.Payroll_System_Code, etd.Payroll_Source_System_ID, etd.Payroll_Employee_PID, etd.Payroll_Employee_Number
FROM DISC_PROD.GpSyncData.PayStub_Master AS m
INNER JOIN DISC_PROD.GpSyncData.PayStub_DetailLine AS dtl ON m.CheckID = dtl.CheckID AND ( dtl.PayCode LIKE ANY (''%DUE%'', ''%UNION%'') OR dtl.IsUnionDue = ''TRUE'' OR dtl.Paycode IN ( ''DUEADJ'', ''DUESM'', ''DUESO'', ''INDUES'', ''UNION'', ''UNA'', ''UNA2''))  
LEFT OUTER JOIN Employee_Tenure_Dates as etd ON HEX_DECODE_STRING( etd.Payroll_Employee_PID) = TRIM( m.SSN) AND etd.System_Code IN (''IL'', ''IN'') AND etd.Payroll_Employee_ID = TRIM( m.EmployeeID) AND etd.Employee_Office_Code = TRIM( LTRIM( m.OfficeNumber, ''0''))
WHERE m.DB = ''ILL''
AND etd.Employee_Key IS NOT NULL -- ~485 without the office join condition, 23,774 NULLs;  
-- ''DUEADJ'', ''DUESM'', ''DUESO'', ''INDUES'', ''UNION'', ''UNA'', ''UNA2''
-- ''BACKCK'', ''DUEADJ'', ''DUESM'', ''DUESO'', ''INDUES'', ''UNION'', ''UNA'', ''UNA2''
UNION
SELECT DISTINCT TRIM( emp.DB) AS DB, TRIM( emp.EMPLOYEE_ID) AS Payroll_ID,
       TRIM( LTRIM( emp.Office, ''0'')) AS Payroll_Office_Number, TRIM( emp.SSN) AS Payroll_SSN,
       CAST( ''TRUE'' AS BOOLEAN) AS Union_Flag,
       etd.Employee_Key, etd.Employee_ID, etd.System_Code, etd.Source_System_ID,
       etd.MDM_Employee_Key,
       etd.Employee_PID, etd.Employee_Number,
       etd.Payroll_Employee_ID, etd.Payroll_System_Code, etd.Payroll_Source_System_ID, etd.Payroll_Employee_PID, etd.Payroll_Employee_Number
FROM DISC_PROD.GPSYNCDATA.GPALLEMPLOYEESBASE AS emp
LEFT OUTER JOIN Employee_Tenure_Dates as etd ON HEX_DECODE_STRING( etd.Payroll_Employee_PID) = TRIM( emp.SSN) AND etd.Payroll_Employee_ID = TRIM( emp.Employee_ID) AND etd.System_Code IN (''IL'', ''IN'') AND etd.Employee_Office_Code = TRIM( LTRIM( emp.Office, ''0'')) -- etd.Payroll_ID = m.EmployeeID
WHERE TRIM( emp.WORK_STATE) = ''IL'' AND emp.IS_ADMIN = 0
AND TRIM( emp.Contract_Type) IS NOT NULL AND TRIM( emp.Contract_Type) <> ''''  -- 19,049
AND TRIM( emp.CONTRACT_TYPE) <> ''[100,0,0]''
)
SELECT DISTINCT etd.Employee_Key, etd.Employee_ID, etd.System_Code, 
	   etd.Source_System_ID,
	   etd.Original_Source_System_ID,
       etd.MDM_Employee_Key,
       etd.Employee_PID, etd.Employee_Number,etd.first_name, etd.last_name,
       etd.Employee_Category,
 	   etd.Derived_Employee_Category,
	   etd.Employee_Type,
       etd.Derived_Work_State,
       etd.Employee_Office_Code,
       etd.Primary_Branch_Key, etd.Primary_Branch_State, etd.Primary_Branch_Name, etd.Primary_Branch_System_Code,
       etd.Primary_Supervisor_Key, etd.Primary_Supervisor_System_Code, etd.Primary_Supervisor_Name,
       etd.Employee_DOB,
       etd.Current_Age,
       etd.Age_At_Termination,
       etd.Employee_Hire_Date, etd.Employee_Rehire_Date, etd.Employee_Benefit_Start_Date, etd.Employee_First_Check_Date,
       etd.Employee_Last_Check_Date, etd.Employee_Last_Worked_Date, etd.Employee_Terminate_Date,
       etd.Derived_Hire_Date, etd.Derived_Latest_Rehire_Date,
       CAST( NVL( etd.Derived_Rehire_Flag, ''FALSE'') AS Boolean) AS Derived_Rehire_Flag,
       etd.Derived_First_Check_Date, etd.Derived_Last_Check_Date,
       etd.Derived_First_Service_Date, etd.Derived_Last_Service_Date,
       etd.Derived_Latest_Terminate_Date,
       etd.Tenure_In_Months,
       etd.Employee_Tenure_Bucket,
       CAST( CASE WHEN etd.Derived_Active_Employee_Flag = ''FALSE'' THEN DATEDIFF( ''DAY'', etd.Derived_Latest_Terminate_Date, CURRENT_DATE)
                  ELSE NULL
             END AS INTEGER) AS Days_Inactive,
       NVL( emos.Months_of_Active_Service, 0) AS Months_of_Active_Service,
       esls.Delivered_CLS_Services_Flag,
       esls.Delivered_HH_Services_Flag,
       esls.Delivered_HC_Services_Flag,
       esls.Delivered_OTHER_Services_Flag,
	   esls.class_id,
       etd.Days_Since_Last_Paycheck,
       CAST( NVL( etd.Active_Employee_Flag, ''FALSE'') AS BOOLEAN) AS Active_Employee_Flag,
       CAST( NVL( etd.Derived_Active_Employee_Flag, ''FALSE'') AS BOOLEAN) AS Derived_Active_Employee_Flag,
       CAST( NVL( ue.Union_Flag, ''FALSE'') AS BOOLEAN) AS Derived_Union_Flag,
       etd.Payroll_ID,
       etd.Payroll_Employee_ID, etd.Payroll_System_Code, etd.Payroll_Source_System_ID, etd.Payroll_Employee_PID, etd.Payroll_Employee_Number,
       NULL AS Derived_Pay_Rate_Salary,
       NULL AS Derived_Pay_Rate_Hourly,
       NULL AS Derived_Pay_Rate_Avg_Hourly,
       NULL AS Derived_Pay_Rate_Min_Hourly,
       NULL AS Derived_Pay_Rate_Max_Hourly,
       CAST( ''FALSE'' AS BOOLEAN) AS Derived_Exempt_Flag,
       NULL AS TOTAL_WAGES_CURRENT_YEAR,
       NULL AS TOTAL_WAGES_PREVIOUS_YEAR,
       NULL AS TOTAL_WAGES_2_YEARS_PREVIOUS,
       NULL AS TOTAL_REG_HOURS_ROLLING_12_MONTHS,
       NULL AS AVG_WEEKLY_REG_HOURS_ROLLING_12_MONTHS,
       NULL AS TOTAL_OVERTIME_HOURS_ROLLING_12_MONTHS,
       NULL AS AVG_WEEKLY_OVERTIME_HOURS_ROLLING_12_MONTHS,
       NULL AS TOTAL_COMPENSATION_ROLLING_12_MONTHS,
       NULL AS AVG_HOURLY_PAY_RATE_ROLLING_12_MONTHS,
       NULL AS AVG_HOURLY_OVERTIME_RATE_ROLLING_12_MONTHS,
       NULL AS BONUS_COMPENSATION_ROLLING_12_MONTHS,
       NULL AS TOTAL_REG_HOURS_PREV_YR,
       NULL AS AVG_WEEKLY_REG_HOURS_PREV_YR,
       NULL AS TOTAL_OVERTIME_HOURS_PREV_YR,
       NULL AS AVG_WEEKLY_OVERTIME_HOURS_PREV_YR,
       NULL AS TOTAL_COMPENSATION_PREV_YR,
       NULL AS AVG_HOURLY_PAY_RATE_PREV_YR,
       NULL AS AVG_HOURLY_OVERTIME_RATE_PREV_YR,
       NULL AS BONUS_COMPENSATION_PREV_YR,
       NULL AS TOTAL_REG_HOURS_CURR_YR,
       NULL AS AVG_WEEKLY_REG_HOURS_CURRENT_YR,
       NULL AS TOTAL_OVERTIME_HOURS_CURR_YR,
       NULL AS AVG_WEEKLY_OVERTIME_HOURS_CURRENT_YR,
       NULL AS TOTAL_COMPENSATION_CURR_YR,
       NULL AS AVG_HOURLY_PAY_RATE_CURRENT_YR,
       NULL AS AVG_HOURLY_OVERTIME_RATE_CURRENT_YR,
       NULL AS BONUS_COMPENSATION_CURRENT_YR
FROM Employee_Tenure_Dates AS etd
LEFT OUTER JOIN Employee_Service_Line_Summary AS esls ON etd.Employee_Key = esls.Employee_Key
LEFT OUTER JOIN Emp_Months_of_Service AS emos ON etd.Employee_Key = emos.Employee_Key
LEFT OUTER JOIN Union_Employees AS ue ON ue.Employee_Key IN (etd.Employee_Key_1, etd.Employee_Key_2);

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';