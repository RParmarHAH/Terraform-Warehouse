resource "snowflake_procedure" "DW_HAH_GET_STAGE_COSTALSYNCDATA_DIM_EMPLOYEE" {
	name ="GET_STAGE_COSTALSYNCDATA_DIM_EMPLOYEE"
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
    return_result VARCHAR;
BEGIN
    --******************************************************************************************************************************************
-- NAME:  CostalSyncData_DIM_EMPLOYEE
--
-- PURPOSE: Creates one row per employee_id/database according to CoastalSnyc (combination of SHC_ALTRUS and SHC_SAVANNAH)
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -------------------------------------------------------------------------------------------------------        
-- 01/06/20    Greg Marsh            Initial development
-- 04/01/20    Mohd Kamaludin	     Added CDC
-- 04/06/20    Mohd Kamaludin	     Updated Employee Key for GpAllEmployeesBase
-- 10/20/20    Frank Noordover	     Revised Logic to use CV and GP coastal tables, include additional attributes and improve data quality
-- 10/22/20    Frank Noordover       Revised logic and added additional columns for DIM_EMPLOYEE     
-- 01/18/21    Mir Ali               Updated to assign Branch_Key for Coastal GP Employees (lower half of union query)
-- 02/08/21    Frank Noordover       Revised CV_Employee/GPAllEmployeesBase matching logic to use Data_Quality.CV_Employees_Coastal_Great_Plains_Mapping
-- 02/13/21    Frank Noordover       Revised Great Plains date logic to set invalid dates to NULL
-- 07/27/21    Alex Marianyi         Updated to bring in GP location in CV part of query
-- 03/10/22    Jashvant Patel        Updated Logic for SSN, DOB, FNAME and LNAME to pull from Greatplains first
-- 11/10/2023  Trushali Ramoliya     Added a  logic for HISPANIC_OR_LATINO COLUMN and update the logic for ethnicity as per ticket - IDDOX- 388.
--******************************************************************************************************************************************
--
-- Build DIM_Employee for Coastal based on CV_Employees
--
--truncate table STAGE.CostalSyncData_DIM_EMPLOYEE
INSERT OVERWRITE INTO STAGE.CostalSyncData_DIM_EMPLOYEE
WITH Emp_Latest_Updates AS
(
SELECT TRIM( UPPER( cve.DB)) AS DB, 
       TRIM( UPPER( cve.Nurse_ID)) AS Nurse_ID, 
       MAX( NVL( cve.Dex_Row_ID, -999)) AS Row_ID
FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST AS cve
GROUP BY 1, 2
),
CVE_Emp_Record AS
(
SELECT TRIM( UPPER( cve.DB)) AS DB, 
       TRIM( UPPER( cve.Nurse_ID)) AS Nurse_ID,
       TRIM( UPPER( cve.Social_Security_Number)) AS Social_Security_Number,
       TRIM( UPPER( cve.Location_Code)) AS Location_Code,
       MAX( Dex_Row_ID) AS Row_ID
FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST AS cve
INNER JOIN Emp_Latest_Updates AS elu ON elu.DB = TRIM( UPPER( cve.DB)) AND elu.Nurse_ID = TRIM( UPPER( cve.Nurse_ID)) AND TRIM( NVL( cve.Dex_Row_ID, -999)) = elu.Row_ID
GROUP BY 1, 2, 3, 4
),
Distinct_CVE_emp AS
(
SELECT DISTINCT 
MD5( TRIM (cve.DB) || ''-'' ||UPPER((TRIM(regexp_replace(MASTER_ID,cve.DB)))) || ''-'' || ''COSTALSYNCDATA'') AS Employee_Key,
       UPPER( TRIM( cve.Nurse_ID)) AS Employee_ID, -- TRIM( gpe.Employee_ID), 
       TRIM( cve.DB) AS System_Code, --cve.User_Code, 
       CASE WHEN TRIM( cve.DB) LIKE ''%SAVANNAH%'' THEN 2 ELSE 1 END AS Source_System_ID,
       CASE WHEN TRIM( cve.Social_Security_Number) IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) THEN CAST( NULL AS VARCHAR)
            WHEN TRIM( cve.Social_Security_Number) = ''NULL'' OR TRIM( cve.Social_Security_Number) = '''' THEN CAST( NULL AS VARCHAR) 
            ELSE TRIM( cve.Social_Security_Number) 
       END AS Social_Security_Number,
       TRIM( UPPER( cve.First_Name)) AS First_Name,
       TRIM( UPPER( cve.Last_Name)) AS Last_Name,
       TRIM( UPPER( cve.Last_Name))||'', ''||TRIM( UPPER( cve.First_Name)) AS Employee_Name,
       cer.DB,
       cer.Location_Code AS Office_Code,
       cer.Row_ID,
       Employee_Name||'', ''||cer.DB||'', ''||Office_Code AS Unique_Name
FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST AS cve
INNER JOIN CVE_Emp_Record AS cer ON cer.DB = TRIM( UPPER( cve.DB)) AND cer.Nurse_ID = TRIM( UPPER( cve.Nurse_ID)) AND  cve.Dex_Row_ID = cer.Row_ID
),
Find_Latest_Changes AS
(
SELECT MAX( cve.ETL_Last_Updated_Date) AS Date_to_Start_Processing
FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST AS cve
INNER JOIN CVE_Emp_Record AS cer ON cer.DB = TRIM( UPPER( cve.DB)) AND cer.Nurse_ID = TRIM( UPPER( cve.Nurse_ID)) AND cve.Dex_Row_ID = cer.Row_ID
),
Employee as 
(
    SELECT *
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST
	--	WHERE FIRST_NAME LIKE ''%PAULA%'' AND LAST_NAME LIKE ''%DAVIS%''
),
FIELD_VISITS AS (
	SELECT SOURCE_SYSTEM_ID, SYSTEM_CODE, EMPLOYEE_ID, MAX(ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
	FROM HAH.FACT_VISIT
	WHERE SOURCE_SYSTEM_ID IN (1, 2) AND CONFIRMED_FLAG =''YES''
	--STATUS_CODE IN (''02'', ''03'', ''04'', ''05'')
	GROUP BY SOURCE_SYSTEM_ID, SYSTEM_CODE, EMPLOYEE_ID 
),
Great_Plains_Employees_Distinct_SSN AS
(
SELECT gpe.DB, gpe.SSN, 
       MAX( NVL( gpe.Terminate_Date, CURRENT_DATE)) AS Terminate_Date
FROM DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GPAllEmployeesBase AS gpe
WHERE TRIM( UPPER( gpe.DB)) || TRIM( UPPER( gpe.Employee_ID)) || TRIM( gpe.SSN) NOT IN (SELECT TRIM( UPPER( gpe2.DB)) || TRIM( UPPER( gpe2.Employee_ID)) || TRIM(gpe2.SSN) FROM DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GPAllEmployeesBase AS gpe2 WHERE TRIM( UPPER( gpe2.Reason_to_Term)) LIKE ANY ( ''%DUPLICATE%PROFILE%'', ''%WRONG%ID%'', ''%CODE%IN%USE%'', ''%WRONG%CODE%''))
GROUP BY gpe.DB, gpe.SSN
),
Great_Plains_Employees AS
(
SELECT CASE WHEN TRIM( gpe.DB) = ''SHC'' THEN ''SHC_SAVANNAH'' ELSE ''SHC_ALTRUS'' END AS DB, 
       gpe.Employee_ID, gpe.SSN, 
       IFF( gpe.DOB=CAST( ''1900-01-01'' AS DATE), NULL, gpe.DOB) AS DOB, 
       CASE WHEN gpe.Hire_Date < CAST( ''1950-01-01'' AS DATE) OR gpe.Hire_Date > DATEADD( ''YEAR'', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.Hire_Date
       END AS Hire_Date, 
       CASE WHEN gpe.Benefit_Start_Date < CAST( ''1950-01-01'' AS DATE) OR gpe.Benefit_Start_Date > DATEADD( ''YEAR'', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.Benefit_Start_Date
       END AS Benefit_Start_Date, 
       CASE WHEN gpe.First_Check_Date < CAST( ''1950-01-01'' AS DATE) OR gpe.First_Check_Date > DATEADD( ''YEAR'', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.First_Check_Date
       END AS First_Check_Date, 
       CASE WHEN gpe.Last_Check_Date < CAST( ''1950-01-01'' AS DATE) OR gpe.Last_Check_Date > DATEADD( ''YEAR'', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.Last_Check_Date
       END AS Last_Check_Date, 
       CASE WHEN gpe.Last_Day_Worked < CAST( ''1950-01-01'' AS DATE) OR gpe.Last_Day_Worked > DATEADD( ''YEAR'', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.Last_Day_Worked
       END AS Last_Day_Worked, 
       CASE WHEN gpe.Terminate_Date < CAST( ''1950-01-01'' AS DATE) OR gpe.Terminate_Date > DATEADD( ''YEAR'', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.Terminate_Date
       END AS Terminate_Date, 
       gpe.Reason_to_Term, 
       TRIM( UPPER( gpe.First_Name)) AS First_Name, 
       TRIM( UPPER( gpe.Middle_Name)) AS Middle_Name, 
       TRIM( UPPER( gpe.Last_Name)) AS Last_Name, 
       TRIM( gpe.Address1) AS Address1, 
       TRIM( gpe.Address2) AS Address2, 
       TRIM( gpe.Address3) AS Address3, 
       TRIM( gpe.City) AS City, 
       TRIM( UPPER( gpe.State)) AS State, gpe.Zip,
       gpe.Phone_Number, gpe.Phone_Number_2,
       gpe.Gender, gpe.Ethics, gpe.Ethics_Code, gpe.Marital_Status_Text, gpe.Employment_Type_Text, gpe.Is_Admin,
       gpe.Job_Title, gpe.Job_Description, gpe.Class_ID, gpe.Workers_Comp,
       gpe.SUTA_State, gpe.Department, gpe.InActive,
       gpe.ETL_Last_Updated_Date,
       comp.System_Code, comp.Office_Code
FROM DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GPAllEmployeesBase AS gpe
INNER JOIN DISC_${var.SF_ENVIRONMENT}.Stage.Coastal_Office_Mapping_Payroll AS comp ON comp.DB = gpe.DB AND comp.Department = gpe.Department
INNER JOIN Great_Plains_Employees_Distinct_SSN AS gpssn ON gpssn.DB = gpe.DB AND gpssn.SSN = gpe.SSN AND NVL( gpssn.Terminate_Date, CURRENT_DATE) = NVL( gpe.Terminate_Date, CURRENT_DATE)
WHERE gpe.SSN NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN)
AND TRIM( UPPER( gpe.DB)) || TRIM( UPPER( gpe.Employee_ID)) || TRIM( gpe.SSN) NOT IN (SELECT TRIM( UPPER( gpe2.DB)) || TRIM( UPPER( gpe2.Employee_ID)) || TRIM(gpe2.SSN) FROM DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GPAllEmployeesBase AS gpe2 WHERE TRIM( UPPER( gpe2.Reason_to_Term)) LIKE ANY ( ''%DUPLICATE%PROFILE%'', ''%WRONG%ID%'', ''%CODE%IN%USE%'', ''%WRONG%CODE%''))
)	
SELECT DISTINCT 
MD5( TRIM (cve.DB) || ''-'' ||UPPER((TRIM(regexp_replace(MASTER_ID,cve.DB)))) || ''-'' || ''COSTALSYNCDATA'') AS Employee_Key,
       UPPER( TRIM( cve.Nurse_ID)) AS Employee_ID, 
      -- GPE.SSN, GPE.DOB,cve.Social_Security_Number, cve.BIRTH_DATE,
       TRIM( cve.DB) AS System_Code, --cve.User_Code, 
       CASE WHEN TRIM( cve.DB) LIKE ''%SAVANNAH%'' THEN 2 ELSE 1 END AS Source_System_ID,
       CASE WHEN TRIM( COALESCE (GPE.SSN,cve.Social_Security_Number)) NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) AND TRIM(COALESCE (GPE.SSN,cve.Social_Security_Number)) NOT LIKE ''00000%'' AND LENGTH( TRIM(COALESCE (GPE.SSN,cve.Social_Security_Number))) = 9 THEN HEX_ENCODE( TRIM(COALESCE (GPE.SSN,cve.Social_Security_Number)))
            ELSE NULL
       END AS EMPLOYEE_PID,
       NULL AS Employee_Number,
       CASE WHEN CAST( COALESCE (GPE.DOB,cve.BIRTH_DATE)AS DATE) < CAST( ''1901-01-01'' AS DATE) OR CAST(COALESCE (GPE.DOB,cve.BIRTH_DATE)AS DATE) > DATEADD( YEAR, -12, CURRENT_DATE) THEN NULL
            ELSE CAST( COALESCE (GPE.DOB,cve.BIRTH_DATE) AS DATE)
       END AS EMPLOYEE_DOB,
       NULL AS EMPLOYEE_DATE_OF_DEATH,
       CASE WHEN CAST( cve.Hire_Date AS DATE) < CAST( ''1960-01-01'' AS DATE) OR CAST( cve.Hire_Date AS DATE) > DATEADD( YEAR, +1, CURRENT_DATE) OR CAST( cve.HIRE_DATE AS DATE) <= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN NULL
            ELSE CAST( cve.Hire_Date AS DATE)
       END AS EMPLOYEE_HIRE_DATE,
       NULL AS Employee_Rehire_Date, 
	   --NOT AVAILALBE IN EMPLOYEE_MASTER_LIST
       --CASE WHEN CAST( gpe.BENEFIT_START_DATE AS DATE) < CAST( ''1960-01-01'' AS DATE) OR CAST( gpe.Benefit_Start_Date AS DATE) > DATEADD( YEAR, +1, CURRENT_DATE) OR CAST( gpe.BENEFIT_START_DATE AS DATE) <= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN NULL
       --     ELSE CAST( gpe.BENEFIT_START_DATE AS DATE)
       --END AS Employee_Benefit_Start_Date,
	   NULL AS Employee_Benefit_Start_Date,
       CASE WHEN CAST( cve.FIRST_PAYMENT_DATE AS DATE) < CAST( ''1960-01-01'' AS DATE) OR cve.FIRST_PAYMENT_DATE > DATEADD( YEAR, +1, CURRENT_DATE) OR cve.FIRST_PAYMENT_DATE <= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN NULL
            ELSE CAST( cve.FIRST_PAYMENT_DATE AS DATE)
       END AS Employee_First_Check_Date,
       CASE WHEN CAST( cve.LAST_PAYMENT_DATE AS DATE) < CAST( ''1960-01-01'' AS DATE) OR CAST( cve.LAST_PAYMENT_DATE AS DATE) > DATEADD( YEAR, +1, CURRENT_DATE) OR CAST( cve.LAST_PAYMENT_DATE AS DATE) <= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN NULL
            ELSE CAST( cve.LAST_PAYMENT_DATE AS DATE)
       END AS Employee_Last_Check_Date,
	   --NOT AVAILALBE IN EMPLOYEE_MASTER_LIST
       --CASE WHEN CAST( gpe.LAST_DAY_WORKED AS DATE) < CAST( ''1960-01-01'' AS DATE) OR CAST( gpe.Last_Day_Worked AS DATE) > DATEADD( YEAR, +1, CURRENT_DATE) OR CAST( gpe.Last_Day_Worked AS DATE) <= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) AND CAST( gpe.Last_Day_Worked AS DATE) <= NVL( Employee_Hire_Date, CAST( ''1960-01-01'' AS DATE)) THEN NULL
       --     ELSE CAST( gpe.LAST_DAY_WORKED AS DATE)
       --END AS Employee_Last_Worked_Date,
	   NULL AS Employee_Last_Worked_Date,
       CASE WHEN CAST( cve.TERMINATION_DATE AS DATE) < CAST( ''1960-01-01'' AS DATE) OR CAST( cve.TERMINATION_DATE AS DATE) > DATEADD( YEAR, +1, CURRENT_DATE) OR CAST( cve.TERMINATION_DATE AS DATE) <= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE)))  AND CAST( cve.TERMINATION_DATE AS DATE) <= NVL( Employee_Hire_Date, CAST( ''1960-01-01'' AS DATE)) THEN NULL
            ELSE CAST( cve.TERMINATION_DATE AS DATE)
       END AS Employee_Terminate_Date,
       TRIM( UPPER( cve.TERMINATION_COMMENT)) AS Reason_To_Terminate,
	   --NOT AVAILALBE IN EMPLOYEE_MASTER_LIST
       --CASE WHEN gpe.InActive <> 0 THEN ''FALSE''
       --     ELSE ''TRUE''
       --END AS Active_Employee_Flag,
	   ''TRUE'' AS Active_Employee_Flag,
       NULL AS Able_To_Rehire_Flag,
       NULL AS Employee_Prefix,
       CASE WHEN TRIM( COALESCE (cve.FIRST_NAME, GPE.FIRST_NAME)) <> '''' AND TRIM(COALESCE (cve.FIRST_NAME, GPE.FIRST_NAME)) IS NOT NULL THEN TRIM( UPPER(COALESCE (cve.FIRST_NAME, GPE.FIRST_NAME)))
            ELSE NULL
       END AS Employee_First_Name,
       CASE WHEN TRIM( COALESCE (cve.MIDDLE_INITIAL, GPE.MIDDLE_NAME)) = '''' THEN NULL
            ELSE TRIM( UPPER( regexp_replace(COALESCE (cve.MIDDLE_INITIAL, GPE.MIDDLE_NAME),''\\\\\\\\d|\\\\\\\\.|\\\\\\\\+|\\\\\\\\,|\\\\\\\\-'','''')))
       END AS Employee_Middle_Name,
       CASE WHEN TRIM( COALESCE (cve.LAST_NAME, GPE.LAST_NAME)) <> '''' AND TRIM(COALESCE (cve.LAST_NAME, GPE.LAST_NAME)) IS NOT NULL THEN TRIM( UPPER(COALESCE (cve.LAST_NAME, GPE.LAST_NAME)))            
            ELSE NULL
       END AS Employee_Last_Name,
       NULL AS Employee_Suffix,
       CASE WHEN TRIM( UPPER( COALESCE (GPE.address1, cve.ADDRESS))) <> '''' AND TRIM( UPPER( COALESCE (GPE.address1, cve.ADDRESS))) IS NOT NULL THEN TRIM( UPPER( COALESCE (GPE.address1, cve.ADDRESS)))
            ELSE NULL
       END AS Employee_Address1, 
	   NULL AS Employee_Address2, 
       CASE WHEN UPPER( TRIM( COALESCE (GPE.city , cve.City))) <>  '''' AND UPPER( TRIM( COALESCE (GPE.city , cve.City))) IS NOT NULL THEN UPPER( TRIM( COALESCE (GPE.city , cve.City)))
            ELSE NULL
       END AS Employee_City,
       COALESCE (st.State_ISO_Code,GPE.state) AS EMPLOYEE_STATE_CODE,
       COALESCE (gpe.zip,zip.Zip_Code) AS Zip_Code,
       CASE WHEN TRIM( cve.Phone) <> '''' AND LENGTH( TRIM( cve.Phone)) = 10 AND TRY_TO_NUMBER( TRIM( cve.Phone)) > 0 AND TRIM( cve.Phone) NOT IN ( SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) THEN TRIM( cve.Phone)
            ELSE NULL
       END AS Employee_Home_Phone, --gpe.PHONE_NUMBER,
       CASE WHEN TRIM( cve.Work_Phone) <> '''' AND LENGTH( TRIM( cve.Work_Phone)) = 10 AND TRY_TO_NUMBER( TRIM( cve.Phone)) > 0 AND TRIM( cve.Work_Phone) NOT IN ( SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) THEN TRIM( cve.Work_Phone)
            ELSE NULL
       END AS Employee_Cell_Phone, --gpe.PHONE_NUMBER_2,
       CASE WHEN TRIM( cve.EMERGENCY_PHONE) <> '''' AND LENGTH( TRIM( cve.Emergency_Phone)) = 10 AND TRY_TO_NUMBER( TRIM( cve.Emergency_Phone)) > 0 AND TRIM( cve.Emergency_Phone) NOT IN ( SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) THEN TRIM( cve.EMERGENCY_PHONE)
            ELSE NULL
       END AS Employee_Work_Phone, 
       --cve.BEEPER_NUMBER,
       NULL AS Employee_Personal_Email,
       NULL AS Employee_Work_Email,
       NULL AS Linked_In_Profile_URL,
       CASE WHEN cve.SEX = 2 THEN ''FEMALE''
            WHEN cve.SEX = 1 THEN ''MALE''
			WHEN cve.SEX = 3 THEN ''N/A''
            ELSE NULL
       END AS Employee_Gender, 
       CASE WHEN TRIM(cve.ETHNICITY_LEVEL1) = ''N/A'' OR TRIM(cve.ETHNICITY_LEVEL1)= ''''  OR TRIM(cve.ETHNICITY_LEVEL1) ILIKE ANY (''%HISPANIC%'',''%LATINO%'') THEN NULL
            ELSE UPPER(TRIM(cve.ETHNICITY_LEVEL1))
       END AS Employee_Ethnicity, --gpe.ETHICS_CODE,
	   IFF(UPPER(TRIM(cve.ETHNICITY_LEVEL1)) IN (''HISPANIC'',''LATINO'',''HISPANIC OR LATINO''), TRUE, FALSE) AS HISPANIC_OR_LATINO,
	   NULL AS EMPLOYEE_LANGUAGE,
	   CASE 
		WHEN TRIM(MARITALSTATS_CODE) IN (''S'',''U'',''D'',''Sin'',''W'') THEN ''Single''
		WHEN TRIM(MARITALSTATS_CODE) IN (''Mar'',''M'') THEN ''Married''
		ELSE NULL END AS Employee_Marital_Status, 
       --Need the mapping
       NULL AS Employment_Type,
	   -- NEED THE CONFIRMATION
       --CASE WHEN NVL( gpe.IS_ADMIN, 0) <> 0 THEN ''Admin'' 
       --     ELSE ''Field'' 
       --END AS Employee_Category,
	   IFF(FIELD_VISITS.SYSTEM_CODE IS NULL, ''ADMIN'', ''FIELD'') AS Employee_Category,
       NULL AS Exempt_Flag,
       NULL AS JOB_TITLE,
	   cve.CB_JOB_DESCRIPTION AS JOB_DESCRIPTION,
	   NULL AS Class_ID,
	   NULL AS Workers_Comp,
       TRIM(GPE.EMPLOYEE_ID) AS Payroll_ID,
       NULL AS Percent_401k_Deduction,
       NULL AS Amount_401k_Deduction,
       NULL AS JazzHR_Applicant_ID,
       NULL AS JazzHR_User_ID,
       NULL AS JazzHR_Contact_ID,
       brnch.Office_State_Code AS Work_State,
       NULL AS SUTA_State,
       TRIM( cve.PRIMARY_DEPARTMENT) AS Employee_Department,
       TRIM( cve.LOCATION_CODE) AS Employee_Office_Code,
       brnch.Branch_Key AS Primary_Branch_Key,
       brnch.Office_State_Code AS Primary_Branch_State,
       brnch.Detailed_Office_Name AS Primary_Branch_Name,
       brnch.System_Code AS Primary_Branch_System_Code,
	   NULL AS CASE_MANAGER_FLAG,
	   NULL AS SUPERVISOR_FLAG,
	   NULL AS COORDINATOR_FLAG,
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
FROM Employee AS cve
LEFT OUTER JOIN Data_Management.Data_Quality.CV_Employees_Coastal_Great_Plains_Mapping AS cecgpm ON
	TRIM(cve.DB) = TRIM(cecgpm.CV_DB)
	AND TRIM(cve.Nurse_ID) = TRIM(cecgpm.CV_Nurse_ID)
LEFT OUTER JOIN Great_Plains_Employees AS gpe ON
	( TRIM(cecgpm.GP_DB) = TRIM(gpe.DB) OR TRIM(CVE.DB) = TRIM(GPE.DB) )
	AND ( TRIM(gpe.Employee_ID) = TRIM(cecgpm.GP_Employee_ID) OR trim(gpe.EMPLOYEE_ID) = trim(cve.NURSE_ID) )
--LEFT OUTER JOIN Great_Plains_Employees AS GP ON CVE.DB  = gpe.DB AND gpe.Employee_ID = TRIM(CVE.NURSE_SECONDARY_ID )   --- TRY WITH CVE.Nurse_ID 
LEFT OUTER JOIN HAH.DIM_Branch AS brnch ON
	UPPER( TRIM(cve.DB)) = brnch.System_Code
	AND brnch.Source_System_ID IN (1, 2)
	AND COALESCE( TRIM(gpe.Office_Code),
TRIM(cve.Location_Code)) = brnch.Office_Code
LEFT OUTER JOIN HAH.DIM_State AS st ON st.State_ISO_Code = UPPER( SUBSTRING(cve.STATE_CODE, 1, 2))
LEFT OUTER JOIN HAH.DIM_Zip_Code AS zip ON UPPER( zip.Zip_Code) = UPPER( SUBSTRING(cve.ZIPCODE, 1, 5))
LEFT OUTER JOIN FIELD_VISITS AS FIELD_VISITS
	ON TRIM(FIELD_VISITS.SYSTEM_CODE) = TRIM( cve.DB) -- System_Code 
       AND FIELD_VISITS.SOURCE_SYSTEM_ID = CASE WHEN TRIM( cve.DB) LIKE ''%SAVANNAH%'' THEN 2 ELSE 1 END -- Source_System_ID
       AND TRIM(FIELD_VISITS.EMPLOYEE_ID) = UPPER( TRIM( cve.Nurse_ID)) -- Employee_ID
 -- WHERE cve.FIRST_NAME like ''%SHELLY%'' AND cve.LAST_NAME LIKE ''%WAMBA%'';
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}

