resource "snowflake_procedure" "DW_HAH_GET_STAGE_AXXESS_FACT_BRANCH_PAYROLL_PERIODS" {
	name ="GET_STAGE_AXXESS_FACT_BRANCH_PAYROLL_PERIODS"
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
--AXXESS : we pay weekly, our payperiod is Sun thru Saturday , we pay on Fridays
-- NAME:  AXXESS_DIM_BRANCH

-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 06/02/2021	Parag Gajjar			Initial Development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.AXXESS_FACT_BRANCH_PAYROLL_PERIODS

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
WHERE DD.DAY_NAME LIKE ''%Fri%''
AND DD.DATE_KEY >= ''20090625''
)
SELECT 
	MD5( CAST(BR.SOURCE_SYSTEM_ID AS VARCHAR) || BR.SYSTEM_CODE || BR.BRANCH_KEY || CAST( PPD.CHECK_DATE AS VARCHAR)) AS BRANCH_PAYROLL_PERIODS_KEY,
	BR.BRANCH_KEY  AS BRANCH_KEY ,
	BR.OFFICE_STATE_CODE  AS OFFICE_STATE_CODE,
	--BR.OFFICE_NAME AS DETAILED_OFFICE_NAME,
	COALESCE (BR.DETAILED_OFFICE_NAME,''OH - HAH CANTON (-5)'') AS DETAILED_OFFICE_NAME,	--Added on 15/02/23
	PPD.PERIOD_START_DATE  AS PERIOD_START_DATE,
	PPD.PERIOD_END_DATE  AS PERIOD_END_DATE,
	PPD.CHECK_DATE,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
   	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
	CURRENT_USER AS ETL_INSERTED_BY ,
	CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER AS ETL_LAST_UPDATED_BY,
	0 AS ETL_DELETED_FLAG,
	0 AS ETL_INFERRED_MEMBER_FLAG
FROM DATE_MAPPING PPD
JOIN "STAGE".AXXESS_DIM_BRANCH BR ON 1=1
;
RETURN ''SUCCESS'';
end;                        

 EOT
}

