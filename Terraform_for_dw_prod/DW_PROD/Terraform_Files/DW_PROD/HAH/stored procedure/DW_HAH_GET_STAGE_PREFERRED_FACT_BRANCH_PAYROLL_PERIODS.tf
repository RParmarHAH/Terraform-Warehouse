resource "snowflake_procedure" "DW_HAH_GET_STAGE_PREFERRED_FACT_BRANCH_PAYROLL_PERIODS" {
	name ="GET_STAGE_PREFERRED_FACT_BRANCH_PAYROLL_PERIODS"
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

                BEGIN
    --*****************************************************************************************************************************
-- NAME:  PREFERRED_FACT BRANCH PAYROLL PERIOD
--
-- PURPOSE: Creates one row per pay period by branch based on DIM_Date and Preferred payroll schedule
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 05/04/22    Jashvant Patel        Initial development
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.PREFERRED_FACT_BRANCH_PAYROLL_PERIODS
WITH DATE_MAPPING AS 
(
SELECT DD.CALENDAR_DATE AS CHECK_DATE,
       ''WEEKLY'' AS PAY_FREQUENCY,
       DD.DAY_NAME AS CHECK_DAY_NAME,
       STDT.CALENDAR_DATE AS PERIOD_START_DATE,
       STDT.DAY_NAME AS PERIOD_START_DAY_NAME,
       ENDDT.CALENDAR_DATE AS PERIOD_END_DATE,
       ENDDT.DAY_NAME AS PERIOD_END_DAY_NAME
FROM HAH.DIM_DATE AS DD
INNER JOIN HAH.DIM_DATE AS STDT ON STDT.CALENDAR_DATE = DATEADD( DAY, -12, DD.CALENDAR_DATE)
INNER JOIN HAH.DIM_DATE AS ENDDT ON ENDDT.CALENDAR_DATE = DATEADD( DAY, -6, DD.CALENDAR_DATE)
WHERE DD.DAY_NAME = ''Thu''
AND DD.DATE_KEY >= ''20090625''
)
SELECT 
MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || CAST( ppd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key,
BR.BRANCH_KEY  AS BRANCH_KEY ,
BR.OFFICE_STATE_CODE  AS OFFICE_STATE_CODE,
BR.OFFICE_NAME AS DETAILED_OFFICE_NAME,
PPD.PERIOD_START_DATE  AS PERIOD_START_DATE,
PPD.PERIOD_END_DATE  AS PERIOD_END_DATE,
PPD.CHECK_DATE,
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
                        
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG,
    0 AS ETL_INFERRED_MEMBER_FLAG
FROM DATE_MAPPING PPD
JOIN "STAGE".PREFERRED_DIM_BRANCH BR ON 1=1
;
    RETURN ''SUCCESS'';
    END;
    
 EOT
}

