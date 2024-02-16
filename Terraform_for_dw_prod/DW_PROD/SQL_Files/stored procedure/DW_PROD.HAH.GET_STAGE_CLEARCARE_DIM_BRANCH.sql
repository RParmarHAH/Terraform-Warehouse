CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_CLEARCARE_DIM_BRANCH("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
--*****************************************************************************************************************************
-- NAME:  Clear care DIM Branch
--
-- PURPOSE: Populates Stage Dim Branch for Clear Care 
--			
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- 08/05/22    Ayshwarya             Initial version
-- 10/25/22    Sam                   Using branches instead of agencies
-- 05/29/23	   Shikhar Saxena		 Changd the logic to add SOURCE_SYSTEM_TYPE field
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.CLEARCARE_DIM_BRANCH
WITH CLEARCAREBRANCH AS (
	SELECT MD5( AGENCY.AGENCY_ID || ''-'' || AGENCY.NAME || ''-'' || ''CLEARCARE'') AS BRANCH_KEY,
		 UPPER(AGENCY.NAME) AS BRANCH_NAME,
		''CLEARCARE'' AS SYSTEM_CODE,
		16 AS SOURCE_SYSTEM_ID,
		-1 AS OFFICE_CODE,
		AGENCY.ID AS OFFICE_NUMBER,
 		UPPER(AGENCY.NAME) AS OFFICE_NAME,
		UPPER(AGENCY.NAME) AS OFFICE_NAME_ALT,
 		NULL AS OFFICE_ADDRESS1, 
		NULL AS OFFICE_ADDRESS2,
		NULL AS OFFICE_CITY,
		''OH'' AS OFFICE_STATE_CODE ,
		NULL AS OFFICE_ZIP,
		NULL AS OFFICE_PHONE,
		NULL AS OFFICE_FAX,
		NULL AS PRIMARY_BRANCH_MANAGER_NAME,
		NULL AS PRIMARY_BRANCH_EMAIL
FROM DISC_PROD.CLEARCARE.AGENCY_AGENCYLOCATION AGENCY
WHERE AGENCY.AGENCY_ID IN (2459)
),  RISKCONNECT_HIERARCHY AS (
	SELECT * FROM DISC_PROD.STAGE.RISKCONNECT_HIERARCHY
), HR_OFFICE_MAPPING AS (
	SELECT * FROM DISC_PROD.STAGE.HR_OFFICE_MAPPING
), HAH_OFFICES AS (
	SELECT UPPER(TRIM(OFFICES.STATE)) AS STATE,
		TRY_CAST(OFFICES.OFFICENUMBER AS INT) AS OFFICE_NUMBER,
		OFFICES.OFFICENAME AS OFFICE_NAME,
		CASE WHEN OFFICES.OFFICENAME LIKE ''%DD%'' THEN ''DD''
			WHEN OFFICES.OFFICENAME LIKE ''%ADS%'' THEN ''ADS''
		END AS BRANCH_SERVICE_LINE,
		OFFICES.TOLLFREE AS OFFICE_TOLL_FREE_PHONE,
		OFFICES.FAX AS OFFICE_FAX,
		TRIM( OFFICES.Email) AS Primary_Branch_Email,
		CAST(NULL AS VARCHAR(10)) AS Secondary_Branch_Email,
		OFFICES.OFFICEMANAGER AS OFFICEMANAGER1, --check default coordinator id
		CAST(NULL AS VARCHAR(10)) AS OFFICEMANAGER2,
		OFFICES.DATECREATED AS DATE_CREATED,
		OFFICES.ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.HAHUSERS.LOGIN_OFFICE AS OFFICES
    WHERE TRY_CAST(OFFICES.OFFICENUMBER AS INT) IS NOT NULL
) 
SELECT CLEARCARE_BRANCH.BRANCH_KEY, 
        CLEARCARE_BRANCH.BRANCH_NAME, 
      	CLEARCARE_BRANCH.SYSTEM_CODE, 
       	CLEARCARE_BRANCH.SOURCE_SYSTEM_ID,
		SOURCE_SYSTEM.SOURCE_SYSTEM_TYPE,
		CLEARCARE_BRANCH.OFFICE_NUMBER AS OFFICE_NUMBER, 
        CLEARCARE_BRANCH.OFFICE_CODE, 
		CLEARCARE_BRANCH.OFFICE_NAME, 
        CLEARCARE_BRANCH.OFFICE_NAME AS OFFICE_NAME_ALT,
		NULL AS DEPARTMENT_NAME,
        NULL AS BRANCH_SERVICE_LINE,
		TRUE AS PARENT_FLAG,
		CLEARCARE_BRANCH.BRANCH_KEY AS PARENT_BRANCH_KEY,
		CLEARCARE_BRANCH.OFFICE_NUMBER AS PARENT_OFFICE_NUMBER,
		CLEARCARE_BRANCH.OFFICE_CODE AS PARENT_OFFICE_CODE,
		''OH'' || '' - '' ||  CLEARCARE_BRANCH.OFFICE_NAME || '' - '' || CLEARCARE_BRANCH.OFFICE_NUMBER AS PARENT_BRANCH_NAME,
		CLEARCARE_BRANCH.OFFICE_ADDRESS1,
		CLEARCARE_BRANCH.OFFICE_ADDRESS2,
		CLEARCARE_BRANCH.OFFICE_CITY,
		COALESCE(HAH_OFFICES.STATE, CLEARCARE_BRANCH.OFFICE_STATE_CODE) AS OFFICE_STATE_CODE,
		CLEARCARE_BRANCH.OFFICE_ZIP,
		CLEARCARE_BRANCH.OFFICE_PHONE,
	  	NULL AS OFFICE_TOLL_FREE_PHONE,
		CLEARCARE_BRANCH.OFFICE_FAX,
		''OH'' || '' - '' ||  CLEARCARE_BRANCH.OFFICE_NAME || '' - '' || CLEARCARE_BRANCH.OFFICE_NUMBER AS DETAILED_OFFICE_NAME,
		REGIONS.REGIONNUMBER AS REGION_NUMBER,
		UPPER(TRIM(REGIONS.NAME)) AS REGION_NAME,
		UPPER(TRIM(REGIONS.MANAGER)) AS REGION_MANAGER,
		NULL AS REGION_MANAGER_EMPLOYEE_KEY,
		NULL AS SUBREGION_NAME,
		CLEARCARE_BRANCH.PRIMARY_BRANCH_MANAGER_NAME AS Primary_Branch_Manager_Name,
		CLEARCARE_BRANCH.PRIMARY_BRANCH_EMAIL AS PRIMARY_BRANCH_EMAIL,
		NULL AS PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY,
		UPPER(TRIM(HAH_OFFICES.OfficeManager2)) AS Secondary_Branch_Manager_Name,
		TRIM(HAH_OFFICES.SECONDARY_BRANCH_EMAIL) AS SECONDARY_BRANCH_EMAIL,
		NULL AS SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY,
		RISKCONNECT.NODE_KEY AS RISKCONNECT_NODE_KEY,
		RISKCONNECT.NODE_NAME AS RISKCONNECT_NAME,
		NULL AS HR_OFFICE_NUMBER,
		NULL AS HR_OFFICE_NAME,
		TRUE AS ACTIVE_FLAG,
	TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
     TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
     
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
                        
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG,
    0 AS ETL_INFERRED_MEMBER_FLAG
	FROM CLEARCAREBRANCH AS CLEARCARE_BRANCH
    LEFT JOIN HAH_OFFICES AS HAH_OFFICES
		ON HAH_OFFICES.STATE = CLEARCARE_BRANCH.OFFICE_STATE_CODE AND CLEARCARE_BRANCH.OFFICE_NUMBER = HAH_OFFICES.OFFICE_NUMBER
    LEFT JOIN HAH.DIM_STATE AS STATES 
		ON STATES.STATE_ISO_CODE = CLEARCARE_BRANCH.OFFICE_STATE_CODE
    LEFT OUTER JOIN RISKCONNECT_HIERARCHY AS RISKCONNECT
		ON RISKCONNECT.STATE = CLEARCARE_BRANCH.OFFICE_STATE_CODE
	LEFT OUTER JOIN HR_OFFICE_MAPPING AS HR
		ON TRIM(HR.OFFICE_CODE) = TRIM(CLEARCARE_BRANCH.OFFICE_CODE) AND TRIM(HR.STATE) = CLEARCARE_BRANCH.OFFICE_STATE_CODE
	LEFT JOIN DISC_PROD.HAH_REPORTING.KEYMETOFFICES AS REGION_OFFICES
		ON TRIM(REGION_OFFICES.OFFICESTATE) = CLEARCARE_BRANCH.OFFICE_STATE_CODE AND TRY_CAST(REGION_OFFICES.OFFICENUMBER AS INT) = CLEARCARE_BRANCH.OFFICE_NUMBER 
    LEFT JOIN DISC_PROD.BI_REPOSITORY.KMREGIONS AS REGIONS
		ON (REGION_OFFICES.REGIONNUMBER IS NULL AND 
			CASE WHEN UPPER(STATES.STATE_NAME) = ''GEORGIA'' THEN ''GEORGIA/SOUTH CAROLINA''
				WHEN UPPER(STATES.STATE_NAME) = ''SOUTH CAROLINA'' THEN ''GEORGIA/SOUTH CAROLINA''
				WHEN UPPER(STATES.STATE_NAME) = ''MICHIGAN'' THEN ''DD/MICHIG''
				WHEN UPPER(STATES.STATE_NAME) = ''KANSAS'' THEN ''MISSOURI'' 
				WHEN UPPER(STATES.STATE_NAME) = ''IOWA'' THEN ''ILLINOIS - NORTH'' 
				WHEN UPPER(STATES.STATE_NAME) = ''MISSISSIPPI'' THEN ''MISSISSIPPI/TENNESSEE''
				WHEN UPPER(STATES.STATE_NAME) = ''TENNESSEE'' THEN ''MISSISSIPPI/TENNESSEE''
				ELSE UPPER(STATES.STATE_NAME) END = REGIONS.NAME) 
			OR (REGION_OFFICES.REGIONNUMBER = REGIONS.REGIONNUMBER)
			LEFT JOIN HAH.DIM_SOURCE_SYSTEM AS SOURCE_SYSTEM ON CLEARCARE_BRANCH.SOURCE_SYSTEM_ID = SOURCE_SYSTEM.SOURCE_SYSTEM_ID;
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    ';