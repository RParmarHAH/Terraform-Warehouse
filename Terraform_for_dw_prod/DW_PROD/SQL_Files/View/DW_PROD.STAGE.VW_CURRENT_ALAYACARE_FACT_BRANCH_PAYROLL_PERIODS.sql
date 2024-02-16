create or replace view DW_PROD.STAGE.VW_CURRENT_ALAYACARE_FACT_BRANCH_PAYROLL_PERIODS(
	BRANCH_PAYROLL_PERIODS_KEY
) as
WITH GA_Pay_Dates AS
(
-- Weekly payroll
SELECT dd.Calendar_Date AS Check_Date,
       'Weekly' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -11, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -5, dd.Calendar_Date)
WHERE dd.Day_Name = 'Fri'
AND dd.Date_Key >= '19700101'
)
, AL_Pay_Dates AS
(
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
AND dd.Date_Key >= '19700101'
)
SELECT MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || 'Field, Admin' || CAST( ppd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key
FROM HAH.DIM_Branch AS br
JOIN GA_Pay_Dates AS ppd ON br.SYSTEM_CODE = 'GEORGIA (1002)'
WHERE br.Source_system_ID = 9
UNION
SELECT MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || 'Field, Admin' || CAST( ppd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key
FROM HAH.DIM_Branch AS br
JOIN AL_Pay_Dates AS ppd ON br.SYSTEM_CODE = 'ALABAMA (3554)'
WHERE br.Source_system_ID = 9;