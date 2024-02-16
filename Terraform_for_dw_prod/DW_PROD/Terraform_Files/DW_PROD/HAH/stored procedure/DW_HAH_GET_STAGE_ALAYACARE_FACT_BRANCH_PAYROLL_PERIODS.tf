resource "snowflake_procedure" "DW_HAH_GET_STAGE_ALAYACARE_FACT_BRANCH_PAYROLL_PERIODS" {
	name ="GET_STAGE_ALAYACARE_FACT_BRANCH_PAYROLL_PERIODS"
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
  RETURN_RESULT VARCHAR(1000);
BEGIN
    --
--*****************************************************************************************************************************
-- NAME:  SandataImport_FACT_Branch_Payroll_Periods
--
-- PURPOSE: Creates one row per pay period by branch based on DIM_Date and Pa payroll schedule
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 02/21/22    Moin Saiyed		     Initial development for GA
-- 03/23/22    Jashvant Patel        Added AL Data
--*****************************************************************************************************************************
--
--  ALAYACARE Payroll Periods
--
INSERT OVERWRITE INTO Stage.ALAYACARE_FACT_BRANCH_PAYROLL_PERIODS (
	BRANCH_PAYROLL_PERIODS_KEY, 
	BRANCH_KEY, OFFICE_STATE_CODE, DETAILED_OFFICE_NAME,
    PERIOD_START_DATE, PERIOD_END_DATE, CHECK_DATE,
	ETL_TASK_KEY, ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE, ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG, ETL_INFERRED_MEMBER_FLAG
)
WITH GA_Pay_Dates AS
(
SELECT dd.Calendar_Date AS Check_Date,
       ''Weekly'' AS Pay_Frequency,
       dd.Day_Name AS Check_Day_Name,
       stdt.Calendar_Date AS Period_Start_Date,
       stdt.Day_Name AS Period_Start_Day_Name,
       enddt.Calendar_Date AS Period_End_Date,
       enddt.Day_Name AS Period_End_Day_Name
FROM HAH.DIM_Date AS dd
INNER JOIN HAH.DIM_Date AS stdt ON stdt.Calendar_Date = DATEADD( DAY, -11, dd.Calendar_Date)
INNER JOIN HAH.DIM_Date AS enddt ON enddt.Calendar_Date = DATEADD( DAY, -5, dd.Calendar_Date)
WHERE dd.Day_Name = ''Fri''
AND dd.Date_Key >= ''19700101''
)
, AL_Pay_Dates AS
(
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
AND dd.Date_Key >= ''19700101''
)
SELECT MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || ''Field, Admin'' || CAST( ppd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key,
       br.Branch_Key, 
       br.Office_State_Code,
       br.Detailed_Office_Name, 
       ppd.Period_Start_Date, 
       ppd.Period_End_Date, 
	   ppd.Check_Date, 
	   :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
       :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
       CURRENT_USER as ETL_INSERTED_BY ,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
       CURRENT_USER as ETL_LAST_UPDATED_BY,
       0 as ETL_DELETED_FLAG,
       0 as ETL_INFERRED_MEMBER_FLAG
FROM HAH.DIM_Branch AS br
JOIN GA_Pay_Dates AS ppd ON br.SYSTEM_CODE = ''GEORGIA (1002)''
WHERE br.Source_system_ID = 9
UNION 
SELECT MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || ''Field, Admin'' || CAST( ppd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key,
       br.Branch_Key, 
       br.Office_State_Code,
       br.Detailed_Office_Name, 
       ppd.Period_Start_Date, 
       ppd.Period_End_Date, 
	   ppd.Check_Date, 
	   :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
       :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY, 
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
       CURRENT_USER as ETL_INSERTED_BY ,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
       CURRENT_USER as ETL_LAST_UPDATED_BY,
       0 as ETL_DELETED_FLAG,
       0 as ETL_INFERRED_MEMBER_FLAG
FROM HAH.DIM_Branch AS br
JOIN AL_Pay_Dates AS ppd ON br.SYSTEM_CODE = ''ALABAMA (3554)''
WHERE br.Source_system_ID = 9;

SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

