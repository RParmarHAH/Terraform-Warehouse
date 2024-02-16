CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_GPSYNCDATA_FACT_BRANCH_PAYROLL_PERIODS("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    --
--*****************************************************************************************************************************
-- NAME:  GPSyncData_FACT_Branch_Payroll_Periods
--
-- PURPOSE: Creates one row per pay period based on DIM_Date and corporate payroll schedule
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 10/22/21    Frank Noordover       Initial development
-- 12/23/21    Deepen Gajjar         changed iso_week to cumulative_week
--*****************************************************************************************************************************
--
--  Corporate Payroll Periods for IL by branch
--
INSERT OVERWRITE INTO Stage.GPSyncData_FACT_Branch_Payroll_Periods (
	BRANCH_PAYROLL_PERIODS_KEY, SOURCE_SYSTEM_ID, SYSTEM_CODE,
	BRANCH_KEY, OFFICE_STATE_CODE, DETAILED_OFFICE_NAME,
    Employee_Category,
    Pay_Frequency,
    CHECK_DATE, CHECK_DAY_NAME,
    PERIOD_START_DATE, PERIOD_START_DAY_NAME,
	PERIOD_END_DATE, PERIOD_END_DAY_NAME,
	ETL_TASK_KEY, ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE, ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG, ETL_INFERRED_MEMBER_FLAG
)
--
-- Corporate IL pay dates
--
WITH IL_Pay_Dates AS
(
-- Bi-weekly payroll
SELECT dd.Calendar_Date AS Check_Date,
       ''Biweekly'' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -18, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -5, dd.Calendar_Date)
WHERE dd.Day_Name = ''Fri''
AND MOD( dd.CUMULATIVE_WEEK, 2) = 1
AND dd.Date_Key >= ''19700101''
AND dd.Date_Key <= ''20211001''
UNION
-- Transition week from bi-weekly payroll to weekly
SELECT dd.Calendar_Date AS Check_Date,
       ''Biweekly'' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -18, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -6, dd.Calendar_Date)
WHERE dd.Day_Name = ''Fri''
AND MOD( dd.CUMULATIVE_WEEK, 2) = 1
AND dd.Date_Key >= ''20211014''
AND dd.Date_Key <= ''20211016''
UNION  
-- Weekly payroll
SELECT dd.Calendar_Date AS Check_Date,
       ''Weekly'' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -12, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -6, dd.Calendar_Date)
WHERE dd.Day_Name = ''Fri''
AND dd.Date_Key > ''20211015''
)
SELECT MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || ''Corp'' || CAST( ipd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key,
       br.Source_System_ID, br.System_Code, 
       br.Branch_Key, 
       br.Office_State_Code,
       br.Detailed_Office_Name, 
       ''Corp'' AS Employee_Category,
       ipd.Pay_Frequency,
       ipd.Check_Date, ipd.Check_Day_Name,
       ipd.Period_Start_Date, ipd.Period_Start_Day_Name,
       ipd.Period_End_Date, ipd.Period_End_Day_Name,
    	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
       CURRENT_USER as ETL_INSERTED_BY ,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
       CURRENT_USER as ETL_LAST_UPDATED_BY,
       0 as ETL_DELETED_FLAG,
       0 as ETL_INFERRED_MEMBER_FLAG
FROM HAH.DIM_Branch AS br
FULL OUTER JOIN IL_Pay_Dates AS ipd
WHERE Source_system_ID = 5
AND System_Code IN ( ''G'')
AND Parent_Branch_Key = Branch_Key
ORDER BY 4, 5, ipd.Check_Date
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
    return return_result;
END;
    ';