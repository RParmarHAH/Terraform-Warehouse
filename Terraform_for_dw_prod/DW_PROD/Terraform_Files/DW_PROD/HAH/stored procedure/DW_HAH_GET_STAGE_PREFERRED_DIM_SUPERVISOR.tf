resource "snowflake_procedure" "DW_HAH_GET_STAGE_PREFERRED_DIM_SUPERVISOR" {
	name ="GET_STAGE_PREFERRED_DIM_SUPERVISOR"
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
-- NAME:  PREFERRED_DIM_SUPERVISOR
--
-- PURPOSE: Creates one row per supervisor according to PREFERRED 
--
-- DEVELOPMENT LOG:
-- DATE        	AUTHOR                	NOTES:
-- --------    	-------------------   	-----------------------------------------------------------------------------------------------
-- 04/26/2022   Mohit Vaghadiya			Initial development
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.PREFERRED_DIM_SUPERVISOR
SELECT MD5(''PREFERRED'' || ''-'' || SUP.AGENCYID || ''-'' || SUP.COORDINATORID || ''-'' || ''PREFERRED'') AS SUPERVISOR_KEY
		, SUP.COORDINATORID AS SUPERVISOR_CODE
		, ''PREFERRED'' AS SYSTEM_CODE
		, 17 AS SOURCE_SYSTEM_ID
		, SUP.COORDINATORNAME AS SUPERVISOR_NAME
		, ''NY'' AS SUPERVISOR_STATE_CODE
		, NULL SUPERVISOR_JOB_CODE
		, NULL SUPERVISOR_JOB_TITLE
		, TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE
    	, TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
		-- ETL Fields

        :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,

		  CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
    	, CURRENT_USER AS ETL_INSERTED_BY
    	, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
    	, CURRENT_USER AS ETL_LAST_UPDATED_BY
    	, SUP.DELETED AS ETL_DELETED_FLAG
    	, 0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.TBLCOORDINATOR_REPL SUP
INNER JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.AGENCY_MAPPING AGENCY_CONFIG
	ON AGENCY_CONFIG.AGENCYID = SUP.AGENCYID
		AND AGENCY_CONFIG.ISACTIVE = TRUE
WHERE NVL(SUP.DELETED, 0) != 1 ;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

