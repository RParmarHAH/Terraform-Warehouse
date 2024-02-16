CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_COASTALGP_DIM_EMPLOYEE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result varchar(1000);
BEGIN

--******************************************************************************************************************************************
-- NAME:  CoastalGP_DIM_EMPLOYEE
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
-- 09/XX/21	   Alex Marianyi		 Broke out Coastal GP into own source system
-- 11/10/2023  Trushali Ramoliya     Added a logic for HISPANIC_OR_LATINO and update the logic for ethnicity as per ticket - IDDOX- 388.
--******************************************************************************************************************************************
--
-- Build DIM_Employee for Coastal based on CV_Employees
--
--truncate table STAGE.CoastalGP_DIM_EMPLOYEE
INSERT OVERWRITE INTO STAGE.CoastalGP_DIM_EMPLOYEE
WITH Emp_Latest_Updates AS
(
SELECT TRIM( UPPER( cve.DB)) AS DB, 
       TRIM( UPPER( cve.Nurse_ID)) AS Nurse_ID, 
       MAX( NVL( cve.Dex_Row_ID, -999)) AS Row_ID
FROM DISC_PROD.CostalSyncData.CV_Employees AS cve
GROUP BY 1, 2
),
CVE_Emp_Record AS
(
SELECT TRIM( UPPER( cve.DB)) AS DB, 
       TRIM( UPPER( cve.Nurse_ID)) AS Nurse_ID,
       TRIM( UPPER( cve.Social_Security_Number)) AS Social_Security_Number,
       TRIM( UPPER( cve.Location_Code)) AS Location_Code,
       MAX( Dex_Row_ID) AS Row_ID
FROM DISC_PROD.CostalSyncData.CV_Employees AS cve
INNER JOIN Emp_Latest_Updates AS elu ON elu.DB = TRIM( UPPER( cve.DB)) AND elu.Nurse_ID = TRIM( UPPER( cve.Nurse_ID)) AND TRIM( NVL( cve.Dex_Row_ID, -999)) = elu.Row_ID
GROUP BY 1, 2, 3, 4
),
Distinct_CVE_emp AS
(
SELECT DISTINCT MD5( TRIM( cve.DB) || ''-'' || UPPER( TRIM( cve.Nurse_ID)) || ''-'' || ''COSTALSYNCDATA'') AS Employee_Key,
       UPPER( TRIM( cve.Nurse_ID)) AS Employee_ID, 
       TRIM( cve.DB) AS System_Code, 
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
FROM DISC_PROD.CostalSyncData.CV_Employees AS cve
INNER JOIN CVE_Emp_Record AS cer ON cer.DB = TRIM( UPPER( cve.DB)) AND cer.Nurse_ID = TRIM( UPPER( cve.Nurse_ID)) AND  cve.Dex_Row_ID = cer.Row_ID
),
Great_Plains_Employees_Distinct_SSN AS
(
SELECT gpe.DB, gpe.SSN, 
       MAX( NVL( gpe.Terminate_Date, CURRENT_DATE)) AS Terminate_Date
FROM DISC_PROD.CostalSyncData.GPAllEmployeesBase AS gpe
WHERE TRIM( UPPER( gpe.DB)) || TRIM( UPPER( gpe.Employee_ID)) || TRIM( gpe.SSN) NOT IN (SELECT TRIM( UPPER( gpe2.DB)) || TRIM( UPPER( gpe2.Employee_ID)) || TRIM(gpe2.SSN) FROM DISC_PROD.CostalSyncData.GPAllEmployeesBase AS gpe2 WHERE TRIM( UPPER( gpe2.Reason_to_Term)) LIKE ANY ( ''%DUPLICATE%PROFILE%'', ''%WRONG%ID%'', ''%CODE%IN%USE%'', ''%WRONG%CODE%''))
GROUP BY gpe.DB, gpe.SSN
),
Great_Plains_Employees AS
(
SELECT TRIM( gpe.DB) AS DB, 
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
       gpe.EMAIL, gpe.PERSONAL_EMAIL,
       gpe.ETL_Last_Updated_Date,
       comp.System_Code, comp.Office_Code
FROM DISC_PROD.CostalSyncData.GPAllEmployeesBase AS gpe
INNER JOIN DISC_PROD.Stage.Coastal_Office_Mapping_Payroll AS comp ON comp.DB = gpe.DB AND comp.Department = gpe.Department
INNER JOIN Great_Plains_Employees_Distinct_SSN AS gpssn ON gpssn.DB = gpe.DB AND gpssn.SSN = gpe.SSN AND NVL( gpssn.Terminate_Date, CURRENT_DATE) = NVL( gpe.Terminate_Date, CURRENT_DATE)
WHERE gpe.SSN NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN)
AND TRIM( UPPER( gpe.DB)) || TRIM( UPPER( gpe.Employee_ID)) || TRIM( gpe.SSN) NOT IN (SELECT TRIM( UPPER( gpe2.DB)) || TRIM( UPPER( gpe2.Employee_ID)) || TRIM(gpe2.SSN) FROM DISC_PROD.CostalSyncData.GPAllEmployeesBase AS gpe2 WHERE TRIM( UPPER( gpe2.Reason_to_Term)) LIKE ANY ( ''%DUPLICATE%PROFILE%'', ''%WRONG%ID%'', ''%CODE%IN%USE%'', ''%WRONG%CODE%''))
),
Find_Latest_Changes AS
(
SELECT LEAST( MAX( cve.ETL_Last_Updated_Date), MAX( gpe.ETL_Last_Updated_Date)) AS Date_to_Start_Processing
FROM DISC_PROD.CostalSyncData.CV_Employees AS cve
INNER JOIN CVE_Emp_Record AS cer ON cer.DB = TRIM( UPPER( cve.DB)) AND cer.Nurse_ID = TRIM( UPPER( cve.Nurse_ID)) AND cve.Dex_Row_ID = cer.Row_ID
LEFT OUTER JOIN DISC_PROD.CostalSyncData.GPAllEmployeesBase AS gpe ON TRIM( cve.DB) = CASE WHEN TRIM( gpe.DB) = ''SHC'' THEN ''SHC_SAVANNAH'' ELSE ''SHC_ALTRUS'' END AND TRIM( cve.Nurse_ID) = TRIM( gpe.Employee_ID)
)
SELECT DISTINCT MD5( gpe.DB || ''-'' || UPPER( TRIM( gpe.Employee_ID)) || ''-'' || ''CoastalGP'') AS Employee_Key,
       TRIM( gpe.Employee_ID) AS Employee_ID, 
       UPPER(gpe.DB) AS System_Code, 
       11 AS Source_System_ID,
       CASE WHEN LENGTH( TRIM( gpe.SSN)) = 9 AND TRIM( gpe.SSN) NOT IN ( SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) AND TRIM( gpe.ssn) NOT LIKE ''00000%'' THEN HEX_ENCODE( TRIM( gpe.SSN))  
            ELSE NULL
       END AS EMPLOYEE_PID,
       NULL AS Employee_Number,
       CASE WHEN CAST( gpe.DOB AS DATE) >= CAST( ''1901-01-01'' AS DATE) AND CAST( gpe.DOB AS DATE) <= DATEADD( YEAR, -12, CURRENT_DATE) THEN CAST( gpe.DOB AS DATE)
            ELSE NULL
       END AS EMPLOYEE_DOB,
       NULL AS EMPLOYEE_DATE_OF_DEATH,
       CASE WHEN CAST( gpe.Hire_Date AS DATE) < CAST( ''1960-01-01'' AS DATE) OR CAST( gpe.Hire_Date AS DATE) > DATEADD( YEAR, +1, CURRENT_DATE) OR CAST( gpe.HIRE_DATE AS DATE) <= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN NULL
            ELSE CAST( gpe.Hire_Date AS DATE)
       END AS EMPLOYEE_HIRE_DATE,
       NULL AS Employee_Rehire_Date,
       CASE WHEN CAST( gpe.BENEFIT_START_DATE AS DATE) < CAST( ''1960-01-01'' AS DATE) OR CAST( gpe.Benefit_Start_Date AS DATE) > DATEADD( YEAR, +1, CURRENT_DATE) OR CAST( gpe.BENEFIT_START_DATE AS DATE) <= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN NULL
            ELSE CAST( gpe.BENEFIT_START_DATE AS DATE)
       END AS Employee_Benefit_Start_Date,
       CASE WHEN CAST( gpe.FIRST_CHECK_DATE AS DATE) < CAST( ''1960-01-01'' AS DATE) OR CAST( gpe.First_Check_Date AS DATE) > DATEADD( YEAR, +1, CURRENT_DATE) OR CAST( gpe.First_Check_Date AS DATE) <= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN NULL
            ELSE CAST( gpe.FIRST_CHECK_DATE AS DATE)
       END AS Employee_First_Check_Date,
       CASE WHEN CAST( gpe.LAST_CHECK_DATE AS DATE) < CAST( ''1960-01-01'' AS DATE) OR CAST( gpe.Last_Check_Date AS DATE) > DATEADD( YEAR, +1, CURRENT_DATE) OR CAST( gpe.Last_Check_Date AS DATE) <= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN NULL
            ELSE CAST( gpe.LAST_CHECK_DATE AS DATE)
       END AS Employee_Last_Check_Date,
       CASE WHEN CAST( gpe.LAST_DAY_WORKED AS DATE) < CAST( ''1960-01-01'' AS DATE) OR CAST( gpe.Last_Day_Worked AS DATE) > DATEADD( YEAR, +1, CURRENT_DATE) OR CAST( gpe.Last_Day_Worked AS DATE) <= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) AND CAST( gpe.Last_Day_Worked AS DATE) <= NVL( Employee_Hire_Date, CAST( ''1960-01-01'' AS DATE)) THEN NULL
            ELSE CAST( gpe.LAST_DAY_WORKED AS DATE)
       END AS Employee_Last_Worked_Date,
       CASE WHEN CAST( gpe.TERMINATE_DATE AS DATE) < CAST( ''1960-01-01'' AS DATE) OR CAST( gpe.Terminate_Date AS DATE) > DATEADD( YEAR, +1, CURRENT_DATE) OR CAST( gpe.Terminate_Date AS DATE) <= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) AND CAST( gpe.Terminate_Date AS DATE) <= NVL( Employee_Hire_Date, CAST( ''1960-01-01'' AS DATE)) THEN NULL
            ELSE CAST( gpe.TERMINATE_DATE AS DATE)
       END AS Employee_Terminate_Date,
       TRIM( UPPER( gpe.REASON_TO_TERM)) AS Reason_To_Terminate,
       CASE WHEN gpe.InActive <> 0 THEN ''FALSE''
            ELSE ''TRUE''
       END AS Active_Employee_Flag,
       NULL AS Able_To_Rehire_Flag,
       NULL AS Employee_Prefix,
       CASE WHEN TRIM( gpe.FIRST_NAME) = '''' THEN NULL
            ELSE TRIM( UPPER( gpe.FIRST_NAME))
       END AS Employee_First_Name,
       CASE WHEN TRIM( gpe.MIDDLE_NAME) = '''' THEN NULL
            ELSE TRIM( UPPER( regexp_replace( gpe.Middle_Name,''\\\\\\\\d|\\\\\\\\.|\\\\\\\\+|\\\\\\\\,|\\\\\\\\-'','''')))
       END AS Employee_Middle_Name,
       CASE WHEN TRIM( gpe.LAST_NAME) = '''' THEN NULL
            ELSE TRIM( UPPER( gpe.LAST_NAME))
       END AS Employee_Last_Name,
       NULL AS Employee_Suffix,
       CASE WHEN TRIM( UPPER( gpe.ADDRESS1)) = '''' THEN NULL
            ELSE TRIM( UPPER( gpe.ADDRESS1))
       END AS Employee_Address1, 
       CASE WHEN TRIM( gpe.ADDRESS2) || '' ''|| TRIM( gpe.ADDRESS3) = '' '' THEN NULL
            ELSE TRIM( UPPER( gpe.ADDRESS2)) || '' ''|| TRIM( UPPER( gpe.ADDRESS3))
       END AS Employee_Address2, 
       UPPER( TRIM( gpe.CITY)) AS Employee_City,
       st.State_ISO_Code AS EMPLOYEE_STATE_CODE,
       zip.Zip_Code,
       CASE WHEN TRIM( gpe.Phone_Number) <> '''' AND LENGTH( TRIM( gpe.Phone_Number)) = 10 AND TRY_TO_NUMBER( TRIM( gpe.Phone_Number)) > 0 AND TRIM( gpe.Phone_Number) NOT IN ( SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) THEN TRIM( gpe.Phone_Number)
            ELSE NULL
       END AS Employee_Home_Phone,
       CASE WHEN TRIM( gpe.Phone_Number_2) <> '''' AND LENGTH( TRIM( gpe.Phone_Number_2)) = 10 AND TRY_TO_NUMBER( TRIM( gpe.Phone_Number_2)) > 0 AND TRIM( gpe.Phone_Number_2) NOT IN ( SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) THEN TRIM( gpe.Phone_Number_2)
            ELSE NULL
       END AS Employee_Cell_Phone,
       NULL AS Employee_Work_Phone, 
       UPPER( TRIM( gpe.PERSONAL_EMAIL)) AS Employee_Personal_Email,
       UPPER( TRIM( gpe.EMAIL)) AS Employee_Work_Email,
       NULL AS Linked_In_Profile_URL,
       CASE WHEN gpe.GENDER = 2 THEN ''FEMALE''
            WHEN gpe.GENDER = 1 THEN ''MALE''
            ELSE NULL
       END AS Employee_Gender, 
       CASE WHEN TRIM( gpe.ETHICS) = ''N/A'' OR TRIM(gpe.ETHICS)= '''' THEN NULL
           WHEN TRIM(gpe.ETHICS) ILIKE ''%UNKNOWN%'' THEN UPPER(''UNKNOWN'')
           WHEN TRIM(gpe.ETHICS) ILIKE ''%Two or More Races%'' THEN UPPER(''Two or More'')
           WHEN TRIM(gpe.ETHICS) ILIKE ''%Native Hawaiian or Pacific Islander%'' THEN UPPER(''Native Hawaiian or Other Pacific Islander'')
           WHEN TRIM(gpe.ETHICS) ILIKE ''%American Indian or Alaskan Native%'' THEN UPPER(''American Indian or Alaska Native'')
		   WHEN TRIM(gpe.ETHICS) ILIKE ANY (''%HISPANIC%'',''%LATINO%'') THEN NULL
            ELSE UPPER(TRIM( gpe.ETHICS))
       END AS Employee_Ethnicity,
	   IFF(UPPER(TRIM(gpe.ETHICS)) IN (''HISPANIC'',''LATINO'',''HISPANIC OR LATINO''), TRUE, FALSE) AS HISPANIC_OR_LATINO,
	   NULL AS EMPLOYEE_LANGUAGE,
       CASE WHEN TRIM( gpe.MARITAL_STATUS_TEXT) = ''N/A'' THEN NULL
            ELSE TRIM( gpe.MARITAL_STATUS_TEXT)
       END AS Employee_Marital_Status, 
       CASE WHEN TRIM( gpe.EMPLOYMENT_TYPE_TEXT) = ''UNKNOWN (         6)'' THEN NULL
            ELSE TRIM( gpe.EMPLOYMENT_TYPE_TEXT)
       END AS Employment_Type,
       CASE WHEN NVL( gpe.IS_ADMIN, 0) <> 0 THEN ''ADMIN'' 
            ELSE ''FIELD'' 
       END AS Employee_Category,
       NULL AS Exempt_Flag,
       TRIM( gpe.JOB_TITLE) AS Job_Title, 
       TRIM( gpe.JOB_DESCRIPTION) AS Job_Description, 
       TRIM( gpe.CLASS_ID) AS Class_Id, 
       TRIM( gpe.WORKERS_COMP) AS Workers_Comp,
       TRIM( gpe.Employee_ID) AS Payroll_ID,
       NULL AS Percent_401k_Deduction,
       NULL AS Amount_401k_Deduction,
       NULL AS JazzHR_Applicant_ID,
       NULL AS JazzHR_User_ID,
       NULL AS JazzHR_Contact_ID,
       NULL AS Work_State,
       SUBSTRING( gpe.SUTA_STATE, 1, 2) AS SUTA_State,
       TRIM( gpe.Department) AS Employee_Department,
       BRANCH.OFFICE_CODE AS Employee_Office_Code,
       BRANCH.BRANCH_KEY AS Primary_Branch_Key,
       BRANCH.OFFICE_STATE_CODE AS Primary_Branch_State,
       BRANCH.DETAILED_OFFICE_NAME AS Primary_Branch_Name,
       BRANCH.SYSTEM_CODE AS Primary_Branch_System_Code,
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
FROM Great_Plains_Employees AS gpe 
LEFT OUTER JOIN HAH.DIM_State AS st ON st.State_ISO_Code = UPPER( SUBSTRING( gpe.State, 1, 2))
LEFT OUTER JOIN HAH.DIM_Zip_Code AS zip ON UPPER( zip.Zip_Code) = UPPER( SUBSTRING( gpe.Zip, 1, 5))
LEFT OUTER JOIN DISC_PROD.STAGE.COASTAL_OFFICE_MAPPING_PAYROLL AS BRANCH_MAPPING
	ON TRIM(BRANCH_MAPPING.DB) = TRIM(gpe.DB)
		AND TRIM(BRANCH_MAPPING.DEPARTMENT) = TRIM(gpe.DEPARTMENT)
LEFT OUTER JOIN HAH.DIM_BRANCH AS BRANCH
	ON TRIM( BRANCH.SYSTEM_CODE) = TRIM( BRANCH_MAPPING.SYSTEM_CODE)
		AND TRIM( BRANCH.OFFICE_CODE) = TRIM( BRANCH_MAPPING.OFFICE_CODE);
--WHERE gpe.ETL_LAST_UPDATED_DATE >= ( SELECT Date_to_Start_Processing FROM Find_Latest_Changes);

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';