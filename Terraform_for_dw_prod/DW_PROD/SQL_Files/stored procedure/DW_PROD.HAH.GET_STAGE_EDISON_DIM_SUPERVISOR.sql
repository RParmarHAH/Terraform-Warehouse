CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_EDISON_DIM_SUPERVISOR("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
--*****************************************************************************************************************************
-- NAME:  EDISON_DIM_SUPERVISOR
--
-- PURPOSE: Creates one row per supervisor according to EDISON 
--
-- DEVELOPMENT LOG:
-- DATE        	AUTHOR                	NOTES:
-- --------    	-------------------   	-----------------------------------------------------------------------------------------------
-- 04/26/2022   Mohit Vaghadiya			Initial development
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.EDISON_DIM_SUPERVISOR
SELECT MD5(''EDISON'' || ''-'' || SUP.AGENCYID || ''-'' || SUP.COORDINATORID || ''-'' || ''EDISON'') AS SUPERVISOR_KEY
		, SUP.COORDINATORID AS SUPERVISOR_CODE
		, ''EDISON'' AS SYSTEM_CODE
		, 17 AS SOURCE_SYSTEM_ID
		, SUP.COORDINATORNAME AS SUPERVISOR_NAME
		, ''NY'' AS SUPERVISOR_STATE_CODE
		, NULL SUPERVISOR_JOB_CODE
		, NULL SUPERVISOR_JOB_TITLE
		, TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE
    	, TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
		-- ETL Fields
    	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
		, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
    	, CURRENT_USER AS ETL_INSERTED_BY
    	, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
    	, CURRENT_USER AS ETL_LAST_UPDATED_BY
    	, SUP.DELETED AS ETL_DELETED_FLAG
    	, 0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_PROD.HHAEXCHANGEEDISON.TBLCOORDINATOR_REPL SUP
WHERE AGENCYID  = 155 ;
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    ';