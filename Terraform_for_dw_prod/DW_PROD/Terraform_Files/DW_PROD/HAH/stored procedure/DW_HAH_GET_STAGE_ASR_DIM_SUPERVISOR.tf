resource "snowflake_procedure" "DW_HAH_GET_STAGE_ASR_DIM_SUPERVISOR" {
	name ="GET_STAGE_ASR_DIM_SUPERVISOR"
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
    return_result varchar(1000);
BEGIN

--*****************************************************************************************************************************
-- NAME:  ASR_DIM_SUPERVISOR
--
-- PURPOSE: Creates one row per supervisor according to ASR
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 12/29/2021	Jay Prajapati			Initial Development
-- 04/04/2022	Abhishek Sunil			Revised logic
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ASR_DIM_SUPERVISOR
WITH CLEANED_SUPERVISORS AS (
	SELECT 
		SUPERVISORID, 
		IFF(SUPERVISORID IN (164,165),''Oksana Aminov'',SUPERVISORNAME) AS SUPERVISORNAME -- This supervisor didnt UPDATE IN ASR, so added logic here wrt mail from Anastasiya 
	FROM DISC_${var.SF_ENVIRONMENT}.ASR.ASR_SUPERVISORS
)
SELECT
	MD5(''PRIME'' || ''-'' || TRIM(S.SUPERVISORID) || ''-'' || ''ASR'') AS SUPERVISOR_KEY, 
	TRIM(S.SUPERVISORID) AS SUPERVISOR_CODE,
	''PRIME'' AS SYSTEM_CODE,
	13 AS SOURCE_SYSTEM_ID,
	UPPER(TRIM(S.SUPERVISORNAME)) AS SUPERVISOR_NAME, 
	''OH'' AS SUPERVISOR_STATE_CODE, 
	NULL SUPERVISOR_JOB_CODE,
	NULL SUPERVISOR_JOB_TITLE,
	TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
	TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	 CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
	,CURRENT_USER AS ETL_INSERTED_BY
	,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_UPDATED_DATE
	,CURRENT_USER AS ETL_LAST_UPDATED_BY
	,FALSE as ETL_DELETED_FLAG
	,FALSE as ETL_INFERRED_MEMBER_FLAG
FROM CLEANED_SUPERVISORS S
ORDER BY SUPERVISOR_CODE ASC;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

