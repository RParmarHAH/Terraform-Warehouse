CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ALLIANCE_DIM_BRANCH("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS 'BEGIN
--*****************************************************************************************************************************
-- NAME:  ALLIANCE_DIM_BRANCH
--
-- PURPOSE: Creates one row per branch according to GENERATIONS ALLIANCE
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 29/07/2022	Mirisha Jarecha			Initial Development
-- 22/08/2022	Abhishek Sunil			Added New Logic
-- 29/05/2023	Shikhar Saxena			Changed the logic to add SOURCE_SYSTEM_TYPE field
-- 10/10/2023	Mohit Vaghadiya			Fixed the Parent Branch Key Issue - IDDOX-459
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.ALLIANCE_DIM_BRANCH
WITH BRANCH AS(
SELECT
	MD5(''ALLIANCE'' || ''-'' || TRIM(BM.LOCATION_ID) || ''-'' || ''GENERATIONS'') AS BRANCH_KEY,
	COALESCE(UPPER(TRIM(BM.NAME)),BM.LOCATION_ID) AS BRANCH_NAME,
	''ALLIANCE'' AS SYSTEM_CODE,
	19 AS SOURCE_SYSTEM_ID,
	1 AS OFFICE_NUMBER, -- TO be filled out/need to confirm
	TRIM(BM.LOCATION_ID) AS OFFICE_CODE,
	UPPER(TRIM(BM.NAME)) AS OFFICE_NAME,
	UPPER(TRIM(BM.NAME)) AS OFFICE_NAME_ALT,
	NULL AS DEPARTMENT_NAME,
	NULL AS BRANCH_SERVICE_LINE,
	BM.PARENT_FLAG AS PARENT_FLAG,
	CASE WHEN BM.PARENT_FLAG=''TRUE'' THEN MD5(''ALLIANCE'' || ''-'' || TRIM(BM.LOCATION_ID) || ''-'' || ''GENERATIONS'') 
         WHEN BM.PARENT_FLAG=''FALSE'' THEN MD5(''ALLIANCE'' || ''-'' || TRIM(BM.PARENT_BRANCH_CODE) || ''-'' || ''GENERATIONS'')
    ELSE NULL END AS PARENT_BRANCH_KEY,
	NULL AS PARENT_OFFICE_NUMBER, -- TO be filled out
	CASE WHEN BM.PARENT_FLAG=''TRUE'' 
			THEN TRIM(BM.LOCATION_ID)
		 WHEN BM.PARENT_FLAG=''FALSE''
		 	THEN TRIM(BM.PARENT_BRANCH_CODE)
	END PARENT_OFFICE_CODE,
	CASE WHEN BM.PARENT_FLAG=''TRUE'' 
			THEN NVL(BM.STATE_CODE, ''MI'') || '' - '' ||  UPPER(TRIM(BM.NAME)) || '' ('' || TRIM(BM.LOCATION_ID) || '')''
		 WHEN BM.PARENT_FLAG=''FALSE''
		 	THEN NVL(BM.STATE_CODE, ''MI'') || '' - '' ||  UPPER(TRIM(BM.PARENT_BRANCH_NAME)) || '' ('' || TRIM(BM.PARENT_BRANCH_CODE) || '')''
	END PARENT_BRANCH_NAME,
	TRIM(BM.ADDRESS1) AS OFFICE_ADDRESS1,
	TRIM(BM.ADDRESS2) AS OFFICE_ADDRESS2,
	INITCAP(TRIM(BM.CITY)) AS OFFICE_CITY,
	UPPER(TRIM(NVL(BM.STATE_CODE, ''MI''))) AS OFFICE_STATE_CODE,
	BM.ZIP AS OFFICE_ZIP,
	BM.PHONENUMBER AS OFFICE_PHONE,
	BM.TOLLFREEPHONE AS OFFICE_TOLL_FREE_PHONE,
	BM.FAX AS OFFICE_FAX,
	NVL(BM.STATE_CODE, ''MI'') || '' - '' ||  UPPER(TRIM(BM.NAME)) || '' ('' || TRIM(BM.LOCATION_ID) || '')'' AS DETAILED_OFFICE_NAME,
	NULL AS REGION_NUMBER,
	NULL AS REGION_NAME,
	NULL AS REGION_MANAGER,
	NULL AS REGION_MANAGER_EMPLOYEE_KEY,
	NULL AS SUBREGION_NAME,
	NULL AS PRIMARY_BRANCH_MANAGER_NAME,
	NULL AS PRIMARY_BRANCH_EMAIL, 
	NULL AS PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY,
	NULL AS SECONDARY_BRANCH_MANAGER_NAME,
	NULL AS SECONDARY_BRANCH_EMAIL,
	NULL AS SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY,
	NULL AS RISKCONNECT_NODE_KEY,
	NULL AS RISKCONNECT_NAME,
	NULL AS HR_OFFICE_NUMBER,
	NULL AS HR_OFFICE_NAME,
	TRUE AS ACTIVE_FLAG,
    TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
	TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
	CURRENT_USER AS ETL_INSERTED_BY,
	CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER AS ETL_LAST_UPDATED_BY,
	FALSE AS ETL_DELETED_FLAG,
	FALSE AS ETL_INFERRED_MEMBER_FLAG
FROM 
	DISC_PROD.GENERATIONSALLIANCE.VW_BRANCH_MAPPING BM
)
SELECT BRANCH.BRANCH_KEY,
BRANCH.BRANCH_NAME,
BRANCH.SYSTEM_CODE,
BRANCH.SOURCE_SYSTEM_ID,
SOURCE_SYSTEM.SOURCE_SYSTEM_TYPE,
BRANCH.OFFICE_NUMBER,
BRANCH.OFFICE_CODE,
BRANCH.OFFICE_NAME,
BRANCH.OFFICE_NAME_ALT,
BRANCH.DEPARTMENT_NAME,
BRANCH.BRANCH_SERVICE_LINE,
BRANCH.PARENT_FLAG,
BRANCH.PARENT_BRANCH_KEY,
BRANCH.PARENT_OFFICE_NUMBER,
BRANCH.PARENT_OFFICE_CODE,
BRANCH.PARENT_BRANCH_NAME,
BRANCH.OFFICE_ADDRESS1,
BRANCH.OFFICE_ADDRESS2,
BRANCH.OFFICE_CITY,
BRANCH.OFFICE_STATE_CODE,
BRANCH.OFFICE_ZIP,
BRANCH.OFFICE_PHONE,
BRANCH.OFFICE_TOLL_FREE_PHONE,
BRANCH.OFFICE_FAX,
BRANCH.DETAILED_OFFICE_NAME,
BRANCH.REGION_NUMBER,
BRANCH.REGION_NAME,
BRANCH.REGION_MANAGER,
BRANCH.REGION_MANAGER_EMPLOYEE_KEY,
BRANCH.SUBREGION_NAME,
BRANCH.PRIMARY_BRANCH_MANAGER_NAME,
BRANCH.PRIMARY_BRANCH_EMAIL,
BRANCH.PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY,
BRANCH.SECONDARY_BRANCH_MANAGER_NAME,
BRANCH.SECONDARY_BRANCH_EMAIL,
BRANCH.SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY,
BRANCH.RISKCONNECT_NODE_KEY,
BRANCH.RISKCONNECT_NAME,
BRANCH.HR_OFFICE_NUMBER,
BRANCH.HR_OFFICE_NAME,
BRANCH.ACTIVE_FLAG,
BRANCH.EFFECTIVE_FROM_DATE,
BRANCH.EFFECTIVE_TO_DATE,
BRANCH.ETL_TASK_KEY,
BRANCH.ETL_INSERTED_TASK_KEY,
BRANCH.ETL_INSERTED_DATE,
BRANCH.ETL_INSERTED_BY,
BRANCH.ETL_LAST_UPDATED_DATE,
BRANCH.ETL_LAST_UPDATED_BY,
BRANCH.ETL_DELETED_FLAG,
BRANCH.ETL_INFERRED_MEMBER_FLAG
FROM BRANCH 
LEFT JOIN HAH.DIM_SOURCE_SYSTEM AS SOURCE_SYSTEM ON BRANCH.SOURCE_SYSTEM_ID = SOURCE_SYSTEM.SOURCE_SYSTEM_ID;
RETURN ''SUCCESS'';
END';