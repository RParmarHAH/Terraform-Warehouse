resource "snowflake_procedure" "DW_HAH_GET_STAGE_CLEARCARE_FACT_BRANCH_PAYROLL_PERIODS" {
	name ="GET_STAGE_CLEARCARE_FACT_BRANCH_PAYROLL_PERIODS"
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
--*****************************************************************************************************************************
-- NAME:  Clear care FACT BRANCH PAYROLL PERIODS
--
-- PURPOSE: Populates Stage FACT BRANCH PAYROLL PERIODS for Clear Care 
--			
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 08/05/22    SAM HUFF             Initial version
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.CLEARCARE_FACT_BRANCH_PAYROLL_PERIODS
WITH DATE_MAPPING AS 
(
SELECT DD.CALENDAR_DATE AS CHECK_DATE,
    
        --PAY FREQUENCY?
       ''WEEKLY'' AS PAY_FREQUENCY,
       DD.DAY_NAME AS CHECK_DAY_NAME,
       STDT.CALENDAR_DATE AS PERIOD_START_DATE,
       STDT.DAY_NAME AS PERIOD_START_DAY_NAME,
       ENDDT.CALENDAR_DATE AS PERIOD_END_DATE,
       ENDDT.DAY_NAME AS PERIOD_END_DAY_NAME
FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE AS DD
--first day of the pay period
INNER JOIN HAH.DIM_DATE AS STDT ON STDT.CALENDAR_DATE = DATEADD( DAY, -12, DD.CALENDAR_DATE)
--last day of the pay period
INNER JOIN HAH.DIM_DATE AS ENDDT ON ENDDT.CALENDAR_DATE = DATEADD( DAY, -6, DD.CALENDAR_DATE)
    
--the day employees are paid for that period
WHERE DD.DAY_NAME ILIKE ''%FRI%''
AND DD.DATE_KEY >= ''20080801''
)
SELECT 
MD5( CAST(br.Source_System_ID AS VARCHAR) || br.System_Code || br.Branch_Key || CAST( ppd.Check_Date AS VARCHAR)) AS Branch_Payroll_Periods_Key,
BR.BRANCH_KEY  AS BRANCH_KEY ,
BR.OFFICE_STATE_CODE  AS OFFICE_STATE_CODE,
''OH'' || '' - '' || BR.OFFICE_NAME || '' - '' || BR.OFFICE_NUMBER AS DETAILED_OFFICE_NAME,
PPD.PERIOD_START_DATE  AS PERIOD_START_DATE,
PPD.PERIOD_END_DATE  AS PERIOD_END_DATE,
PPD.CHECK_DATE,
			-- ETL Fields
					
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
                        
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG,
    0 AS ETL_INFERRED_MEMBER_FLAG
FROM DATE_MAPPING PPD
JOIN DW_${var.SF_ENVIRONMENT}."STAGE".CLEARCARE_DIM_BRANCH BR ON 1=1;
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}

