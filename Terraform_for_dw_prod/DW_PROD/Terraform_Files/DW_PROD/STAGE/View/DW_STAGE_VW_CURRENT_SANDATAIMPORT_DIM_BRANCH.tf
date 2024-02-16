resource "snowflake_view" "DW_STAGE_VW_CURRENT_SANDATAIMPORT_DIM_BRANCH" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_SANDATAIMPORT_DIM_BRANCH"
	statement = <<-SQL
	 WITH RISKCONNECT_HIERARCHY AS (
	SELECT *
	FROM (
		SELECT *, COUNT(*) OVER(PARTITION BY STATE, OFFICE_NUMBER) AS COUNT_OF_ROWS
		FROM DISC_${var.SF_ENVIRONMENT}.STAGE.RISKCONNECT_HIERARCHY 
		WHERE PARENT_LEVEL = 2
	) L
	WHERE L.COUNT_OF_ROWS = 1
), HR_OFFICE_MAPPING AS (
	SELECT *
	FROM (
		SELECT *, COUNT(*) OVER (PARTITION BY STATE, OFFICE_NUMBER) AS COUNT_OF_ROWS
		FROM DISC_${var.SF_ENVIRONMENT}.STAGE.HR_OFFICE_MAPPING 
	) L
	WHERE L.COUNT_OF_ROWS = 1
), HAH_OFFICES AS (
	SELECT OFFICES.STATE,
		TRY_CAST(OFFICES.OFFICENUMBER AS INT) AS OFFICE_NUMBER,
		OFFICES.OFFICENAME AS OFFICE_NAME,
		OFFICES.ADDRESS AS OFFICE_ADDRESS1,
		OFFICES.ADDRESS2 AS OFFICE_ADDRESS2,
		OFFICES.CITY AS OFFICE_CITY,
		OFFICES.ZIP AS OFFICE_ZIP,
		OFFICES.PHONE AS OFFICE_PHONE,
		OFFICES.TOLLFREE AS OFFICE_TOLL_FREE_PHONE,
		OFFICES.FAX AS OFFICE_FAX,
		OFFICES.GP_DB,
		TRIM( OFFICES.Email) AS Primary_Branch_Email,
		CAST(NULL AS VARCHAR(10)) AS Secondary_Branch_Email,
		OFFICES.OFFICEMANAGER AS OFFICEMANAGER1,
		CAST(NULL AS VARCHAR(10)) AS OFFICEMANAGER2,
		OFFICES.ETL_LAST_UPDATED_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.HAHUSERS.LOGIN_OFFICE AS OFFICES
	WHERE TRY_CAST(OFFICES.OFFICENUMBER AS INT) IS NOT NULL
		AND OFFICES.STATE = 'PA'
), OFFICE_LIST AS (
	SELECT *
	FROM (
		SELECT 4 AS SOURCE_SYSTEM_ID, SANDATA_LOCATIONS.AGENCYID AS SYSTEM_CODE, SANDATA_LOCATIONS.LOCATIONID AS OFFICECODE,
			COALESCE(MAPPING.STATE, 'PA') AS STATE, COALESCE(MAPPING.OFFICE_NUMBER, -1) AS OFFICENUMBER,
			UPPER(COALESCE(MAPPING.OFFICE_NAME, OFFICES.OFFICE_NAME, SANDATA_LOCATIONS.LOCNAME)) AS OFFICENAME,
			ROW_NUMBER() OVER (PARTITION BY SANDATA_LOCATIONS.AGENCYID, UPPER(SANDATA_LOCATIONS.LOCNAME) ORDER BY IFF(MAPPING.OFFICE_NUMBER IS NOT NULL, 0, 1)) AS ROW_NUM,
			GREATEST(COALESCE(SANDATA_LOCATIONS.ETL_LAST_UPDATED_DATE, '1/1/1900'), COALESCE(MAPPING.ETL_LAST_UPDATED_DATE, '1/1/1900'), COALESCE(OFFICES.ETL_LAST_UPDATED_DATE, '1/1/1900')) AS ETL_LAST_UPDATED_DATE 
		FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_LOCATIONS AS SANDATA_LOCATIONS 
		LEFT JOIN (
			SELECT CASE DBNAME 
					WHEN 'IL' THEN '8380' 
					WHEN 'IN' THEN '38004'
					WHEN 'MO' THEN '8463'
					WHEN 'PA' THEN '8485'
					END AS AGENCYID,
				TRIM(DBNAME) AS STATE, 
				LOCSYS AS OFFICE_NUMBER, 
				TRIM(EXTID) AS LOCATIONID,
				TRIM(LSTNAM) AS OFFICE_NAME, ETL_LAST_UPDATED_DATE 
			FROM DISC_${var.SF_ENVIRONMENT}.BI_REPOSITORY.EXTERNALIDS 
			WHERE TYP = 'L'
		) AS MAPPING
			ON MAPPING.AGENCYID = SANDATA_LOCATIONS.AGENCYID AND MAPPING.LOCATIONID = SANDATA_LOCATIONS.LOCATIONID
		LEFT JOIN HAH_OFFICES AS OFFICES
			ON OFFICES.STATE = MAPPING.STATE AND OFFICES.OFFICE_NUMBER = MAPPING.OFFICE_NUMBER
		WHERE SANDATA_LOCATIONS.AGENCYID = '8485'
	) AS LIST
	WHERE LIST.ROW_NUM = 1
), OFFICES AS (
	SELECT MD5(OFFICES.SYSTEM_CODE || '-' || OFFICES.OFFICECODE || '-' || 'SANDATAIMPORT') AS BRANCH_KEY,
		OFFICES.OFFICENAME AS BRANCH_NAME,
		OFFICES.SYSTEM_CODE,
		OFFICES.SOURCE_SYSTEM_ID,
		OFFICES.OFFICENUMBER AS OFFICE_NUMBER,
		OFFICES.OFFICECODE AS OFFICE_CODE,
		OFFICES.OFFICENAME AS OFFICE_NAME,
		UPPER(OFFICES.OFFICENAME) AS OFFICE_NAME_ALT,
		OFFICES.OFFICENAME AS DEPARTMENT_NAME,
		CASE WHEN OFFICES.OFFICENAME LIKE '%DD%' THEN 'DD'
			WHEN OFFICES.OFFICENAME LIKE '%ADS%' THEN 'ADS'
			ELSE NULL END AS BRANCH_SERVICE_LINE,
		TRUE AS PARENT_FLAG,
		BRANCH_KEY AS PARENT_BRANCH_KEY,
		OFFICES.OFFICENUMBER AS PARENT_OFFICE_NUMBER,
		OFFICES.OFFICECODE AS PARENT_OFFICE_CODE,
		OFFICES.STATE || ' - ' || OFFICES.OFFICENAME || ' (' || OFFICES.OFFICENUMBER || ')' AS PARENT_BRANCH_NAME,
		HAH_OFFICES.OFFICE_ADDRESS1,
		HAH_OFFICES.OFFICE_ADDRESS2,
		HAH_OFFICES.OFFICE_CITY,
		OFFICES.STATE AS OFFICE_STATE_CODE,
		HAH_OFFICES.OFFICE_ZIP,
		HAH_OFFICES.OFFICE_PHONE,
		HAH_OFFICES.OFFICE_TOLL_FREE_PHONE,
		HAH_OFFICES.OFFICE_FAX,
		OFFICES.STATE || ' - ' || OFFICES.OFFICENAME || ' (' || OFFICES.OFFICENUMBER || ')' AS DETAILED_OFFICE_NAME,
		REGIONS.REGIONNUMBER AS REGION_NUMBER,
		IFF(UPPER(TRIM(REGIONS.NAME)) = 'DD/MICHIGAN', 'MICHIGAN', UPPER(TRIM(REGIONS.NAME))) AS REGION_NAME,
		UPPER(TRIM(COALESCE(REGIONAL_EMPLOYEE.EMPLOYEE_FIRST_NAME || ' ' || REGIONAL_EMPLOYEE.EMPLOYEE_LAST_NAME, REGIONS.MANAGER))) AS REGION_MANAGER, -- Do we select the name in SQL Server, or concat name from Dim_Employee
		REGIONAL_EMPLOYEE.EMPLOYEE_KEY AS REGION_MANAGER_EMPLOYEE_KEY,
		CAST(NULL AS VARCHAR) AS SUBREGION_NAME,
		UPPER(TRIM(COALESCE(PRIMARY_MANAGER.EMPLOYEE_FIRST_NAME || ' ' || PRIMARY_MANAGER.EMPLOYEE_LAST_NAME, HAH_OFFICES.OfficeManager1))) AS Primary_Branch_Manager_Name,
		COALESCE(BRANCH_MANAGERS.PRIMARY_BRANCH_EMAIL, HAH_OFFICES.PRIMARY_BRANCH_EMAIL) AS PRIMARY_BRANCH_EMAIL,
		PRIMARY_MANAGER.EMPLOYEE_KEY AS PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY,
		UPPER(TRIM(COALESCE(SECONDARY_MANAGER.EMPLOYEE_FIRST_NAME || ' ' || SECONDARY_MANAGER.EMPLOYEE_LAST_NAME, HAH_OFFICES.OfficeManager2))) AS Secondary_Branch_Manager_Name,
		COALESCE(BRANCH_MANAGERS.SECONDARY_BRANCH_EMAIL, HAH_OFFICES.SECONDARY_BRANCH_EMAIL) AS SECONDARY_BRANCH_EMAIL,
		SECONDARY_MANAGER.EMPLOYEE_KEY AS SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY,
		RISKCONNECT.NODE_KEY AS RISKCONNECT_NODE_KEY,
		RISKCONNECT.NODE_NAME AS RISKCONNECT_NAME,
		HR.HR_OFFICE_NUMBER,
		HR.HR_OFFICE_NAME,
		TRUE AS ACTIVE_FLAG,
		TO_DATE('1900-01-01', 'YYYY-MM-DD') AS EFFECTIVE_FROM_DATE,
		TO_DATE('9999-12-31', 'YYYY-MM-DD') AS EFFECTIVE_TO_DATE,
		ROW_NUMBER() OVER(PARTITION BY OFFICES.SYSTEM_CODE, OFFICES.OFFICECODE 
			ORDER BY IFF(REGIONAL_EMPLOYEE.ACTIVE_EMPLOYEE_FLAG = TRUE, 0, 1), IFF(REGIONAL_EMPLOYEE.EMPLOYEE_CATEGORY IN ('Admin', 'Corp'), 0, 1), REGIONAL_EMPLOYEE.EMPLOYEE_LAST_CHECK_DATE DESC,
				IFF(PRIMARY_MANAGER.ACTIVE_EMPLOYEE_FLAG = TRUE, 0, 1), IFF(PRIMARY_MANAGER.EMPLOYEE_CATEGORY IN ('Admin', 'Corp'), 0, 1), PRIMARY_MANAGER.EMPLOYEE_LAST_CHECK_DATE DESC,
				IFF(SECONDARY_MANAGER.ACTIVE_EMPLOYEE_FLAG = TRUE, 0, 1), IFF(SECONDARY_MANAGER.EMPLOYEE_CATEGORY IN ('Admin', 'Corp'), 0, 1), SECONDARY_MANAGER.EMPLOYEE_LAST_CHECK_DATE DESC
			) AS ROW_NUMBER
	FROM OFFICE_LIST AS OFFICES
	JOIN HAH.DIM_STATE AS STATES 
		ON STATES.STATE_ISO_CODE = OFFICES.STATE
	LEFT JOIN HAH_OFFICES AS HAH_OFFICES
		ON HAH_OFFICES.STATE = OFFICES.STATE AND HAH_OFFICES.OFFICE_NUMBER = OFFICES.OFFICENUMBER
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HAH_REPORTING.KEYMETOFFICES AS REGION_OFFICES -- Only used for IL regions
		ON OFFICES.STATE = 'IL' AND TRIM(REGION_OFFICES.OFFICESTATE) = OFFICES.STATE AND TRY_CAST(REGION_OFFICES.OFFICENUMBER AS INT) = OFFICES.OFFICENUMBER
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.BI_REPOSITORY.KMREGIONS AS REGIONS
		ON (REGION_OFFICES.REGIONNUMBER IS NULL AND 
			CASE WHEN UPPER( STATES.State_Name) = 'GEORGIA' THEN 'GEORGIA/SOUTH CAROLINA'
				WHEN UPPER( STATES.State_Name) = 'SOUTH CAROLINA' THEN 'GEORGIA/SOUTH CAROLINA'
				WHEN UPPER( STATES.State_Name) = 'MICHIGAN' THEN 'DD/MICHIGAN'
				WHEN UPPER( STATES.State_Name) = 'KANSAS' THEN 'MISSOURI' 
				WHEN UPPER( STATES.State_Name) = 'IOWA' THEN 'ILLINOIS - NORTH' 
				WHEN UPPER( STATES.State_Name) = 'MISSISSIPPI' THEN 'MISSISSIPPI/TENNESSEE'
				WHEN UPPER( STATES.State_Name) = 'TENNESSEE' THEN 'MISSISSIPPI/TENNESSEE'
				ELSE UPPER( STATES.State_Name) END = REGIONS.NAME) 
			OR (REGION_OFFICES.REGIONNUMBER = REGIONS.REGIONNUMBER)
	LEFT JOIN HAH.DIM_EMPLOYEE AS REGIONAL_EMPLOYEE 
		ON OFFICES.STATE IN ('PA') AND REGIONAL_EMPLOYEE.SOURCE_SYSTEM_ID = 4 
			AND REGIONAL_EMPLOYEE.EMPLOYEE_ID = REGIONS.MANAGEREMPLOYEEID 
			-- AND REGIONAL_EMPLOYEE.ACTIVE_EMPLOYEE_FLAG = TRUE AND REGIONAL_EMPLOYEE.EMPLOYEE_CATEGORY IN ('Admin', 'Corp')
	LEFT JOIN HAH.FACT_BRANCH_MANAGER_MAPPING AS BRANCH_MANAGERS
		ON BRANCH_MANAGERS.OFFICE_SYSTEM_CODE = OFFICES.SYSTEM_CODE AND BRANCH_MANAGERS.OFFICE_CODE = OFFICES.OFFICECODE 
	LEFT JOIN HAH.DIM_EMPLOYEE AS PRIMARY_MANAGER
		ON PRIMARY_MANAGER.SYSTEM_CODE = BRANCH_MANAGERS.PRIMARY_MANAGER_SYSTEM_CODE  
			AND PRIMARY_MANAGER.EMPLOYEE_ID = BRANCH_MANAGERS.PRIMARY_MANAGER_EMPLOYEE_ID
			-- AND PRIMARY_MANAGER.ACTIVE_EMPLOYEE_FLAG = TRUE AND PRIMARY_MANAGER.EMPLOYEE_CATEGORY IN ('Admin', 'Corp')
	LEFT JOIN HAH.DIM_EMPLOYEE AS SECONDARY_MANAGER
		ON SECONDARY_MANAGER.SYSTEM_CODE = BRANCH_MANAGERS.SECONDARY_MANAGER_SYSTEM_CODE  
			AND SECONDARY_MANAGER.EMPLOYEE_ID = BRANCH_MANAGERS.SECONDARY_MANAGER_EMPLOYEE_ID
			-- AND SECONDARY_MANAGER.ACTIVE_EMPLOYEE_FLAG = TRUE AND SECONDARY_MANAGER.EMPLOYEE_CATEGORY IN ('Admin', 'Corp')
	LEFT JOIN RISKCONNECT_HIERARCHY AS RISKCONNECT
		ON RISKCONNECT.PARENT_LEVEL = 2 AND RISKCONNECT.STATE = OFFICES.STATE
			AND TRY_CAST(RISKCONNECT.OFFICE_NUMBER AS INTEGER) = OFFICES.OFFICENUMBER 
	LEFT JOIN HR_OFFICE_MAPPING AS HR
		ON HR.STATE = OFFICES.STATE AND TRY_CAST(HR.OFFICE_NUMBER AS INTEGER) = OFFICES.OFFICENUMBER 
	WHERE OFFICES.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR HAH_OFFICES.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR 
		REGION_OFFICES.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR REGIONS.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR 
		REGIONAL_EMPLOYEE.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR BRANCH_MANAGERS.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR 
		PRIMARY_MANAGER.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR SECONDARY_MANAGER.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR 
		RISKCONNECT.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR HR.ETL_LAST_UPDATED_DATE >= '1900-01-01'
)
	SELECT OFFICES.BRANCH_KEY
    FROM OFFICES AS OFFICES
	WHERE OFFICES.ROW_NUMBER = 1;
SQL
	or_replace = true 
	is_secure = false 
}

