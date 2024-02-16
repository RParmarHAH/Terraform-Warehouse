create or replace view DW_PROD.STAGE.VW_CURRENT_COSTALSYNCDATA_DIM_EMPLOYEE(
	EMPLOYEE_KEY
) as
WITH Emp_Latest_Updates AS
(
SELECT TRIM( UPPER( cve.DB)) AS DB, 
       TRIM( UPPER( cve.Nurse_ID)) AS Nurse_ID, 
       MAX( NVL( cve.Dex_Row_ID, -999)) AS Row_ID
FROM DISC_DEDUPE_PROD.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST AS cve
GROUP BY 1, 2
),
CVE_Emp_Record AS
(
SELECT TRIM( UPPER( cve.DB)) AS DB, 
       TRIM( UPPER( cve.Nurse_ID)) AS Nurse_ID,
       TRIM( UPPER( cve.Social_Security_Number)) AS Social_Security_Number,
       TRIM( UPPER( cve.Location_Code)) AS Location_Code,
       MAX( Dex_Row_ID) AS Row_ID
FROM DISC_DEDUPE_PROD.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST AS cve
INNER JOIN Emp_Latest_Updates AS elu ON elu.DB = TRIM( UPPER( cve.DB)) AND elu.Nurse_ID = TRIM( UPPER( cve.Nurse_ID)) AND TRIM( NVL( cve.Dex_Row_ID, -999)) = elu.Row_ID
GROUP BY 1, 2, 3, 4
),
Distinct_CVE_emp AS
(
SELECT DISTINCT MD5( TRIM( cve.DB) || '-' || UPPER( TRIM( cve.Nurse_ID)) || '-' || 'COSTALSYNCDATA') AS Employee_Key,
       UPPER( TRIM( cve.Nurse_ID)) AS Employee_ID, -- TRIM( gpe.Employee_ID), 
       TRIM( cve.DB) AS System_Code, --cve.User_Code, 
       CASE WHEN TRIM( cve.DB) LIKE '%SAVANNAH%' THEN 2 ELSE 1 END AS Source_System_ID,
       CASE WHEN TRIM( cve.Social_Security_Number) IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) THEN CAST( NULL AS VARCHAR)
            WHEN TRIM( cve.Social_Security_Number) = 'NULL' OR TRIM( cve.Social_Security_Number) = '' THEN CAST( NULL AS VARCHAR) 
            ELSE TRIM( cve.Social_Security_Number) 
       END AS Social_Security_Number,
       TRIM( UPPER( cve.First_Name)) AS First_Name,
       TRIM( UPPER( cve.Last_Name)) AS Last_Name,
       TRIM( UPPER( cve.Last_Name))||', '||TRIM( UPPER( cve.First_Name)) AS Employee_Name,
       cer.DB,
       cer.Location_Code AS Office_Code,
       cer.Row_ID,
       Employee_Name||', '||cer.DB||', '||Office_Code AS Unique_Name
