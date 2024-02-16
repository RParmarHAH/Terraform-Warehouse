resource "snowflake_procedure" "DW_HAH_GET_STAGE_CLEARCARE_DIM_SUPERVISOR" {
	name ="GET_STAGE_CLEARCARE_DIM_SUPERVISOR"
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
-- NAME:  Clear care DIM SUPERVISOR
--
-- PURPOSE: Populates Stage Dim SUPERVISOR for Clear Care 
--			
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 08/05/22    SAM HUFF             Initial version
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.CLEARCARE_DIM_SUPERVISOR
SELECT MD5(PP.AGENCY_ID || ''-'' || PP.ID || ''-'' || ''CLEARCARE'') AS SUPERVISOR_KEY
		, PP.ID AS SUPERVISOR_CODE
		, ''CLEARCARE'' AS SYSTEM_CODE
		, 16 AS SOURCE_SYSTEM_ID
		, CONCAT(UPPER(TRIM(PP.LAST_NAME)), '', '' , UPPER(TRIM(PP.FIRST_NAME)) , '' '',NVL(UPPER(TRIM(PP.MIDDLE_NAME)),'''')) AS SUPERVISOR_NAME
		, ''OH'' AS SUPERVISOR_STATE_CODE
		, NULL SUPERVISOR_JOB_CODE
		, NULL SUPERVSIOR_JOB_TITLE
		, TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE
    	, TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
    
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
                        
		, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
    	, CURRENT_USER AS ETL_INSERTED_BY
    	, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
    	, CURRENT_USER AS ETL_LAST_UPDATED_BY
    	, 0 AS ETL_DELETED_FLAG
    	, 0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.CLEARCARE.PROFILE_PATIENT_AGENCYLOCATION PP
WHERE
PP.ID IN (SELECT DISTINCT PRIMARY_MANAGER_ID
FROM DISC_${var.SF_ENVIRONMENT}.CLEARCARE.PROFILE_PATIENT_AGENCYLOCATION) OR
PP.ID IN (SELECT DISTINCT SECONDARY_MANAGER_ID
FROM DISC_${var.SF_ENVIRONMENT}.CLEARCARE.PROFILE_PATIENT_AGENCYLOCATION)
AND PP.AGENCY_ID IN (2459)
UNION SELECT
MD5(-1 || ''-'' || -1 || ''-'' || ''CLEARCARE''), -1, ''CLEARCARE'', 16, ''UNKNOWN'', ''OH'', NULL SUPERVISOR_JOB_CODE, NULL SUPERVISOR_JOB_TITLE, TO_DATE(''1900-01-01'', ''YYYY-MM-DD''), TO_DATE(''9999-12-31'', ''YYYY-MM-DD''), -1, -1, convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz, CURRENT_USER
, convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz, CURRENT_USER, 0, 0;
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}

