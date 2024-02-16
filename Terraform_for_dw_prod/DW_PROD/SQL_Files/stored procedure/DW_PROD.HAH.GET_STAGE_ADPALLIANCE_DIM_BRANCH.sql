CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ADPALLIANCE_DIM_BRANCH("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

--*****************************************************************************************************************************
-- NAME: ADPALLIANCE_DIM_BRANCH
--
-- PURPOSE: Creates one row for each BRANCH according to ADP-ALLIANCE
--
-- DEVELOPMENT LOG:
-- DATE				AUTHOR                					NOTES:
-- ----------		--------------------------------		-------------------------------------------------------------------
-- 18/10/2022		Aditya Shukla / Jigar Prajapati			Initial Development
-- 29/05/2023		Shikhar Saxena							Changed the logic to add SOURCE_SYSTEM_TYPE field
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ADPALLIANCE_DIM_BRANCH
WITH BRANCH AS (
SELECT DISTINCT 
	MD5(''ADP'' || ''-'' || NVL(LOCATION_ID, ''UNKNOWN'') || ''-'' || ''ALLIANCE'') AS BRANCH_KEY,
	CASE WHEN LOCATION_ID = ''CORP'' THEN ''CORPORATE''
		WHEN LOCATION_ID = ''GRAND'' THEN ''GRAND RAPIDS''
		ELSE NVL(TRIM("NAME"), ''UNKNOWN'')
	END AS BRANCH_NAME,
	''ADP-ALLIANCE'' AS SYSTEM_CODE,
	18 AS SOURCE_SYSTEM_ID,
	-1 AS OFFICE_NUMBER,
	NVL(LOCATION_ID, ''-1'') AS OFFICE_CODE,
	"NAME" AS OFFICE_NAME,
	NULL AS OFFICE_NAME_ALT,
	NULL AS DEPARTMENT_NAME,
	NULL AS BRANCH_SERVICE_LINE,
	TRUE AS PARENT_FLAG,
	MD5(''ADP'' || ''-'' || LOCATION_ID || ''-'' || ''ALLIANCE'') AS PARENT_BRANCH_KEY,
	NULL AS PARENT_OFFICE_NUMBER,
	LOCATION_ID AS PARENT_OFFICE_CODE,
	STATE_CODE || '' - '' ||  UPPER(TRIM(NAME)) || '' ('' || TRIM(LOCATION_ID) || '')'' AS PARENT_BRANCH_NAME,
	ADDRESS1 AS OFFICE_ADDRESS1,
	ADDRESS2 AS OFFICE_ADDRESS2,
	CITY AS OFFICE_CITY,
	STATE_CODE AS OFFICE_STATE_CODE,
	ZIP AS OFFICE_ZIP,
	PHONENUMBER AS OFFICE_PHONE,
	TOLLFREEPHONE AS OFFICE_TOLL_FREE_PHONE,
	FAX AS OFFICE_FAX,
	STATE_CODE || '' - '' ||  UPPER(TRIM(NAME)) || '' ('' || TRIM(LOCATION_ID) || '')'' AS DETAILED_OFFICE_NAME,
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
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_INSERTED_DATE,
		CURRENT_USER AS ETL_INSERTED_BY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_LAST_UPDATED_DATE,
		CURRENT_USER AS ETL_LAST_UPDATED_BY,
		FALSE AS ETL_DELETED_FLAG,
		FALSE AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_PROD.ADP.VW_ALLIANCE_BRANCH_MAPPING
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

END;
';