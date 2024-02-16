create or replace view DW_PROD.STAGE.VW_CURRENT_DATAFLEXSYNCDATA_FACT_BRANCH_PAYROLL_PERIODS(
	BRANCH_PAYROLL_PERIODS_KEY
) as
WITH IL_Pay_Dates AS
(
-- Bi-weekly payroll
SELECT dd.Calendar_Date AS Check_Date,
       'Biweekly' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -18, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -5, dd.Calendar_Date)
WHERE dd.Day_Name = 'Fri'
AND MOD( dd.CUMULATIVE_WEEK, 2) = 1
AND dd.Date_Key >= '19700101'
AND dd.Date_Key <= '20211001'
UNION
-- Transition week from bi-weekly payroll to weekly
SELECT dd.Calendar_Date AS Check_Date,
       'Biweekly' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -18, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -6, dd.Calendar_Date)
WHERE dd.Day_Name = 'Fri'
AND MOD( dd.CUMULATIVE_WEEK, 2) = 1
AND dd.Date_Key >= '20211014'
AND dd.Date_Key <= '20211016'
UNION  
-- Weekly payroll
SELECT dd.Calendar_Date AS Check_Date,
       'Weekly' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -12, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -6, dd.Calendar_Date)
WHERE dd.Day_Name = 'Fri'
AND dd.Date_Key > '20211015'
),
GA_Pay_Dates AS
(
-- Bi-weekly payroll
SELECT dd.Calendar_Date AS Check_Date,
       'Biweekly' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
-- SELECT *
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -18, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -5, dd.Calendar_Date)
WHERE dd.Day_Name = 'Fri'
AND MOD( dd.CUMULATIVE_WEEK, 2) = 0
AND dd.Date_Key >= '19700101'
AND dd.Date_Key <= '20200331'
),
IN_Pay_Dates AS
(
-- Bi-weekly payroll
SELECT dd.Calendar_Date AS Check_Date,
       'Biweekly' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -18, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -5, dd.Calendar_Date)
WHERE dd.Day_Name = 'Fri'
AND MOD( dd.CUMULATIVE_WEEK, 2) = 0
AND dd.Date_Key >= '19700101'
AND dd.Date_Key <= '20211001'
UNION
-- Transition week from bi-weekly payroll to weekly
SELECT dd.Calendar_Date AS Check_Date,
       'Biweekly' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -18, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -6, dd.Calendar_Date)
WHERE dd.Day_Name = 'Fri'
AND MOD( dd.CUMULATIVE_WEEK, 2) = 0
AND dd.Date_Key >= '20211007'
AND dd.Date_Key <= '20211009'
UNION  
-- Weekly payroll
SELECT dd.Calendar_Date AS Check_Date,
       'Weekly' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -12, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -6, dd.Calendar_Date)
WHERE dd.Day_Name = 'Fri'
AND dd.Date_Key >= '20211015'
),
AL_Pay_Dates AS
(
-- Bi-weekly payroll
SELECT dd.Calendar_Date AS Check_Date,
       'Biweekly' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -20, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -7, dd.Calendar_Date)
WHERE dd.Day_Name = 'Fri'
AND MOD( dd.CUMULATIVE_WEEK, 2) = 0
AND dd.Date_Key >= '19700101'
AND dd.Date_Key <= '20211001'
UNION
-- Transition week from bi-weekly payroll to weekly
SELECT dd.Calendar_Date AS Check_Date,
       'Biweekly' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -20, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -7, dd.Calendar_Date)
WHERE dd.Day_Name = 'Fri'
AND MOD( dd.CUMULATIVE_WEEK, 2) = 0
AND dd.Date_Key >= '20211007'
AND dd.Date_Key <= '20211009'
UNION  
-- Weekly payroll
SELECT dd.Calendar_Date AS Check_Date,
       'Weekly' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -13, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -7, dd.Calendar_Date)
WHERE dd.Day_Name = 'Fri'
AND dd.Date_Key >= '20211015'
)
SELECT MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || 'Field, Admin' || CAST( ipd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key
FROM HAH.DIM_Branch AS br
FULL OUTER JOIN IL_Pay_Dates AS ipd
WHERE Source_system_ID = 3
AND System_Code IN ( 'IL', 'MI', 'MO')
AND Parent_Branch_Key = Branch_Key
UNION
SELECT MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || 'Field, Admin' || CAST( ipd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key
FROM HAH.DIM_Branch AS br
FULL OUTER JOIN IN_Pay_Dates AS ipd
WHERE Source_system_ID = 3
AND System_Code IN ( 'IN', 'KY', 'TN')
AND Parent_Branch_Key = Branch_Key
UNION
SELECT MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || 'Field, Admin' || CAST( gpd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key
FROM HAH.DIM_Branch AS br
FULL OUTER JOIN GA_Pay_Dates AS gpd
WHERE Source_system_ID IN (3)
AND System_Code IN ( 'GA', 'SC')
AND Parent_Branch_Key = Branch_Key
UNION
SELECT MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || 'Field, Admin' || CAST( apd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key
FROM HAH.DIM_Branch AS br
FULL OUTER JOIN AL_Pay_Dates AS apd
WHERE Source_system_ID = 3
AND System_Code IN ( 'AL', 'MS')
AND Parent_Branch_Key = Branch_Key;