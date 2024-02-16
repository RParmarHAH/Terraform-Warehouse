resource "snowflake_view" "DW_STAGE_VW_CURRENT_COSTALSYNCDATA_DIM_BRANCH" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_COSTALSYNCDATA_DIM_BRANCH"
	statement = <<-SQL
	 
WITH RISKCONNECT_HIERARCHY AS (
	SELECT * FROM DISC_${var.SF_ENVIRONMENT}.STAGE.RISKCONNECT_HIERARCHY 
), HR_OFFICE_MAPPING AS (
	SELECT * FROM DISC_${var.SF_ENVIRONMENT}.STAGE.HR_OFFICE_MAPPING 
), COASTAL_OFFICE_MAPPING AS (
	SELECT * FROM DISC_${var.SF_ENVIRONMENT}.STAGE.COASTAL_OFFICE_MAPPING 
), HAH_OFFICES AS (
	SELECT OFFICES.STATE,
		TRY_CAST(OFFICES.OFFICENUMBER AS INT) AS OFFICE_NUMBER,
		OFFICES.OFFICENAME AS OFFICE_NAME,
		CASE WHEN OFFICES.OFFICENAME LIKE '%DD%' THEN 'DD'
			WHEN OFFICES.OFFICENAME LIKE '%ADS%' THEN 'ADS'
		END AS BRANCH_SERVICE_LINE,
		OFFICES.ADDRESS AS OFFICE_ADDRESS1,
		OFFICES.ADDRESS2 AS OFFICE_ADDRESS2,
		OFFICES.CITY AS OFFICE_CITY,
		OFFICES.ZIP AS OFFICE_ZIP,
		OFFICES.PHONE AS OFFICE_PHONE,
		OFFICES.TOLLFREE AS OFFICE_TOLL_FREE_PHONE,
		OFFICES.FAX AS OFFICE_FAX,
		TRIM( OFFICES.Email) AS Primary_Branch_Email,
		CAST(NULL AS VARCHAR(10)) AS Secondary_Branch_Email,
		OFFICES.OFFICEMANAGER AS OFFICEMANAGER1,
		CAST(NULL AS VARCHAR(10)) AS OFFICEMANAGER2,
--		IFF(CHARINDEX(' ', TRIM(UPPER(OFFICES.OFFICEMANAGER))) > 0, SUBSTRING(TRIM(UPPER(OFFICES.OFFICEMANAGER)), 1, CHARINDEX(' ', TRIM(UPPER(OFFICES.OFFICEMANAGER)), 1) - 1), NULL) AS PRIMARY_BRANCH_MANAGER_DERIVED_FIRST_NAME, /*First Name from o.OfficeManager field, from position 1 until first space*/
--		IFF(CHARINDEX(' ', TRIM(UPPER(OFFICES.OFFICEMANAGER))) > 0, SUBSTRING(TRIM(UPPER(OFFICES.OFFICEMANAGER)),
--			LEN(TRIM(UPPER(OFFICES.OFFICEMANAGER))) - CHARINDEX(' ', TRIM(UPPER(REVERSE(OFFICES.OFFICEMANAGER))), 1) + 2, /*Starting position of first character after last space*/
--			LEN(TRIM(UPPER(OFFICES.OFFICEMANAGER)))), NULL) AS PRIMARY_BRANCH_MANAGER_DERIVED_LAST_NAME,
--		CAST(NULL AS VARCHAR(10)) AS SECONDARY_BRANCH_MANAGER_DERIVED_FIRST_NAME,
--		CAST(NULL AS VARCHAR(10)) AS SECONDARY_BRANCH_MANAGER_DERIVED_LAST_NAME,
		OFFICES.DATECREATED AS DATE_CREATED,
		OFFICES.ETL_LAST_UPDATED_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.HAHUSERS.LOGIN_OFFICE AS OFFICES
	WHERE OFFICES.STATE IN ('GA', 'SC')
		AND TRY_CAST(OFFICES.OFFICENUMBER AS INT) IS NOT NULL
		AND TRY_CAST(OFFICES.OFFICENUMBER AS INT) <> 205 -- Exclude Hartsville, SC (closed)
),
Coastal_Parent_Rollup AS
(
  SELECT --MD5( 'SHC_ALTRUS' || '-' || '84005' || '-' || 'MRWP' || '-' || 'Altrus Host Homes' || '-' || 'CostalSyncData') AS Branch_Key,
	  MD5( 'SHC_ALTRUS' || '-' || 'MRWP' || '-' || 'COSTALSYNCDATA') AS Branch_Key,
         'Altrus Host Homes' AS Branch_Name,
         'SHC_ALTRUS' AS System_Code,
         1 AS Source_System_ID,
         84005 AS Office_Number,
         'MRWP' AS Office_Code,
         'Altrus Host Homes' AS Office_Name,
         UPPER( 'Altrus Host Homes') AS Office_Name_Alt,
         NULL AS Department_Name,
         'CLS' AS Branch_Service_Line,
         'TRUE' AS Parent_Flag,
--         MD5( 'SHC_ALTRUS' || '-' || '84005' || '-' || 'MRWP' || '-' || 'Altrus Host Homes' || '-' || 'CostalSyncData') AS Parent_Branch_Key,
	  MD5( 'SHC_ALTRUS' || '-' || 'MRWP' || '-' || 'COSTALSYNCDATA') AS Parent_Branch_Key,
         'MRWP' AS Parent_Office_Code,
         84005 AS Parent_Office_Number,
         NULL AS Office_Address1, NULL AS Office_Address2, NULL AS Office_City, 'GA' AS Office_State_Code, NULL AS Office_Zip,
         NULL AS Office_Phone, NULL AS Office_Toll_Free_Phone, NULL AS Office_Fax,
         'GA' || ' - ' || 'Altrus Host Homes' || ' 84005' AS Detailed_Office_Name,
         2 AS Region_Number,
         'GEORGIA/SOUTH CAROLINA' AS Region_Name,
         'JANA' AS Region_Manager,
         'xyz' AS Region_Manager_Employee_Key,
         NULL AS SubRegion_Name,
         NULL AS Primary_Branch_Manager_Name,
         NULL AS Primary_Branch_Email,
         NULL AS Primary_Branch_Manager_Employee_Key,
         NULL AS Secondary_Branch_Manager_Name,
         NULL AS Secondary_Branch_Email,
         NULL AS Secondary_Branch_Manager_Employee_Key,
         NULL AS RiskConnect_Node_Key,
         NULL AS RiskConnect_Name,
         84005 AS HR_Office_Number,
         'TRUE' AS Active_Flag,
         CAST( '1970-01-01' AS DATE) AS Effective_From_Date, 
         CAST( '2090-01-01' AS DATE) AS Effective_To_Date,
         convert_timezone('UTC', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
         CURRENT_USER as ETL_INSERTED_BY ,
         convert_timezone('UTC', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
         CURRENT_USER as ETL_LAST_UPDATED_BY,
         0 as ETL_DELETED_FLAG,
         0 AS ETL_INFERRED_MEMBER_FLAG
  UNION
  SELECT --MD5( 'SHC_ALTRUS' || '-' || '84002' || '-' || 'ALS' || '-' || 'Altrus Personal Care Homes' || '-' || 'CostalSyncData') AS Branch_Key,
  	  MD5( 'SHC_ALTRUS' || '-' || 'ALS' || '-' || 'COSTALSYNCDATA') AS Branch_Key,
         'Altrus Personal Care Homes' AS Branch_Name,
         'SHC_ALTRUS' AS System_Code,
         1 AS Source_System_ID,
         84002 AS Office_Number,
         'ALS' AS Office_Code,
         'Altrus Personal Care Homes' AS Office_Name,
         UPPER( 'Altrus Personal Care Homes') AS Office_Name_Alt,
         NULL AS Department_Name,
         'CLS' AS Branch_Service_Line,
         'TRUE' AS Parent_Flag,
--         MD5( 'SHC_ALTRUS' || '-' || '84002' || '-' || 'ALS' || '-' || 'Altrus Personal Care Homes' || '-' || 'CostalSyncData') AS Parent_Branch_Key,
  	  MD5( 'SHC_ALTRUS' || '-' || 'ALS' || '-' || 'COSTALSYNCDATA') AS Parent_Branch_Key,
         'ALS' AS Parent_Office_Code,
         84002 AS Parent_Office_Number,
         NULL AS Office_Address1, NULL AS Office_Address2, NULL AS Office_City, 'GA' AS Office_State_Code, NULL AS Office_Zip,
         NULL AS Office_Phone, NULL AS Office_Toll_Free_Phone, NULL AS Office_Fax,
         'GA' || ' - ' || 'Altrus Personal Care Homes' || ' 84002' AS Detailed_Office_Name,
         2 AS Region_Number,
         'GEORGIA/SOUTH CAROLINA' AS Region_Name,
         'JANA' AS Region_Manager,
         'xyz' AS Region_Manager_Employee_Key,
         NULL AS SubRegion_Name,
         NULL AS Primary_Branch_Manager_Name,
         NULL AS Primary_Branch_Email,
         NULL AS Primary_Branch_Manager_Employee_Key,
         NULL AS Secondary_Branch_Manager_Name,
         NULL AS Secondary_Branch_Email,
         NULL AS Secondary_Branch_Manager_Employee_Key,
         NULL AS RiskConnect_Node_Key,
         NULL AS RiskConnect_Name,
         84002 AS HR_Office_Number,
        'TRUE' AS Active_Flag,
         CAST( '1970-01-01' AS DATE) AS Effective_From_Date, 
         CAST( '2090-01-01' AS DATE) AS Effective_To_Date,
         convert_timezone('UTC', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
         CURRENT_USER as ETL_INSERTED_BY ,
         convert_timezone('UTC', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
         CURRENT_USER as ETL_LAST_UPDATED_BY,
         0 as ETL_DELETED_FLAG,
         0 AS ETL_INFERRED_MEMBER_FLAG
),
Parent_Offices AS
(
SELECT --MD5( TRIM( loc.DB) || '-' || '1' || '-' || TRIM( loc.Location_Code) || '-' || TRIM( loc.Location_Name) || '-' || 'CostalSyncData') AS Parent_Branch_Key,
	MD5( TRIM( loc.DB) || '-' || TRIM( loc.Location_Code) || '-' || 'COSTALSYNCDATA') AS Parent_Branch_Key,
       TRIM( loc.Location_Name) AS Parent_Branch_Name,
       TRIM( loc.DB) AS Parent_System_Code,
       IFF(LEN(NVL(TRIM( loc.State_Code), '')) = 2, TRIM(loc.State_Code), 'GA') AS OFFICE_STATE_CODE,
       CASE TRIM(UPPER( loc.DB)) WHEN 'SHC_ALTRUS' THEN 1 WHEN 'SHC_SAVANNAH' THEN 2 ELSE -1 END AS Parent_Source_System_ID,
       TRIM( loc.Location_Name) AS Parent_Office_Name,
       CASE WHEN TRIM( lhier.Office) IS NULL  THEN TRIM( loc.Location_Code)
            WHEN UPPER( TRIM( lhier.Office)) = 'OBSOLETE' THEN TRIM( loc.Location_Code)
            WHEN TRIM( UPPER( lhier.Office)) LIKE TRIM( UPPER( loc.Location_Name)) THEN TRIM( loc.Location_Code)
            WHEN TRIM( UPPER( loc.Location_Name)) IN ( 'TANGLEWOOD - ALTRUS I CLA', 'CAG LOCATION', 'WATSON MANOR', 'WAVERLY GARDENS', 'CAMDEN PLACE', 'WISTERIA GARDENS', '59TH STREET', 'TEBEAU HOUSE') THEN TRIM( loc.Location_Code)
            ELSE TRIM( UPPER( lhier.Office))
       END AS Parent_Office_Code,
       CAST( t.HAH_OFFICE_NUMBER AS INTEGER) AS Parent_Office_Number,
       CASE WHEN TRIM( loc.Location_Code) = Parent_Office_Code THEN TRUE
            ELSE FALSE
       END AS Parent_Flag
FROM DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_Locations AS loc
LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_LocationOfficeBreakdown AS lhier ON TRIM( loc.DB) = TRIM( lhier.DB) AND TRIM( loc.Location_Code) = TRIM( lhier.LocationCode)
LEFT OUTER JOIN COASTAL_OFFICE_MAPPING AS t On TRIM( t.DB) = TRIM( loc.DB) AND TRIM( t.LOCATION_CODE) = TRIM( loc.Location_Code)
WHERE Parent_Flag = TRUE
UNION
SELECT cpr.Branch_Key AS Parent_Branch_Key,
       UPPER( cpr.Branch_Name) AS Parent_Branch_Name,
       cpr.System_Code AS Parent_System_Code,
       cpr.OFFICE_STATE_CODE,
       cpr.Source_System_ID AS Parent_Source_System_ID,
       UPPER( cpr.Office_Name) AS Parent_Office_Name,
       cpr.Office_Code AS Parent_Office_Code,
       CAST( cpr.Office_Number AS INTEGER) AS Parent_Office_Number,
       cpr.Parent_Flag AS Parent_Flag
FROM Coastal_Parent_Rollup AS cpr
),
OFFICE_LIST AS (
	SELECT DB, LOCATION_CODE, LOCATION_NAME, CAST(NULL AS INT) AS OFFICE_NUMBER,
		ADDRESS, STREET_NAME, CITY, STATE_CODE, ZIPCODE,
		ENTRY_DATE, ETL_LAST_UPDATED_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_Locations 
	UNION ALL
	SELECT SYSTEM_CODE AS DB, OFFICE_CODE AS LOCATION_CODE, OFFICE_NAME AS LOCATION_NAME, OFFICE_NUMBER,
		OFFICE_ADDRESS1 AS ADDRESS, OFFICE_ADDRESS2 AS STREET_NAME, OFFICE_CITY AS CITY, OFFICE_STATE_CODE AS STATE_CODE, OFFICE_ZIP AS ZIPCODE,
		EFFECTIVE_FROM_DATE AS ENTRY_DATE, '1/1/1900'::TIMESTAMPNTZ AS ETL_LAST_UPDATED_DATE 
	FROM Coastal_Parent_Rollup
	UNION ALL
	SELECT CASE WHEN OFFICE_NUMBER IN (955) THEN 'SHC_ALTRUS' ELSE 'SHC_SAVANNAH' END AS DB, OFFICE_NUMBER::STRING AS LOCATION_CODE, OFFICE_NAME AS LOCATION_NAME, OFFICE_NUMBER,
		OFFICE_ADDRESS1, OFFICE_ADDRESS2, OFFICE_CITY, STATE, OFFICE_ZIP,
		COALESCE(DATE_CREATED, '1/1/1900') AS DATE_CREATED, ETL_LAST_UPDATED_DATE
	FROM HAH_OFFICES
	WHERE OFFICE_NUMBER NOT IN (SELECT DISTINCT HAH_OFFICE_NUMBER FROM COASTAL_OFFICE_MAPPING WHERE HAH_OFFICE_NUMBER IS NOT NULL)
),  EMPLOYEES AS 
(
	SELECT *,TO_DATE('1900-01-01', 'YYYY-MM-DD') AS EFFECTIVE_FROM_DATE, TO_DATE('9999-12-31', 'YYYY-MM-DD') AS EFFECTIVE_TO_DATE 
	FROM 
	(
		SELECT 
			TRIM(DB) AS MASTER_DB, 
			TRIM(NURSE_ID) AS MASTER_NURSE_ID,
			TRIM(DB) AS DB, 
			TRIM(NURSE_ID) AS NURSE_ID ,
			ETL_LAST_UPDATED_DATE,
			LAST_PAYMENT_DATE AS EMPLOYEE_LAST_CHECK_DATE,
			LAST_NAME AS EMPLOYEE_LAST_NAME,
			FIRST_NAME AS EMPLOYEE_FIRST_NAME,
			MD5( TRIM( DB) || '-' || UPPER( TRIM( Nurse_ID)) || '-' || 'COSTALSYNCDATA') AS EMPLOYEE_KEY
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST
	) 
	UNION
	SELECT *,TO_DATE('1900-01-01', 'YYYY-MM-DD') AS EFFECTIVE_FROM_DATE, TO_DATE('9999-12-31', 'YYYY-MM-DD') AS EFFECTIVE_TO_DATE 
	FROM 
	(
		SELECT 
            TRIM(MASTER.DB) AS MASTER_DB, 
            TRIM(MASTER.NURSE_ID) AS MASTER_NURSE_ID, 
            TRIM(MATCH.DB) AS DB, 
            TRIM(MATCH.NURSE_ID) AS NURSE_ID,
			MATCH.ETL_LAST_UPDATED_DATE,
			LAST_PAYMENT_DATE AS EMPLOYEE_LAST_CHECK_DATE,
			MATCH.LAST_NAME AS EMPLOYEE_LAST_NAME,
			MATCH.FIRST_NAME AS EMPLOYEE_FIRST_NAME,
			MD5( TRIM( MATCH.DB) || '-' || UPPER( TRIM( MATCH.Nurse_ID)) || '-' || 'COSTALSYNCDATA') AS EMPLOYEE_KEY
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.EMPLOYEE_MATCH_LIST AS MATCH
        JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST AS MASTER
            ON MASTER.MASTER_ID = MATCH.MASTER_ID
        WHERE MATCH.ID <> MATCH.MASTER_ID
	)
) ,
RESULTS AS (
	SELECT --MD5( TRIM( loc.DB) || '-' || '1' || '-' || TRIM( loc.Location_Code) || '-' || TRIM( loc.Location_Name) || '-' || 'CostalSyncData') AS Branch_Key,
		MD5( TRIM( loc.DB) || '-' || TRIM( loc.Location_Code) || '-' || 'COSTALSYNCDATA') AS Branch_Key,
	       TRIM( loc.Location_Name) AS Branch_Name,
	       TRIM( loc.DB) AS System_Code,
	       CASE TRIM(UPPER( loc.DB)) WHEN 'SHC_ALTRUS' THEN 1 WHEN 'SHC_SAVANNAH' THEN 2 ELSE -1 END AS Source_System_ID,
	       COALESCE(CAST( t.HAH_OFFICE_NUMBER AS INTEGER), loc.OFFICE_NUMBER) AS Office_Number,
	       TRIM( loc.Location_Code) AS Office_Code, 
	       UPPER( TRIM( loc.Location_Name)) AS Office_Name,
	       UPPER( TRIM( loc.Location_Name)) AS Office_Name_Alt,
		   UPPER( TRIM( loc.Location_Name)) AS Department_Name,
	       CASE WHEN UPPER( loc.DB) LIKE '%ALTRUS%' THEN 'CLS' ELSE 'HC' END AS Branch_Service_Line,
	--       NVL( TRIM( UPPER( lhier.Description)), TRIM( loc.Location_Name)) AS Location_Description,
	       CASE WHEN TRIM( lhier.Office) IS NULL  THEN TRIM( loc.Location_Code)
	            WHEN UPPER( TRIM( lhier.Office)) = 'OBSOLETE' THEN TRIM( loc.Location_Code)
	            WHEN TRIM( UPPER( lhier.Office)) LIKE TRIM( UPPER( loc.Location_Name)) THEN TRIM( loc.Location_Code)
	            WHEN TRIM( UPPER( loc.Location_Name)) IN ( 'TANGLEWOOD - ALTRUS I CLA', 'CAG LOCATION', 'WATSON MANOR', 'WAVERLY GARDENS', 'CAMDEN PLACE', 'WISTERIA GARDENS', '59TH STREET', 'TEBEAU HOUSE') THEN TRIM( loc.Location_Code)
	            ELSE COALESCE(TRIM( UPPER( lhier.Office)), TRIM( loc.Location_Code))
	       END AS Parent_Office_Code_2,
	       CASE WHEN TRIM( loc.Location_Code) = Parent_Office_Code_2 THEN TRUE
	            ELSE FALSE
	       END AS Parent_Flag,
	       COALESCE(po.Parent_Branch_Key, MD5( TRIM( loc.DB) || '-' || TRIM( Parent_Office_Code_2) || '-' || 'COSTALSYNCDATA')) AS Parent_Branch_Key,
	       po.PARENT_OFFICE_NUMBER,
   	       IFF(LEN(NVL(TRIM( po.Office_State_Code), '')) = 2, TRIM(po.Office_State_Code), 'GA') || ' - ' || TRIM(po.PARENT_BRANCH_NAME) || ' (' || COALESCE(po.PARENT_OFFICE_NUMBER, -1) || '-' || TRIM(po.PARENT_OFFICE_CODE) || ')' AS PARENT_BRANCH_NAME,
	       TRIM( loc.Address) AS Office_Address1, TRIM( loc.Street_Name) AS Office_Address2, 
	       TRIM( loc.City) AS Office_City, 
	       IFF(LEN(NVL(TRIM( loc.State_Code), '')) = 2, TRIM(loc.State_Code), COALESCE(off.STATE, 'GA')) AS Office_State_Code, 
	       TRIM( loc.ZipCode) AS Office_Zip,
	       off.OFFICE_PHONE, off.OFFICE_TOLL_FREE_PHONE, off.OFFICE_FAX,
	       IFF(LEN(NVL(TRIM( loc.State_Code), '')) = 2, TRIM(loc.State_Code), COALESCE(off.STATE, 'GA')) || ' - ' || TRIM(loc.LOCATION_NAME) || ' (' || COALESCE(CAST( t.HAH_OFFICE_NUMBER AS INTEGER), loc.OFFICE_NUMBER) || '-' || TRIM(loc.LOCATION_CODE) || ')' AS DETAILED_OFFICE_NAME,
		   REGIONS.REGIONNUMBER AS REGION_NUMBER,
		   TRIM(REGIONS.NAME) AS REGION_NAME,
		   UPPER(TRIM(COALESCE(REGIONAL_EMPLOYEE.EMPLOYEE_FIRST_NAME || ' ' || REGIONAL_EMPLOYEE.EMPLOYEE_LAST_NAME, REGIONS.MANAGER))) AS REGION_MANAGER, 
		   REGIONAL_EMPLOYEE.EMPLOYEE_KEY AS REGION_MANAGER_EMPLOYEE_KEY,
		   CAST(NULL AS VARCHAR(10)) AS SUBREGION_NAME,
		   UPPER(TRIM(COALESCE(PRIMARY_MANAGER.EMPLOYEE_FIRST_NAME || ' ' || PRIMARY_MANAGER.EMPLOYEE_LAST_NAME, off.OfficeManager1))) AS Primary_Branch_Manager_Name, 
		   COALESCE(BRANCH_MANAGERS.PRIMARY_BRANCH_EMAIL, off.PRIMARY_BRANCH_EMAIL) AS PRIMARY_BRANCH_EMAIL,
		   PRIMARY_MANAGER.EMPLOYEE_KEY AS PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY,
		   UPPER(TRIM(COALESCE(SECONDARY_MANAGER.EMPLOYEE_FIRST_NAME || ' ' || SECONDARY_MANAGER.EMPLOYEE_LAST_NAME, off.OfficeManager2))) AS Secondary_Branch_Manager_Name,
		   COALESCE(BRANCH_MANAGERS.SECONDARY_BRANCH_EMAIL, off.SECONDARY_BRANCH_EMAIL) AS SECONDARY_BRANCH_EMAIL,
		   SECONDARY_MANAGER.EMPLOYEE_KEY AS SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY,
	       CAST( loc.Entry_Date AS DATE) AS EFFECTIVE_FROM_DATE, --Entry_Date, 
		   CAST ('9999-12-31' AS DATE) AS EFFECTIVE_TO_DATE,
	       h.NODE_KEY AS RiskConnect_Node_Key,
	       h.NODE_CODE AS RiskConnect_Office_Code,
	       h.NODE_NAME AS RiskConnect_Name,
	       hr.HR_Office_Number,
	       hr.HR_Office_Name,
	      CASE WHEN UPPER( TRIM( lhier.Office)) = 'OBSOLETE' THEN FALSE
	            ELSE TRUE
	       END AS Active_Flag,
		ROW_NUMBER() OVER(PARTITION BY loc.DB, loc.LOCATION_CODE 
			ORDER BY REGIONAL_EMPLOYEE.EMPLOYEE_LAST_CHECK_DATE DESC,
				PRIMARY_MANAGER.EMPLOYEE_LAST_CHECK_DATE DESC,
				SECONDARY_MANAGER.EMPLOYEE_LAST_CHECK_DATE DESC
			) AS ROW_NUMBER
	FROM OFFICE_LIST loc
	LEFT JOIN (
		SELECT TRIM(LOCATION_CODE) AS LOCATION_CODE, COUNT(*) AS NUMBER_OF_LOCATION_CODES
		FROM OFFICE_LIST L
		GROUP BY TRIM(LOCATION_CODE)
	) loc_count ON TRIM(loc_count.LOCATION_CODE) = TRIM(loc.LOCATION_CODE)
	LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_LocationOfficeBreakdown AS lhier ON TRIM( loc.DB) = TRIM( lhier.DB) AND TRIM( loc.Location_Code) = TRIM( lhier.LocationCode)
	LEFT OUTER JOIN Parent_Offices AS po 
	             ON po.Parent_System_Code = TRIM( loc.DB)
	            AND CASE WHEN TRIM( lhier.Office) IS NULL  THEN TRIM( loc.Location_Code)
	                     WHEN UPPER( TRIM( lhier.Office)) = 'OBSOLETE' THEN TRIM( loc.Location_Code)
	                     WHEN TRIM( UPPER( lhier.Office)) LIKE TRIM( UPPER( loc.Location_Name)) THEN TRIM( loc.Location_Code)
	                     WHEN TRIM( UPPER( loc.Location_Name)) IN ( 'TANGLEWOOD - ALTRUS I CLA', 'CAG LOCATION', 'WATSON MANOR', 'WAVERLY GARDENS', 'CAMDEN PLACE', 'WISTERIA GARDENS', '59TH STREET', 'TEBEAU HOUSE') THEN TRIM( loc.Location_Code)
	                     ELSE TRIM( UPPER( lhier.Office))
	                END = po.Parent_Office_Code
	--LEFT OUTER JOIN Offices AS off ON UPPER( off.Office_Name) = UPPER( TRIM( loc.Location_Name))
	LEFT OUTER JOIN COASTAL_OFFICE_MAPPING AS t On TRIM( t.DB) = TRIM( loc.DB) AND TRIM( t.LOCATION_CODE) = TRIM( loc.Location_Code)
	LEFT JOIN HAH_OFFICES AS off ON off.OFFICE_NUMBER = t.HAH_OFFICE_NUMBER
	LEFT OUTER JOIN RISKCONNECT_HIERARCHY AS h 
		ON h.STATE = COALESCE(NULLIF(TRIM( loc.State_Code), ''), off.STATE) AND h.PARENT_LEVEL = 2
			-- If SC, h.OFFICE_CODE is Numeric office number; else for GA, it is alphanumeric location code	
			AND TRIM( h.OFFICE_CODE) = IFF(TRIM(loc.STATE_CODE) <> 'SC', TRIM( loc.Location_Code), off.OFFICE_NUMBER::STRING)
			-- If the same location_code/office_code exists across both DBs, then use SHC_SAVANNAH
			AND (loc_count.NUMBER_OF_LOCATION_CODES = 1 OR TRIM(loc.DB) = 'SHC_SAVANNAH')
	LEFT OUTER JOIN HR_OFFICE_MAPPING AS hr 
		ON TRIM( hr.OFFICE_CODE) = TRIM( loc.Location_Code) AND TRIM( hr.STATE) IN ('GA', 'SC')
			-- If the same location_code/office_code exists across both DBs, then use SHC_SAVANNAH
			AND (loc_count.NUMBER_OF_LOCATION_CODES = 1 OR TRIM(loc.DB) = 'SHC_SAVANNAH')
	JOIN HAH.DIM_STATE AS STATES 
		ON STATES.STATE_ISO_CODE = IFF(LEN(NVL(TRIM( loc.State_Code), '')) = 2, TRIM(loc.State_Code), COALESCE(off.STATE, 'GA'))
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.BI_REPOSITORY.KMREGIONS AS REGIONS
		ON CASE WHEN UPPER( STATES.State_Name) = 'GEORGIA' THEN 'GEORGIA/SOUTH CAROLINA'
				WHEN UPPER( STATES.State_Name) = 'SOUTH CAROLINA' THEN 'GEORGIA/SOUTH CAROLINA'
				WHEN UPPER( STATES.State_Name) = 'MICHIGAN' THEN 'DD/MICHIGAN'
				WHEN UPPER( STATES.State_Name) = 'KANSAS' THEN 'MISSOURI' 
				WHEN UPPER( STATES.State_Name) = 'IOWA' THEN 'ILLINOIS - NORTH' 
				WHEN UPPER( STATES.State_Name) = 'MISSISSIPPI' THEN 'MISSISSIPPI/TENNESSEE'
				WHEN UPPER( STATES.State_Name) = 'TENNESSEE' THEN 'MISSISSIPPI/TENNESSEE'
				ELSE UPPER( STATES.State_Name) END = REGIONS.NAME
	LEFT JOIN EMPLOYEES AS REGIONAL_EMPLOYEE 
		ON REGIONAL_EMPLOYEE.DB='SHC_SAVANNAH' AND REGIONAL_EMPLOYEE.NURSE_ID = TRIM(REGIONS.MANAGEREMPLOYEEID)
			-- AND REGIONAL_EMPLOYEE.ACTIVE_EMPLOYEE_FLAG = TRUE AND REGIONAL_EMPLOYEE.EMPLOYEE_CATEGORY IN ('Admin', 'Corp')
	LEFT JOIN HAH.FACT_BRANCH_MANAGER_MAPPING AS BRANCH_MANAGERS
		ON BRANCH_MANAGERS.OFFICE_SYSTEM_CODE = loc.DB AND BRANCH_MANAGERS.OFFICE_CODE = loc.LOCATION_CODE 
	LEFT JOIN EMPLOYEES AS PRIMARY_MANAGER
		ON PRIMARY_MANAGER.DB='SHC_SAVANNAH'
			AND PRIMARY_MANAGER.NURSE_ID = BRANCH_MANAGERS.PRIMARY_MANAGER_EMPLOYEE_ID
			-- AND PRIMARY_MANAGER.ACTIVE_EMPLOYEE_FLAG = TRUE AND PRIMARY_MANAGER.EMPLOYEE_CATEGORY IN ('Admin', 'Corp')
	LEFT JOIN EMPLOYEES AS SECONDARY_MANAGER
		ON SECONDARY_MANAGER.DB='SHC_SAVANNAH' 
			AND SECONDARY_MANAGER.NURSE_ID = BRANCH_MANAGERS.SECONDARY_MANAGER_EMPLOYEE_ID
			-- AND SECONDARY_MANAGER.ACTIVE_EMPLOYEE_FLAG = TRUE AND SECONDARY_MANAGER.EMPLOYEE_CATEGORY IN ('Admin', 'Corp')
	WHERE NOT ((TRIM(loc.DB) = 'SHC_ALTRUS' AND TRIM(loc.LOCATION_CODE) IN ('*RE'))
		OR (TRIM(loc.DB) = 'SHC_SAVANNAH' AND TRIM(loc.LOCATION_CODE) IN ('YYY', 'ZIN', '*TE')))
		AND (loc.ETL_LAST_UPDATED_DATE >= '1900-01-01'::timestamp_ntz 
		OR lhier.ETL_LAST_UPDATED_DATE >= '1900-01-01'::timestamp_ntz 
		OR t.ETL_LAST_UPDATED_DATE >= '1900-01-01'::timestamp_ntz 
		OR off.ETL_LAST_UPDATED_DATE >= '1900-01-01'::timestamp_ntz 
		OR h.ETL_LAST_UPDATED_DATE >= '1900-01-01'::timestamp_ntz 
		OR hr.ETL_LAST_UPDATED_DATE >= '1900-01-01'::timestamp_ntz 
		OR REGIONS.ETL_LAST_UPDATED_DATE >= '1900-01-01'::timestamp_ntz 
		OR REGIONAL_EMPLOYEE.ETL_LAST_UPDATED_DATE >= '1900-01-01'::timestamp_ntz 
		OR BRANCH_MANAGERS.ETL_LAST_UPDATED_DATE >= '1900-01-01'::timestamp_ntz 
		OR PRIMARY_MANAGER.ETL_LAST_UPDATED_DATE >= '1900-01-01'::timestamp_ntz 
		OR SECONDARY_MANAGER.ETL_LAST_UPDATED_DATE >= '1900-01-01'::timestamp_ntz)
) 
SELECT RESULTS.BRANCH_KEY
	FROM RESULTS AS RESULTS	
	WHERE RESULTS.ROW_NUMBER = 1
		AND RESULTS.OFFICE_NUMBER IS NOT NULL;
SQL
	or_replace = true 
	is_secure = false 
}

