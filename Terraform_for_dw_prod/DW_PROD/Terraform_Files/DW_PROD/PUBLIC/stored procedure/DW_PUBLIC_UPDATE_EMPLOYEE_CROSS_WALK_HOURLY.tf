resource "snowflake_procedure" "DW_PUBLIC_UPDATE_EMPLOYEE_CROSS_WALK_HOURLY" {
	name ="UPDATE_EMPLOYEE_CROSS_WALK_HOURLY"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "SQL"

	arguments {
		name = "ENVIRONMENT"
		type = "VARCHAR(10)"
}	

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN 

--*****************************************************************************************************************************
-- NAME:  UPDATE_EMPLOYEE_CROSS_WALK_HOURLY
--
-- PURPOSE: Update WORKDAY_INTERNAL_ID in Employee crosswalk
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 22/09/2023	Ramesh Mokariya/Gaurav			Initial Development
--note --on urgent bases we added ENVIRONMENT param but didnt utilized but we are going utilize this and will update this code
--
--*****************************************************************************************************************************


--
-- *********************************************************************************
-- Step 1: Inserting records into Exception table for which we already have Workday ID assigned to some other Enterprise ID

INSERT INTO DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMPLOYEE_CROSS_WALK_EXCEPTION_WD_ID
(EMPLOYEE_ENTERPRISE_ID, FIRST_NAME,LAST_NAME, WORKDAY_INTERNAL_ID,WORKDAY_ID_OF_MAPPING)
SELECT CW.EMPLOYEE_ENTERPRISE_ID, CW.FIRST_NAME, CW.LAST_NAME, CW.WORKDAY_INTERNAL_ID, MAP.WORKDAY_ID
FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMPLOYEE_CROSS_WALK_E2E_TENANT CW 
JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.WORKDAY_CROSSWALK_E2E_MAPPING AS MAP 
	WHERE CW.EMPLOYEE_ENTERPRISE_ID = MAP.CROSSWALK_EMPLOYEE_ENTERPRISE_ID 
	AND MAP.WORKDAY_ID IN 
		(SELECT DISTINCT MAP.WORKDAY_ID 
		FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMPLOYEE_CROSS_WALK_E2E_TENANT CW 
		JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.WORKDAY_CROSSWALK_E2E_MAPPING MAP 
			ON MAP.WORKDAY_ID = CW.WORKDAY_INTERNAL_ID 
			AND MAP.CROSSWALK_EMPLOYEE_ENTERPRISE_ID <> CW.EMPLOYEE_ENTERPRISE_ID 
		WHERE CW.WORKDAY_INTERNAL_ID in 
			(select distinct WORKDAY_ID from DW_${var.SF_ENVIRONMENT}.INTEGRATION.WORKDAY_CROSSWALK_E2E_MAPPING)
		) 
AND CW.EMPLOYEE_ENTERPRISE_ID||''-''||CW.WORKDAY_INTERNAL_ID||''-''||MAP.WORKDAY_ID
NOT IN 
	(SELECT  EMPLOYEE_ENTERPRISE_ID||''-''||WORKDAY_INTERNAL_ID||''-''||WORKDAY_ID_OF_MAPPING
	FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMPLOYEE_CROSS_WALK_EXCEPTION_WD_ID);


-- *********************************************************************************
-- Step 1.1: Updating Workday_internal_id based on Enterprise ID 

UPDATE DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMPLOYEE_CROSS_WALK_E2E_TENANT  CW
SET CW.WORKDAY_INTERNAL_ID = MAP.WORKDAY_ID,
	CW.ETL_LAST_UPDATED_DATE = CURRENT_TIMESTAMP,
	CW.ETL_LAST_UPDATED_BY = CURRENT_USER
from DW_${var.SF_ENVIRONMENT}.INTEGRATION.WORKDAY_CROSSWALK_MAPPING AS MAP 
WHERE CW.EMPLOYEE_ENTERPRISE_ID = MAP.CROSSWALK_EMPLOYEE_ENTERPRISE_ID 
-- Updating only for NULL Workday ID
AND MAP.CURRENT_RECORDS = TRUE
AND MAP.WORKDAY_ID not in 
	(select distinct WORKDAY_INTERNAL_ID from DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMPLOYEE_CROSS_WALK_E2E_TENANT WHERE WORKDAY_INTERNAL_ID IS NOT NULL)
-- Excluding Exception records
AND CW.EMPLOYEE_ENTERPRISE_ID NOT IN 
	(SELECT EMPLOYEE_ENTERPRISE_ID
	FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMPLOYEE_CROSS_WALK_EXCEPTION_WD_ID);

-- *********************************************************************************
-- Step 2: Inserting Applicants which are new 


INSERT INTO DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMPLOYEE_CROSS_WALK_E2E_TENANT
(EMPLOYEE_ENTERPRISE_ID, WORKDAY_INTERNAL_ID, APPLICANT_EMPLOYEE_ID, APPLICANT_SOURCE_SYSTEM_ID, APPLICANT_SYSTEM_CODE, FIRST_NAME, LAST_NAME, BRANCH_STATE_CODE,APPLICANT_EMPLOYEE_KEY ,
ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG, DUP_FLAG)
SELECT COALESCE((SELECT MAX(EMPLOYEE_ENTERPRISE_ID) FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMPLOYEE_CROSS_WALK_E2E_TENANT),10000000)+ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS EMPLOYEE_ENTERPRISE_ID,
	APPLICANT_ID AS WORKDAY_INTERNAL_ID, 
	APPLICANT_ID AS APPLICANT_EMPLOYEE_ID,
	SOURCE_SYSTEM_ID AS APPLICANT_SOURCE_SYSTEM_ID,
	SYSTEM_CODE AS APPLICANT_SYSTEM_CODE, 
	FIRST_NAME AS FIRST_NAME,
	LAST_NAME AS LAST_NAME,
	STATE_CODE AS BRANCH_STATE_CODE,
	APPLICANT_KEY AS APPLICANT_EMPLOYEE_KEY,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	CURRENT_TIMESTAMP,
    CURRENT_USER,
    CURRENT_TIMESTAMP,
    CURRENT_USER,
	0,
	FALSE
FROM DW_${var.SF_ENVIRONMENT}."STAGE".WORKDAY_DIM_APPLICANT
WHERE NVL(APPLICANT_ID,'''') NOT IN 
	(SELECT DISTINCT NVL(WORKDAY_INTERNAL_ID,'''') 
	FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMPLOYEE_CROSS_WALK_E2E_TENANT)
AND SOURCE_SYSTEM_ID = 36
AND NVL(APPLICANT_KEY,'''') NOT IN 
	(SELECT DISTINCT NVL(APPLICANT_EMPLOYEE_KEY,'''') 
	FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMPLOYEE_CROSS_WALK_E2E_TENANT);
--

-- Step 3:
UPDATE DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMPLOYEE_CROSS_WALK_E2E_TENANT  CW
SET CW.WORKDAY_INTERNAL_ID = MAP.WORKDAY_ID,
	CW.APPLICANT_EMPLOYEE_ID = MAP.PARADOX_ID,
	CW.ETL_LAST_UPDATED_DATE = CURRENT_TIMESTAMP,
	CW.ETL_LAST_UPDATED_BY = CURRENT_USER
FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.APPLICANT_CROSSWALK_E2E_MAPPING AS MAP 
WHERE CW.EMPLOYEE_ENTERPRISE_ID = MAP.CROSSWALK_EMPLOYEE_ENTERPRISE_ID 
AND MAP.CURRENT_RECORDS = TRUE
-- Updating only for NULL Workday ID
AND MAP.WORKDAY_ID not in 
	(select distinct WORKDAY_INTERNAL_ID from DW_${var.SF_ENVIRONMENT}.INTEGRATION.EMPLOYEE_CROSS_WALK_E2E_TENANT WHERE WORKDAY_INTERNAL_ID IS NOT NULL);

-- *********************************************************************************

return ''SUCCEED'';
end;

 EOT
}

