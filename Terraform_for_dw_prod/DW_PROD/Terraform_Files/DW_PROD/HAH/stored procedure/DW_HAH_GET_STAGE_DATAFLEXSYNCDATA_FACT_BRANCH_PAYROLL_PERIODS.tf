resource "snowflake_procedure" "DW_HAH_GET_STAGE_DATAFLEXSYNCDATA_FACT_BRANCH_PAYROLL_PERIODS" {
	name ="GET_STAGE_DATAFLEXSYNCDATA_FACT_BRANCH_PAYROLL_PERIODS"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
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
    --*************************************************************************************************************************************
-- NAME:  FACT_BRANCH_Payroll_Periods
--
-- PURPOSE: Creates one row per branch and pay period based on DIM_Date and dataflex payroll schedule by branch
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 05/21/20    Frank Noordover       Initial development, needs to be incorporated into the pipeline
-- 02/01/21    Devansh Patel         Rebuilt structure with parent branch flag set to true to add all costal parent branches
-- 22/01/21    Devansh Patel         Changed costal payroll date to be a Tuesday
-- 02/03/21    Devansh Patel         Changed altrus payroll date to be a Friday
-- 08/11/21    Mir Ali               Updated to use as part of the pipeline
--                                   Modified to only capture Dataflex states (Source_System_Id = 3)
-- 10/22/21    Frank Noordover       Revised for all Dataflex states and branches and their conversion from biweekly to weekly payroll
-- 12/23/21    Deepen Gajjar		 Changed ISO_week to cumulative_week
--*************************************************************************************************************************************
--
--
--  Dataflex Payroll Periods by state and branch
--
INSERT OVERWRITE INTO Stage.DataflexSyncData_FACT_Branch_Payroll_Periods (
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
-- Dataflex/HAH IL, MI, MO pay dates
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
),
--
-- Dataflex GA, SC pay dates
-- Latest pay date was in March, 2020
--
GA_Pay_Dates AS
(
-- Bi-weekly payroll
SELECT dd.Calendar_Date AS Check_Date,
       ''Biweekly'' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
-- SELECT *
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -18, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -5, dd.Calendar_Date)
WHERE dd.Day_Name = ''Fri''
AND MOD( dd.CUMULATIVE_WEEK, 2) = 0
AND dd.Date_Key >= ''19700101''
AND dd.Date_Key <= ''20200331''
),
--
--  Dataflex IN, KY and TN payroll periods
--
IN_Pay_Dates AS
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
AND MOD( dd.CUMULATIVE_WEEK, 2) = 0
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
AND MOD( dd.CUMULATIVE_WEEK, 2) = 0
AND dd.Date_Key >= ''20211007''
AND dd.Date_Key <= ''20211009''
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
AND dd.Date_Key >= ''20211015''
),
--
--  Dataflex AL and MS payroll periods
--
AL_Pay_Dates AS
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
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -20, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -7, dd.Calendar_Date)
WHERE dd.Day_Name = ''Fri''
AND MOD( dd.CUMULATIVE_WEEK, 2) = 0
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
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -20, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -7, dd.Calendar_Date)
WHERE dd.Day_Name = ''Fri''
AND MOD( dd.CUMULATIVE_WEEK, 2) = 0
AND dd.Date_Key >= ''20211007''
AND dd.Date_Key <= ''20211009''
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
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -13, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -7, dd.Calendar_Date)
WHERE dd.Day_Name = ''Fri''
AND dd.Date_Key >= ''20211015''
)
SELECT MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || ''Field, Admin'' || CAST( ipd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key,
       br.Source_System_ID, br.System_Code, 
       br.Branch_Key, 
       br.Office_State_Code,
       br.Detailed_Office_Name, 
       ''Field, Admin'' AS Employee_Category,
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
WHERE Source_system_ID = 3
AND System_Code IN ( ''IL'', ''MI'', ''MO'')
AND Parent_Branch_Key = Branch_Key
UNION
SELECT MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || ''Field, Admin'' || CAST( ipd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key,
       br.Source_System_ID, br.System_Code, 
       br.Branch_Key, 
       br.Office_State_Code,
       br.Detailed_Office_Name, 
       ''Field, Admin'' AS Employee_Category,
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
FULL OUTER JOIN IN_Pay_Dates AS ipd
WHERE Source_system_ID = 3
AND System_Code IN ( ''IN'', ''KY'', ''TN'')
AND Parent_Branch_Key = Branch_Key
UNION
SELECT MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || ''Field, Admin'' || CAST( gpd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key,
       br.Source_System_ID, br.System_Code, 
       br.Branch_Key, 
       br.Office_State_Code,
       br.Detailed_Office_Name, 
       ''Field, Admin'' AS Employee_Category,
       gpd.Pay_Frequency,
       gpd.Check_Date, gpd.Check_Day_Name,
       gpd.Period_Start_Date, gpd.Period_Start_Day_Name,
       gpd.Period_End_Date, gpd.Period_End_Day_Name,
       
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
                        
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
       CURRENT_USER as ETL_INSERTED_BY ,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
       CURRENT_USER as ETL_LAST_UPDATED_BY,
       0 as ETL_DELETED_FLAG,
       0 as ETL_INFERRED_MEMBER_FLAG
FROM HAH.DIM_Branch AS br
FULL OUTER JOIN GA_Pay_Dates AS gpd
WHERE Source_system_ID IN (3)
AND System_Code IN ( ''GA'', ''SC'')
AND Parent_Branch_Key = Branch_Key
UNION
SELECT MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || ''Field, Admin'' || CAST( apd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key,
       br.Source_System_ID, br.System_Code, 
       br.Branch_Key, 
       br.Office_State_Code,
       br.Detailed_Office_Name, 
       ''Field, Admin'' AS Employee_Category,
       apd.Pay_Frequency,
       apd.Check_Date, apd.Check_Day_Name,
       apd.Period_Start_Date, apd.Period_Start_Day_Name,
       apd.Period_End_Date, apd.Period_End_Day_Name,
       
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
                        
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
       CURRENT_USER as ETL_INSERTED_BY ,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
       CURRENT_USER as ETL_LAST_UPDATED_BY,
       0 as ETL_DELETED_FLAG,
       0 as ETL_INFERRED_MEMBER_FLAG
FROM HAH.DIM_Branch AS br
FULL OUTER JOIN AL_Pay_Dates AS apd
WHERE Source_system_ID = 3
AND System_Code IN ( ''AL'', ''MS'')
AND Parent_Branch_Key = Branch_Key
ORDER BY 4, 5, 6
;
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}

