resource "snowflake_procedure" "DW_HAH_GET_STAGE_COSTALSYNCDATA_DIM_SUPERVISOR" {
	name ="GET_STAGE_COSTALSYNCDATA_DIM_SUPERVISOR"
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
-- NAME:  CostalSyncData_DIM_SUPERVISOR
--
-- PURPOSE: Creates one row per supervisor according to CoastalSnyc (combination of SHC_ALTRUS and SHC_SAVANNAH)
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 01/06/20     Greg Marsh           Initial development
-- 03/18/20     Frank Noordover      Updated for Production rollout
-- 06/05/20		Mir Ali				 Added DB as part of join clause
-- 07/30/20		Mir Ali				 Updated to use raw CV table
--*****************************************************************************************************************************
-- 
INSERT OVERWRITE INTO STAGE.COSTALSYNCDATA_DIM_SUPERVISOR
WITH SC_CLIENT_SUPERVISORS AS (
	SELECT VISIT.SYSTEM_CODE AS DB, VISIT.SUPERVISOR_CODE AS DEPARTMENT__CODE, MAX(VISIT.ETL_LAST_UPDATED_DATE) ETL_LAST_UPDATED_DATE
	FROM HAH.FACT_VISIT VISIT
	JOIN HAH.DIM_BRANCH BRANCH
		ON BRANCH.BRANCH_KEY = VISIT.BRANCH_KEY
	WHERE VISIT.CONFIRMED_FLAG = ''YES''
	--VISIT.STATUS_CODE IN (''02'', ''03'', ''04'', ''05'')
	
	GROUP BY VISIT.SYSTEM_CODE, VISIT.SUPERVISOR_CODE
	-- Supervisor should have served SC client within last 3 months of their last service record
	HAVING DATE_TRUNC(MONTH, MAX(CASE WHEN BRANCH.OFFICE_STATE_CODE = ''SC'' THEN VISIT.REPORT_DATE END)) >= DATE_TRUNC(MONTH, DATEADD(MONTH, -3, MAX(VISIT.REPORT_DATE))) 
), SUPERVISORS AS (
	SELECT TRIM(DEPARTMENTS.DB) AS DB,
		TRIM(NVL(DEPARTMENTS.DEPARTMENT__CODE, '''')) AS SUPERVISOR_CODE,
		TRIM(NVL(DEPARTMENTS.DEPARTMENT_NAME, ''Unknown'')) AS SUPERVISOR_NAME,
		IFF(SC_CLIENT_SUPERVISORS.DB IS NOT NULL, ''SC'', ''GA'') AS SUPERVISOR_STATE_CODE,
		TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
		TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_DEPARTMENTS AS DEPARTMENTS
	LEFT JOIN SC_CLIENT_SUPERVISORS AS SC_CLIENT_SUPERVISORS
		ON SC_CLIENT_SUPERVISORS.DB = TRIM(DEPARTMENTS.DB) AND SC_CLIENT_SUPERVISORS.DEPARTMENT__CODE = TRIM(DEPARTMENTS.DEPARTMENT__CODE)
	WHERE (DEPARTMENTS.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::timestamp_ntz 
    OR SC_CLIENT_SUPERVISORS.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::timestamp_ntz)
)
SELECT
	MD5(SUPERVISORS.DB || ''-'' || SUPERVISORS.SUPERVISOR_CODE || ''-'' || ''COSTALSYNCDATA'') AS SUPERVISOR_KEY, --PK
	SUPERVISORS.SUPERVISOR_CODE,
	SUPERVISORS.DB AS SYSTEM_CODE,
	CASE SUPERVISORS.DB WHEN ''SHC_ALTRUS'' THEN 1 WHEN ''SHC_SAVANNAH'' THEN 2 END AS SOURCE_SYSTEM_ID,
	SUPERVISORS.SUPERVISOR_NAME,
	NULL SUPERVISOR_JOB_CODE,
	NULL SUPERVISOR_JOB_TITLE,
	SUPERVISORS.SUPERVISOR_STATE_CODE,
	SUPERVISORS.EFFECTIVE_FROM_DATE,
	SUPERVISORS.EFFECTIVE_TO_DATE,
	-- ETL Fields
    
   :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
   :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
   
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG,
    0 as ETL_INFERRED_MEMBER_FLAG
FROM SUPERVISORS AS SUPERVISORS;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

