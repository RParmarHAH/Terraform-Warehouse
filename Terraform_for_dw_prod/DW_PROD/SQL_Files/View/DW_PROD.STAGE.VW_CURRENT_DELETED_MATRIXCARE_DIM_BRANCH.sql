create or replace view DW_PROD.STAGE.VW_CURRENT_DELETED_MATRIXCARE_DIM_BRANCH(
	BRANCH_KEY
) as
WITH RISKCONNECT_HIERARCHY AS (
	SELECT *
	FROM (
		SELECT *, 
			-- Give preference to nodes that are not marked inactive (e.g. office 730)
			CHARINDEX('inactive', LOWER(NODE_KEY)) INACTIVE_CHECK_1,
			CHARINDEX('inactive', LOWER(NODE_CODE)) INACTIVE_CHECK_2,
			CHARINDEX('inactive', LOWER(NODE_NAME)) INACTIVE_CHECK_3,
		ROW_NUMBER() OVER(PARTITION BY STATE, COALESCE(OFFICE_NUMBER, OFFICENO), OFFICE_CODE ORDER BY GREATEST(NVL(INACTIVE_CHECK_1, 0), NVL(INACTIVE_CHECK_2, 0), NVL(INACTIVE_CHECK_3, 0))) AS ROW_NUMBER
		FROM DISC_PROD.STAGE.RISKCONNECT_HIERARCHY
	) L
	WHERE L.ROW_NUMBER = 1
), HR_OFFICE_MAPPING AS (
	SELECT *
	FROM (
		SELECT *, COUNT(*) OVER(PARTITION BY STATE, OFFICE_NUMBER) AS COUNT_OF_ROWS
		FROM DISC_PROD.STAGE.HR_OFFICE_MAPPING
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
	FROM DISC_PROD.HAHUSERS.LOGIN_OFFICE AS OFFICES
	WHERE TRY_CAST(OFFICES.OFFICENUMBER AS INT) IS NOT NULL
		AND OFFICES.STATUS > 0
		--AND NOT (OFFICES.STATE = 'GA' AND CAST(OFFICES.OFFICENUMBER AS INT) >= 900) -- Excluding new GA offices (except for original HAH GA offices)
		AND OFFICES.STATE = 'IN'
), KEY_METRIC_OFFICES AS (
	SELECT TRIM(KEY_MET_OFFICES.OFFICESTATE) AS STATE, TRY_CAST(KEY_MET_OFFICES.OFFICENUMBER AS INT) AS OFFICE_NUMBER, 
		UPPER(TRIM(KEY_MET_OFFICES.OFFICENAME)) AS OFFICE_NAME, KEY_MET_OFFICES.ETL_LAST_UPDATED_DATE 
	FROM DISC_PROD.HAH_REPORTING.KEYMETOFFICES AS KEY_MET_OFFICES
	WHERE TRY_CAST(KEY_MET_OFFICES.OFFICENUMBER AS INT) IS NOT NULL
), OFFICE_LIST AS (
	SELECT 7 AS SOURCE_SYSTEM_ID, 
		'MATRIXCARE' AS SYSTEM_CODE, 
		COALESCE(MAPPING.OFFICE_STATE, BRANCHES.BR_STATEORPROVINCE, 'IN') AS STATE, 
		CASE WHEN UPPER(BRANCHES.BR_FORMALNAME) LIKE '%HELP AT HOME%' THEN 'HAH' ELSE 'ADAPTIVE' END AS OFFICE_TYPE,
		CASE WHEN UPPER(BRANCHES.BR_NAME) LIKE 'ZDNU%' THEN TRUE ELSE FALSE END AS IS_RETIRED,
		BRANCHES.BR_ID AS OFFICECODE,
		COALESCE(MAPPING.HAH_OFFICE_NUMBER, -1) AS OFFICENUMBER,
		UPPER(COALESCE(NULLIF(TRIM(BRANCHES.BR_NAME), ''), TRIM(HAH_OFFICES.OFFICE_NAME))) AS OFFICENAME,
		-- For office address, if Br_Address1 is null, use all fields from HAH_Offices
		IFF(TRIM(NVL(BRANCHES.BR_ADDRESS1, '')) = '', TRIM(HAH_OFFICES.OFFICE_ADDRESS1), TRIM(BRANCHES.BR_ADDRESS1)) AS OFFICE_ADDRESS1,
		IFF(TRIM(NVL(BRANCHES.BR_ADDRESS1, '')) = '', TRIM(HAH_OFFICES.OFFICE_ADDRESS2), TRIM(BRANCHES.BR_ADDRESS2)) AS OFFICE_ADDRESS2,
		IFF(TRIM(NVL(BRANCHES.BR_ADDRESS1, '')) = '', TRIM(HAH_OFFICES.OFFICE_CITY), TRIM(BRANCHES.BR_CITY)) AS OFFICE_CITY,
		IFF(TRIM(NVL(BRANCHES.BR_ADDRESS1, '')) = '', TRIM(HAH_OFFICES.OFFICE_ZIP), TRIM(BRANCHES.BR_POSTALCODE)) AS OFFICE_ZIP,
		COALESCE(NULLIF(TRIM(HAH_OFFICES.OFFICE_PHONE), ''), TRIM(BRANCHES.BR_REMITPHONE)) AS OFFICE_PHONE,
		TRIM(HAH_OFFICES.OFFICE_TOLL_FREE_PHONE) AS OFFICE_TOLL_FREE_PHONE,
		COALESCE(NULLIF(TRIM(HAH_OFFICES.OFFICE_FAX), ''), TRIM(BRANCHES.BR_REMITFAX)) AS OFFICE_FAX,
		TRIM(HAH_OFFICES.PRIMARY_BRANCH_EMAIL) AS PRIMARY_BRANCH_EMAIL,
		TRIM(HAH_OFFICES.SECONDARY_BRANCH_EMAIL) AS SECONDARY_BRANCH_EMAIL,
		TRIM(HAH_OFFICES.OFFICEMANAGER1) AS OFFICEMANAGER1,
		TRIM(HAH_OFFICES.OFFICEMANAGER2) AS OFFICEMANAGER2,
		NULL AS PAYROLLBATCHNAME,
		BRANCHES.BR_PARBRANCHID AS PARENTOFFICECODE, 
		GREATEST(
			NVL(BRANCHES.ETL_LAST_UPDATED_DATE, '1/1/1900'), 
			NVL(MAPPING.ETL_LAST_UPDATED_DATE, '1/1/1900'), 
			NVL(HAH_OFFICES.ETL_LAST_UPDATED_DATE, '1/1/1900')) AS ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.MATRIXCARE.HIST_STVHC_T_BRANCHES AS BRANCHES
	LEFT JOIN DISC_PROD."STAGE".MATRIXCARE_OFFICE_MAPPING AS MAPPING 
		ON MAPPING.BR_ID = BRANCHES.BR_ID
	LEFT JOIN HAH_OFFICES AS HAH_OFFICES
		ON HAH_OFFICES.STATE = COALESCE(MAPPING.OFFICE_STATE, BRANCHES.BR_STATEORPROVINCE, 'IN')
			AND HAH_OFFICES.OFFICE_NUMBER = MAPPING.HAH_OFFICE_NUMBER
	WHERE BRANCHES.ETL_DELETED_FLAG = TRUE
		AND CAST(BRANCHES.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_PROD.MATRIXCARE.HIST_STVHC_T_BRANCHES)
), OFFICES AS (
	SELECT *
	FROM (
		SELECT MD5(OFFICES.SYSTEM_CODE || '-' || OFFICES.OFFICECODE || '-' || 'MATRIXCARE') AS BRANCH_KEY,
			OFFICES.OFFICENAME AS BRANCH_NAME,
			OFFICES.SYSTEM_CODE,
			OFFICES.SOURCE_SYSTEM_ID,
			OFFICES.OFFICENUMBER AS OFFICE_NUMBER,
			OFFICES.OFFICECODE::STRING AS OFFICE_CODE,
			OFFICES.OFFICENAME AS OFFICE_NAME,
			UPPER(OFFICES.OFFICENAME) AS OFFICE_NAME_ALT,
			OFFICES.PAYROLLBATCHNAME AS DEPARTMENT_NAME,
			CASE WHEN OFFICES.OFFICENAME LIKE '%DD%' THEN 'DD'
				WHEN OFFICES.OFFICENAME LIKE '%ADS%' THEN 'ADS'
				ELSE NULL END AS BRANCH_SERVICE_LINE,
			-- This logic was to use MatrixCare's parent branch hierarchy (which was for licenses and not the way we have the DW configured)
			-- IFF(OFFICES.OFFICECODE = PARENT_OFFICES.OFFICECODE OR PARENT_OFFICES.OFFICECODE IS NULL, TRUE, FALSE) AS PARENT_FLAG,
			-- COALESCE(MD5(PARENT_OFFICES.SYSTEM_CODE || '-' || PARENT_OFFICES.OFFICECODE || '-' || 'MATRIXCARE'), BRANCH_KEY) AS PARENT_BRANCH_KEY,
			-- COALESCE(PARENT_OFFICES.OFFICENUMBER, OFFICES.OFFICENUMBER) AS PARENT_OFFICE_NUMBER,
			-- COALESCE(PARENT_OFFICES.OFFICECODE::STRING, OFFICES.OFFICECODE::STRING) AS PARENT_OFFICE_CODE,
			-- COALESCE(PARENT_OFFICES.STATE || ' - ' || PARENT_OFFICES.OFFICENAME || ' (' || PARENT_OFFICES.OFFICECODE || ')',
			-- 	OFFICES.STATE || ' - ' || OFFICES.OFFICENAME || ' (' || OFFICES.OFFICECODE || ')') AS PARENT_BRANCH_NAME,
			TRUE AS PARENT_FLAG,
			MD5(OFFICES.SYSTEM_CODE || '-' || OFFICES.OFFICECODE || '-' || 'MATRIXCARE') AS PARENT_BRANCH_KEY,
			OFFICES.OFFICENUMBER AS PARENT_OFFICE_NUMBER,
			OFFICES.OFFICECODE::STRING AS PARENT_OFFICE_CODE,
			OFFICES.STATE || ' - ' || OFFICES.OFFICENAME || ' (' || OFFICES.OFFICECODE || ')' AS PARENT_BRANCH_NAME,
			OFFICES.OFFICE_ADDRESS1,
			OFFICES.OFFICE_ADDRESS2,
			OFFICES.OFFICE_CITY,
			OFFICES.STATE AS OFFICE_STATE_CODE,
			OFFICES.OFFICE_ZIP,
			OFFICES.OFFICE_PHONE,
			OFFICES.OFFICE_TOLL_FREE_PHONE,
			OFFICES.OFFICE_FAX,
			OFFICES.STATE || ' - ' || OFFICES.OFFICENAME || ' (' || OFFICES.OFFICECODE || ')' AS DETAILED_OFFICE_NAME,
			REGIONS.REGIONNUMBER AS REGION_NUMBER,
			IFF(UPPER(TRIM(REGIONS.NAME)) = 'DD/MICHIGAN', 'MICHIGAN', UPPER(TRIM(REGIONS.NAME))) AS REGION_NAME,
			UPPER(TRIM(COALESCE(REGIONAL_EMPLOYEE.EMPLOYEE_FIRST_NAME || ' ' || REGIONAL_EMPLOYEE.EMPLOYEE_LAST_NAME, REGIONS.MANAGER))) AS REGION_MANAGER, -- Do we select the name in SQL Server, or concat name from Dim_Employee
			REGIONAL_EMPLOYEE.EMPLOYEE_KEY AS REGION_MANAGER_EMPLOYEE_KEY,
			CAST(NULL AS VARCHAR) AS SUBREGION_NAME,
			UPPER(TRIM(COALESCE(PRIMARY_MANAGER.EMPLOYEE_FIRST_NAME || ' ' || PRIMARY_MANAGER.EMPLOYEE_LAST_NAME, OFFICES.OfficeManager1))) AS Primary_Branch_Manager_Name,
			COALESCE(BRANCH_MANAGERS.PRIMARY_BRANCH_EMAIL, OFFICES.PRIMARY_BRANCH_EMAIL) AS PRIMARY_BRANCH_EMAIL,
			PRIMARY_MANAGER.EMPLOYEE_KEY AS PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY,
			UPPER(TRIM(COALESCE(SECONDARY_MANAGER.EMPLOYEE_FIRST_NAME || ' ' || SECONDARY_MANAGER.EMPLOYEE_LAST_NAME, OFFICES.OfficeManager2))) AS Secondary_Branch_Manager_Name,
			COALESCE(BRANCH_MANAGERS.SECONDARY_BRANCH_EMAIL, OFFICES.SECONDARY_BRANCH_EMAIL) AS SECONDARY_BRANCH_EMAIL,
			SECONDARY_MANAGER.EMPLOYEE_KEY AS SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY,
			RISKCONNECT.NODE_KEY AS RISKCONNECT_NODE_KEY,
			RISKCONNECT.NODE_NAME AS RISKCONNECT_NAME,
			HR.HR_OFFICE_NUMBER,
			HR.HR_OFFICE_NAME,
			TRUE AS ACTIVE_FLAG,
			TO_DATE('1900-01-01', 'YYYY-MM-DD') AS EFFECTIVE_FROM_DATE,
			TO_DATE('9999-12-31', 'YYYY-MM-DD') AS EFFECTIVE_TO_DATE,
			MATRIXCARE_BRANCH_MAPPING.CONVERGED_BRANCH_KEY,
			MATRIXCARE_BRANCH_MAPPING.CONVERGED_SOURCE_SYSTEM_ID,
			MATRIXCARE_BRANCH_MAPPING.CONVERGED_SYSTEM_CODE,
			MATRIXCARE_BRANCH_MAPPING.CONVERGED_OFFICE_CODE,
			ROW_NUMBER() OVER(PARTITION BY OFFICES.SYSTEM_CODE, OFFICES.OFFICECODE 
				ORDER BY IFF(REGIONAL_EMPLOYEE.ACTIVE_EMPLOYEE_FLAG = TRUE, 0, 1), IFF(REGIONAL_EMPLOYEE.EMPLOYEE_CATEGORY IN ('Admin', 'Corp'), 0, 1), REGIONAL_EMPLOYEE.EMPLOYEE_LAST_CHECK_DATE DESC,
					IFF(PRIMARY_MANAGER.ACTIVE_EMPLOYEE_FLAG = TRUE, 0, 1), IFF(PRIMARY_MANAGER.EMPLOYEE_CATEGORY IN ('Admin', 'Corp'), 0, 1), PRIMARY_MANAGER.EMPLOYEE_LAST_CHECK_DATE DESC,
					IFF(SECONDARY_MANAGER.ACTIVE_EMPLOYEE_FLAG = TRUE, 0, 1), IFF(SECONDARY_MANAGER.EMPLOYEE_CATEGORY IN ('Admin', 'Corp'), 0, 1), SECONDARY_MANAGER.EMPLOYEE_LAST_CHECK_DATE DESC
				) AS ROW_NUMBER
		FROM OFFICE_LIST AS OFFICES
		JOIN HAH.DIM_STATE AS STATES 
			ON STATES.STATE_ISO_CODE = OFFICES.STATE
		-- LEFT JOIN OFFICE_LIST AS PARENT_OFFICES
		-- 	ON PARENT_OFFICES.OFFICECODE = OFFICES.PARENTOFFICECODE
		LEFT JOIN DISC_PROD.HAH_REPORTING.KEYMETOFFICES AS REGION_OFFICES -- Only used for IL regions
			ON OFFICES.STATE = 'IL' AND TRIM(REGION_OFFICES.OFFICESTATE) = OFFICES.STATE AND TRY_CAST(REGION_OFFICES.OFFICENUMBER AS INT) = OFFICES.OFFICENUMBER
		LEFT JOIN DISC_PROD.BI_REPOSITORY.KMREGIONS AS REGIONS
			ON (OFFICES.IS_RETIRED = FALSE AND
				(REGION_OFFICES.REGIONNUMBER IS NULL AND 
					CASE WHEN UPPER( STATES.State_Name) = 'GEORGIA' THEN 'GEORGIA/SOUTH CAROLINA'
						WHEN UPPER( STATES.State_Name) = 'SOUTH CAROLINA' THEN 'GEORGIA/SOUTH CAROLINA'
						WHEN UPPER( STATES.State_Name) = 'MICHIGAN' THEN 'DD/MICHIGAN'
						WHEN UPPER( STATES.State_Name) = 'KANSAS' THEN 'MISSOURI' 
						WHEN UPPER( STATES.State_Name) = 'IOWA' THEN 'ILLINOIS - NORTH' 
						WHEN UPPER( STATES.State_Name) = 'MISSISSIPPI' THEN 'MISSISSIPPI/TENNESSEE'
						WHEN UPPER( STATES.State_Name) = 'TENNESSEE' THEN 'MISSISSIPPI/TENNESSEE'
						ELSE UPPER( STATES.State_Name) END = REGIONS.NAME) 
					OR (REGION_OFFICES.REGIONNUMBER = REGIONS.REGIONNUMBER))
				OR (OFFICES.IS_RETIRED = TRUE AND TRIM(REGIONS.NAME) = '<RETIRED>')
		LEFT JOIN HAH.DIM_EMPLOYEE AS REGIONAL_EMPLOYEE 
			ON ((OFFICES.STATE NOT IN ('GA', 'SC', 'PA') AND REGIONAL_EMPLOYEE.SOURCE_SYSTEM_ID = 5)
					OR (OFFICES.STATE IN ('GA', 'SC') AND REGIONAL_EMPLOYEE.SOURCE_SYSTEM_ID = 2)
					OR (OFFICES.STATE IN ('PA') AND REGIONAL_EMPLOYEE.SOURCE_SYSTEM_ID = 4)) 
					AND REGIONAL_EMPLOYEE.EMPLOYEE_ID = REGIONS.MANAGEREMPLOYEEID 
					-- AND REGIONAL_EMPLOYEE.ACTIVE_EMPLOYEE_FLAG = TRUE AND REGIONAL_EMPLOYEE.EMPLOYEE_CATEGORY IN ('Admin', 'Corp')
		LEFT JOIN HAH.FACT_BRANCH_MANAGER_MAPPING AS BRANCH_MANAGERS
			ON BRANCH_MANAGERS.OFFICE_SYSTEM_CODE = OFFICES.SYSTEM_CODE AND BRANCH_MANAGERS.OFFICE_CODE = OFFICES.OFFICECODE::STRING 
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
				AND ((OFFICES.OFFICE_TYPE = 'HAH' AND CHARINDEX('ADAPTIVE', UPPER(RISKCONNECT.NODE_KEY)) = 0 AND TRY_CAST(COALESCE(RISKCONNECT.OFFICE_NUMBER, RISKCONNECT.OFFICENO) AS INTEGER) = IFF(OFFICES.OFFICENUMBER = 0, 999, OFFICES.OFFICENUMBER))
					OR (OFFICES.OFFICE_TYPE = 'ADAPTIVE' AND CHARINDEX('ADAPTIVE', UPPER(RISKCONNECT.NODE_KEY)) > 0 AND TRY_CAST(RISKCONNECT.OFFICE_CODE AS INTEGER) = OFFICES.OFFICECODE))
		LEFT JOIN HR_OFFICE_MAPPING AS HR
			ON HR.STATE = OFFICES.STATE AND TRY_CAST(HR.OFFICE_NUMBER AS INTEGER) = OFFICES.OFFICENUMBER 
		LEFT JOIN DISC_PROD.MATRIXCARE.MATRIXCARE_MASTER_BRANCH_MAPPING AS MATRIXCARE_BRANCH_MAPPING
			ON MATRIXCARE_BRANCH_MAPPING.SOURCE_SYSTEM_ID = OFFICES.SOURCE_SYSTEM_ID
				AND MATRIXCARE_BRANCH_MAPPING.SYSTEM_CODE = OFFICES.SYSTEM_CODE
				AND MATRIXCARE_BRANCH_MAPPING.OFFICE_CODE = OFFICES.OFFICECODE::STRING
		WHERE OFFICES.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR --HAH_OFFICES.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR 
			REGION_OFFICES.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR REGIONS.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR 
			REGIONAL_EMPLOYEE.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR BRANCH_MANAGERS.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR 
			PRIMARY_MANAGER.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR SECONDARY_MANAGER.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR 
			RISKCONNECT.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR HR.ETL_LAST_UPDATED_DATE >= '1900-01-01' OR
			MATRIXCARE_BRANCH_MAPPING.ETL_LAST_UPDATED_DATE >= '1900-01-01'
	) AS OFFICE_LIST
	WHERE OFFICE_LIST.ROW_NUMBER = 1
)
	SELECT DISTINCT 
		COALESCE(CONVERGED_OFFICES.BRANCH_KEY, OFFICES.BRANCH_KEY) AS BRANCH_KEY
	FROM OFFICES AS OFFICES
 	LEFT JOIN OFFICES AS CONVERGED_OFFICES
		ON CONVERGED_OFFICES.SOURCE_SYSTEM_ID = OFFICES.CONVERGED_SOURCE_SYSTEM_ID
			AND CONVERGED_OFFICES.SYSTEM_CODE = OFFICES.CONVERGED_SYSTEM_CODE
			AND CONVERGED_OFFICES.OFFICE_CODE = OFFICES.CONVERGED_OFFICE_CODE;