FROM DISC_DEDUPE_PROD.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST AS cve
INNER JOIN CVE_Emp_Record AS cer ON cer.DB = TRIM( UPPER( cve.DB)) AND cer.Nurse_ID = TRIM( UPPER( cve.Nurse_ID)) AND  cve.Dex_Row_ID = cer.Row_ID
),
Find_Latest_Changes AS
(
SELECT MAX( cve.ETL_Last_Updated_Date) AS Date_to_Start_Processing
FROM DISC_DEDUPE_PROD.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST AS cve
INNER JOIN CVE_Emp_Record AS cer ON cer.DB = TRIM( UPPER( cve.DB)) AND cer.Nurse_ID = TRIM( UPPER( cve.Nurse_ID)) AND cve.Dex_Row_ID = cer.Row_ID
),
Employee as 
(
    SELECT *
		FROM DISC_DEDUPE_PROD.COSTALSYNCDATA.EMPLOYEE_MASTER_LIST
),
FIELD_VISITS AS (
	SELECT SOURCE_SYSTEM_ID, SYSTEM_CODE, EMPLOYEE_ID, MAX(ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
	FROM HAH.FACT_VISIT
	WHERE SOURCE_SYSTEM_ID IN (1, 2) AND CONFIRMED_FLAG = 'YES'  --STATUS_CODE IN ('02', '03', '04', '05')
	GROUP BY SOURCE_SYSTEM_ID, SYSTEM_CODE, EMPLOYEE_ID 
),
Great_Plains_Employees_Distinct_SSN AS
(
SELECT gpe.DB, gpe.SSN, 
       MAX( NVL( gpe.Terminate_Date, CURRENT_DATE)) AS Terminate_Date
FROM DISC_PROD.CostalSyncData.GPAllEmployeesBase AS gpe
WHERE TRIM( UPPER( gpe.DB)) || TRIM( UPPER( gpe.Employee_ID)) || TRIM( gpe.SSN) NOT IN (SELECT TRIM( UPPER( gpe2.DB)) || TRIM( UPPER( gpe2.Employee_ID)) || TRIM(gpe2.SSN) FROM DISC_PROD.CostalSyncData.GPAllEmployeesBase AS gpe2 WHERE TRIM( UPPER( gpe2.Reason_to_Term)) LIKE ANY ( '%DUPLICATE%PROFILE%', '%WRONG%ID%', '%CODE%IN%USE%', '%WRONG%CODE%'))
GROUP BY gpe.DB, gpe.SSN
),
Great_Plains_Employees AS
(
SELECT CASE WHEN TRIM( gpe.DB) = 'SHC' THEN 'SHC_SAVANNAH' ELSE 'SHC_ALTRUS' END AS DB, 
       gpe.Employee_ID, gpe.SSN, 
       IFF( gpe.DOB=CAST( '1900-01-01' AS DATE), NULL, gpe.DOB) AS DOB, 
       CASE WHEN gpe.Hire_Date < CAST( '1950-01-01' AS DATE) OR gpe.Hire_Date > DATEADD( 'YEAR', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.Hire_Date
       END AS Hire_Date, 
       CASE WHEN gpe.Benefit_Start_Date < CAST( '1950-01-01' AS DATE) OR gpe.Benefit_Start_Date > DATEADD( 'YEAR', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.Benefit_Start_Date
       END AS Benefit_Start_Date, 
       CASE WHEN gpe.First_Check_Date < CAST( '1950-01-01' AS DATE) OR gpe.First_Check_Date > DATEADD( 'YEAR', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.First_Check_Date
       END AS First_Check_Date, 
       CASE WHEN gpe.Last_Check_Date < CAST( '1950-01-01' AS DATE) OR gpe.Last_Check_Date > DATEADD( 'YEAR', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.Last_Check_Date
       END AS Last_Check_Date, 
       CASE WHEN gpe.Last_Day_Worked < CAST( '1950-01-01' AS DATE) OR gpe.Last_Day_Worked > DATEADD( 'YEAR', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.Last_Day_Worked
       END AS Last_Day_Worked, 
       CASE WHEN gpe.Terminate_Date < CAST( '1950-01-01' AS DATE) OR gpe.Terminate_Date > DATEADD( 'YEAR', 1, CURRENT_DATE) THEN NULL
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
FROM DISC_PROD.CostalSyncData.GPAllEmployeesBase AS gpe
INNER JOIN DISC_PROD.Stage.Coastal_Office_Mapping_Payroll AS comp ON comp.DB = gpe.DB AND comp.Department = gpe.Department
INNER JOIN Great_Plains_Employees_Distinct_SSN AS gpssn ON gpssn.DB = gpe.DB AND gpssn.SSN = gpe.SSN AND NVL( gpssn.Terminate_Date, CURRENT_DATE) = NVL( gpe.Terminate_Date, CURRENT_DATE)
WHERE gpe.SSN NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN)
AND TRIM( UPPER( gpe.DB)) || TRIM( UPPER( gpe.Employee_ID)) || TRIM( gpe.SSN) NOT IN (SELECT TRIM( UPPER( gpe2.DB)) || TRIM( UPPER( gpe2.Employee_ID)) || TRIM(gpe2.SSN) FROM DISC_PROD.CostalSyncData.GPAllEmployeesBase AS gpe2 WHERE TRIM( UPPER( gpe2.Reason_to_Term)) LIKE ANY ( '%DUPLICATE%PROFILE%', '%WRONG%ID%', '%CODE%IN%USE%', '%WRONG%CODE%'))
)	
SELECT DISTINCT MD5( TRIM( cve.DB) || '-' ||  UPPER( TRIM( cve.NURSE_ID)) || '-' || 'COSTALSYNCDATA') AS Employee_Key
FROM Employee AS cve
LEFT OUTER JOIN Data_Management.Data_Quality.CV_Employees_Coastal_Great_Plains_Mapping AS cecgpm ON cve.DB = cecgpm.CV_DB AND cve.Nurse_ID = cecgpm.CV_Nurse_ID
LEFT OUTER JOIN Great_Plains_Employees AS gpe ON cecgpm.GP_DB = gpe.DB AND gpe.Employee_ID = cecgpm.GP_Employee_ID
LEFT OUTER JOIN HAH.DIM_Branch AS brnch ON UPPER( TRIM( cve.DB)) = brnch.System_Code AND brnch.Source_System_ID IN (1, 2) AND COALESCE( TRIM( gpe.Office_Code), TRIM( cve.Location_Code)) = brnch.Office_Code
LEFT OUTER JOIN HAH.DIM_State AS st ON st.State_ISO_Code = UPPER( SUBSTRING(cve.STATE_CODE, 1, 2))
LEFT OUTER JOIN HAH.DIM_Zip_Code AS zip ON UPPER( zip.Zip_Code) = UPPER( SUBSTRING(cve.ZIPCODE, 1, 5))
LEFT OUTER JOIN FIELD_VISITS AS FIELD_VISITS
	ON TRIM(FIELD_VISITS.SYSTEM_CODE) = TRIM( cve.DB) -- System_Code 
       AND FIELD_VISITS.SOURCE_SYSTEM_ID = CASE WHEN TRIM( cve.DB) LIKE '%SAVANNAH%' THEN 2 ELSE 1 END -- Source_System_ID
       AND TRIM(FIELD_VISITS.EMPLOYEE_ID) = UPPER( TRIM( cve.Nurse_ID));