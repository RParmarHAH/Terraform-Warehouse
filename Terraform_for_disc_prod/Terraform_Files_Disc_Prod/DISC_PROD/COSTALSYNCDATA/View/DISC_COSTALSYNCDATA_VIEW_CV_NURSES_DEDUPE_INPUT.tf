resource "snowflake_view" "DISC_COSTALSYNCDATA_VIEW_CV_NURSES_DEDUPE_INPUT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "VIEW_CV_NURSES_DEDUPE_INPUT"
	statement = <<-SQL
	 WITH Great_Plains_Employees_Distinct_SSN AS
(
SELECT gpe.DB, gpe.SSN, 
       MAX( NVL( gpe.Terminate_Date, CURRENT_DATE)) AS Terminate_Date
FROM DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GPAllEmployeesBase AS gpe
WHERE TRIM( UPPER( gpe.DB)) || TRIM( UPPER( gpe.Employee_ID)) || TRIM( gpe.SSN) NOT IN (SELECT TRIM( UPPER( gpe2.DB)) || TRIM( UPPER( gpe2.Employee_ID)) || TRIM(gpe2.SSN) FROM DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GPAllEmployeesBase AS gpe2 WHERE TRIM( UPPER( gpe2.Reason_to_Term)) LIKE ANY ( '%DUPLICATE%PROFILE%', '%WRONG%ID%', '%CODE%IN%USE%', '%WRONG%CODE%'))
GROUP BY gpe.DB, gpe.SSN
)
,Great_Plains_Employees AS
(
SELECT CASE WHEN TRIM(gpe.DB) = 'SHC' THEN 'SHC_SAVANNAH' ELSE 'SHC_ALTRUS' END AS DB, 
       gpe.Employee_ID, gpe.SSN, 
       IFF(gpe.DOB=CAST('1900-01-01' AS DATE), NULL, gpe.DOB) AS DOB, 
       CASE WHEN gpe.Hire_Date < CAST('1950-01-01' AS DATE) OR gpe.Hire_Date > DATEADD('YEAR', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.Hire_Date
       END AS Hire_Date, 
       CASE WHEN gpe.Benefit_Start_Date < CAST('1950-01-01' AS DATE) OR gpe.Benefit_Start_Date > DATEADD('YEAR', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.Benefit_Start_Date
       END AS Benefit_Start_Date, 
       CASE WHEN gpe.First_Check_Date < CAST('1950-01-01' AS DATE) OR gpe.First_Check_Date > DATEADD('YEAR', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.First_Check_Date
       END AS First_Check_Date, 
       CASE WHEN gpe.Last_Check_Date < CAST('1950-01-01' AS DATE) OR gpe.Last_Check_Date > DATEADD('YEAR', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.Last_Check_Date
       END AS Last_Check_Date, 
       CASE WHEN gpe.Last_Day_Worked < CAST('1950-01-01' AS DATE) OR gpe.Last_Day_Worked > DATEADD('YEAR', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.Last_Day_Worked
       END AS Last_Day_Worked, 
       CASE WHEN gpe.Terminate_Date < CAST('1950-01-01' AS DATE) OR gpe.Terminate_Date > DATEADD('YEAR', 1, CURRENT_DATE) THEN NULL
            ELSE gpe.Terminate_Date
       END AS Terminate_Date, 
       gpe.Reason_to_Term, 
       TRIM(UPPER(gpe.First_Name)) AS First_Name, 
       TRIM(UPPER(gpe.Middle_Name)) AS Middle_Name, 
       TRIM(UPPER(gpe.Last_Name)) AS Last_Name, 
       TRIM(gpe.Address1) AS Address1, 
       TRIM(gpe.Address2) AS Address2, 
       TRIM(gpe.Address3) AS Address3, 
       TRIM(gpe.City) AS City, 
       TRIM(UPPER(gpe.State)) AS State, gpe.Zip,
       gpe.Phone_Number, gpe.Phone_Number_2,
       gpe.Gender, gpe.Ethics, gpe.Ethics_Code, gpe.Marital_Status_Text, gpe.Employment_Type_Text, gpe.Is_Admin,
       gpe.Job_Title, gpe.Job_Description, gpe.Class_ID, gpe.Workers_Comp,
       gpe.SUTA_State, gpe.Department, gpe.InActive,
       gpe.ETL_Last_Updated_Date,
       comp.System_Code, comp.Office_Code
FROM DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GPAllEmployeesBase AS gpe
INNER JOIN DISC_${var.SF_ENVIRONMENT}.Stage.Coastal_Office_Mapping_Payroll AS comp ON comp.DB = gpe.DB AND comp.Department = gpe.Department
INNER JOIN Great_Plains_Employees_Distinct_SSN AS gpssn ON gpssn.DB = gpe.DB AND gpssn.SSN = gpe.SSN AND NVL(gpssn.Terminate_Date, CURRENT_DATE) = NVL(gpe.Terminate_Date, CURRENT_DATE)
WHERE gpe.SSN NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN)
AND TRIM(UPPER(gpe.DB)) || TRIM(UPPER(gpe.Employee_ID)) || TRIM(gpe.SSN) NOT IN (SELECT TRIM(UPPER(gpe2.DB)) || TRIM(UPPER(gpe2.Employee_ID)) || TRIM(gpe2.SSN) FROM DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GPAllEmployeesBase AS gpe2 WHERE TRIM(UPPER(gpe2.Reason_to_Term)) LIKE ANY ('%DUPLICATE%PROFILE%', '%WRONG%ID%', '%CODE%IN%USE%', '%WRONG%CODE%'))
)
SELECT DISTINCT cve.DB || cve.NURSE_ID AS ID,
TRIM(cve.DB) AS DB,
TRIM(cve.NURSE_ID) AS NURSE_ID,
TRIM(cve.LAST_NAME) AS LAST_NAME,
TRIM(cve.FIRST_NAME) AS FIRST_NAME,
CASE 
	WHEN TRIM( UPPER( COALESCE (GPE.address1, cve.ADDRESS))) <> '' AND TRIM( UPPER( COALESCE (GPE.address1, cve.ADDRESS))) IS NOT NULL THEN TRIM( UPPER( COALESCE (GPE.address1, cve.ADDRESS)))
	ELSE NULL
END AS ADDRESS,
CASE 
	WHEN UPPER( TRIM( COALESCE (GPE.city , cve.City))) <>  '' AND UPPER( TRIM( COALESCE (GPE.city , cve.City))) IS NOT NULL THEN UPPER( TRIM( COALESCE (GPE.city , cve.City)))
	ELSE NULL
END AS CITY,
CASE
	WHEN TRIM(COALESCE (GPE.SSN,cve.Social_Security_Number)) NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) AND TRIM(COALESCE (GPE.SSN,cve.Social_Security_Number)) NOT LIKE '00000%' AND LENGTH(TRIM(COALESCE (GPE.SSN,cve.Social_Security_Number))) = 9 THEN HEX_ENCODE(TRIM(COALESCE (GPE.SSN,cve.Social_Security_Number)))
	ELSE NULL
END AS SOCIAL_SECURITY_NUMBER,
CASE
	WHEN CAST( COALESCE (GPE.DOB,cve.BIRTH_DATE)AS DATE) < CAST( '1901-01-01' AS DATE) OR CAST(COALESCE (GPE.DOB,cve.BIRTH_DATE)AS DATE) > DATEADD( YEAR, -12, CURRENT_DATE) THEN NULL
	ELSE CAST( COALESCE (GPE.DOB,cve.BIRTH_DATE) AS DATE)
END AS BIRTH_DATE,
CASE 
	WHEN TRIM( cve.Phone) <> '' AND LENGTH( TRIM( cve.Phone)) = 10 AND TRY_TO_NUMBER( TRIM( cve.Phone)) > 0 AND TRIM( cve.Phone) NOT IN ( SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) THEN TRIM( cve.Phone)
	ELSE NULL
END AS PHONE,
TRIM(cve.EMAIL) AS EMAIL,
TRIM(cve.FIRST_PAYMENT_DATE) AS FIRST_PAYMENT_DATE,
TRIM(cve.ENTRY_DATE) AS ENTRY_DATE,
cve.UPDATE_DATE,
cve.ETL_INSERTED_DATE,
cve.ETL_LAST_UPDATED_DATE 
FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_NURSES cve
LEFT OUTER JOIN Data_Management.Data_Quality.CV_Employees_Coastal_Great_Plains_Mapping AS cecgpm ON cve.DB = cecgpm.CV_DB AND cve.Nurse_ID = cecgpm.CV_Nurse_ID
LEFT OUTER JOIN Great_Plains_Employees AS gpe ON cecgpm.GP_DB = gpe.DB AND gpe.Employee_ID = cecgpm.GP_Employee_ID;
SQL
	or_replace = true 
	is_secure = false 
}

