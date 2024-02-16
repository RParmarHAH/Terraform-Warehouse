resource "snowflake_procedure" "DW_HAH_GET_STAGE_DATAFLEXSYNCDATA_DIM_EMPLOYEE" {
	name ="GET_STAGE_DATAFLEXSYNCDATA_DIM_EMPLOYEE"
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
    return_result varchar(1000);
BEGIN

--*****************************************************************************************************************************
-- NAME:  DataFlexSyncData_DIM_EMPLOYEE
--
-- PURPOSE: Creates one row per employee_id/database according to Dataflex
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 01/17/20     Greg Marsh           Initial development
-- 04/01/20     Mohd Kamaludin       Added CDC
-- 05/06/20     Frank Noordover      Added logic to define Primary Branch attributes
-- 06/21/20     Frank Noordover      Added logic for additional attributes and improve data quality
-- 10/22/20     Frank Noordover      Revised logic and added additional columns for DIM_EMPLOYEE    
-- 02/04/21     Mir Ali              Added dummy employees for DfArInvoices
-- 02/28/22     Deven Kapasi         Leveraged dataflex dedupe tables
-- 10/03/22		Abhishek Sunil		 Leveraged History tables to display (2013-2017) deleted timesheets data
-- 09/08/23     Mirisha              Dedupe key change for Employee_key
-- 11/10/2023   Trushali Ramoliya     Added a  logic for HISPANIC_OR_LATINO COLUMN and update the logic for ethnicity as per ticket - IDDOX- 388.
-- 12/12/2023   Jainam Shah          Added Logic for columns Employee_Cell_Phone, Employee_Personal_Email and Employee_Work_Email
-- 01/31/2024   Shikhar Saxena		 Updated Employee_Category logic, taking field from Workday
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.DATAFLEXSYNCDATA_DIM_EMPLOYEE
--employee_service_dates - this CTE is no longer used & in case it used again then dedupe needs to be leveraged
WITH employee_service_dates
AS
(
SELECT E.DBName, E."NUMBER" AS Employee_Number, CAST( MIN( tsh.ServiceDate) AS DATE) AS First_Service_Date, CAST( MAX( tsh.ServiceDate) AS DATE) AS Last_Service_Date
FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.EMPLOYEE_MASTER_LIST AS E
LEFT JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.EMPLOYEE_MATCH_LIST AS ML
	ON ML.MASTER_ID = E.MASTER_ID 
JOIN DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.ALL_DFTIMESHEETS AS TS
	ON TS.DBNAME = COALESCE(ML.DBNAME, E.DBNAME) AND TS.EMPLOYEENUMBER = COALESCE(ML."NUMBER", E."NUMBER")
INNER JOIN DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.ALL_TIMESHEETSHOURS AS tsh ON ts.DBName = tsh.DBName AND ts.ReferenceNo = tsh.ReferenceNo
GROUP BY E.DBName, E."NUMBER" 
),
Find_Latest_Changes AS
(
SELECT LEAST( MAX( e.ETL_Last_Updated_Date), MAX( gp.ETL_Last_Updated_Date)) AS Date_to_Start_Processing
FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.EMPLOYEE_MASTER_LIST e
LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.GPSyncData.GPAllEmployeesBase AS gp ON TRIM( e.PayrollID) = TRIM( gp.Employee_ID) AND TRIM( e.DBName) = TRIM( gp.Office_State) AND TRIM( gp.DB) <> ''HAHIL''
),
BULK_BILLING_EMPLOYEES AS (
    SELECT I.DBNAME, I.OFFICE,
    TRY_CAST(CONCAT(-100, I.OFFICE) AS INTEGER) AS DUMMY_EMPLOYEE_NUMBER,
    COALESCE(B.BRANCH_NAME, CONCAT(I.DBNAME, ''-Unknown'')) AS BRANCH_NAME,
    COALESCE(B.BRANCH_KEY, MD5(I.DBNAME || ''-'' || I.OFFICE || ''-'' || ''DATAFLEXSYNCDATA'')) AS BRANCH_KEY,
    COALESCE(B.DETAILED_OFFICE_NAME, BRANCH_NAME) AS DETAILED_OFFICE_NAME,
    MAX(GREATEST(COALESCE(I.ETL_LAST_UPDATED_DATE, ''1/1/1900''), COALESCE(B.ETL_LAST_UPDATED_DATE, ''1/1/1900''))) AS ETL_LAST_UPDATED_DATE
    FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFARINVOICES I
    LEFT JOIN HAH.DIM_BRANCH B ON B.SOURCE_SYSTEM_ID = 3 AND B.SYSTEM_CODE = I.DBNAME AND B.OFFICE_NUMBER = I.OFFICE
GROUP BY I.DBNAME, I.OFFICE, COALESCE(B.BRANCH_NAME, CONCAT(I.DBNAME, ''-Unknown'')),
    COALESCE(B.BRANCH_KEY, MD5(I.DBNAME || ''-'' || I.OFFICE || ''-'' || ''DATAFLEXSYNCDATA'')),
    COALESCE(B.DETAILED_OFFICE_NAME, BRANCH_NAME)
),
EMPLOYEES AS (
SELECT *,regexp_replace(MASTER_ID,DBNAME)::number AS MASTER_IDD FROM 
DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.EMPLOYEE_MASTER_LIST),
WORKDAY_EXCLUDE_EMPLOYEES AS(
SELECT ADD_INFO.EMPLOYEE_ID, ADD_INFO.GP_ID
FROM DISC_${var.SF_ENVIRONMENT}.WORKDAY.WORKER_ADDITIONAL_INFORMATION AS ADD_INFO
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.WORKDAY.WORKER_EXCLUDE_LIST WE
ON ADD_INFO.EMPLOYEE_ID = WE."CFI INT005 Worker ID LRV"
WHERE WE."CFI INT005 Worker ID LRV" IS NULL
QUALIFY ROW_NUMBER() OVER(PARTITION BY ADD_INFO.GP_ID ORDER BY ADD_INFO.PROCESSED_TIMESTAMP::DATE DESC) = 1
)
SELECT
    md5(COALESCE(e.DBNAME,'''') || ''-'' || UPPER(NVL(TRIM(e.MASTER_IDD), '''')) || ''-''  ||  ''1900-01-01'' || ''-'' || ''DATAFLEXSYNCDATA'') AS EMPLOYEE_KEY,
    e.Number AS EMPLOYEE_ID, --BK
    TRIM( e.DbName) AS SYSTEM_CODE,  --BK
    3 AS SOURCE_SYSTEM_ID, --BK
    CASE WHEN TRIM( e.ssn) NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) AND TRIM( e.ssn) NOT LIKE ''00000%'' AND LENGTH( TRIM( e.SSN)) = 9 THEN HEX_ENCODE( TRIM( e.SSN))
         WHEN TRIM( gp.ssn) NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) AND TRIM( gp.ssn) NOT LIKE ''00000%'' AND LENGTH( TRIM( gp.SSN)) = 9 THEN HEX_ENCODE( TRIM( gp.SSN))
         ELSE NULL
    END AS EMPLOYEE_PID,
    CASE WHEN e.Number > 0 THEN e.Number
         ELSE NULL
    END AS EMPLOYEE_NUMBER,
    CASE WHEN e.DOB >= CAST( ''1901-01-01'' AS DATE) AND e.DOB <= DATEADD( YEAR, -12, CURRENT_DATE) THEN e.DOB
         WHEN CAST( gp.DOB AS DATE) >= CAST( ''1901-01-01'' AS DATE) AND CAST( gp.DOB AS DATE) <= DATEADD( YEAR, -12, CURRENT_DATE) THEN CAST( gp.DOB AS DATE)
         ELSE NULL
    END AS EMPLOYEE_DOB,
    NULL AS Employee_Date_of_Death,
    CASE WHEN e.HireDate >= CAST( ''1960-01-01'' AS DATE) AND e.HireDate <= DATEADD( YEAR, +1, CURRENT_DATE) AND e.HIREDATE >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN e.HireDate
         WHEN gp.Hire_Date >= CAST( ''1960-01-01'' AS DATE) AND gp.Hire_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND gp.HIRE_DATE >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN CAST( gp.Hire_Date AS DATE)
         ELSE NULL
    END AS EMPLOYEE_HIRE_DATE,
    NULL AS EMPLOYEE_REHIRE_DATE,
    CASE WHEN CAST( gp.BENEFIT_START_DATE AS DATE) >= CAST( ''1960-01-01'' AS DATE) AND CAST( gp.Benefit_Start_Date AS DATE) <= DATEADD( YEAR, +1, CURRENT_DATE) AND CAST( gp.BENEFIT_START_DATE AS DATE) >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN CAST( gp.BENEFIT_START_DATE AS DATE)
         ELSE NULL
    END AS Employee_Benefit_Start_Date,
    CASE WHEN CAST( gp.FIRST_CHECK_DATE AS DATE) >= CAST( ''1960-01-01'' AS DATE) AND gp.First_Check_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND gp.First_Check_Date >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN CAST( gp.FIRST_CHECK_DATE AS DATE)
         ELSE NULL
    END AS Employee_First_Check_Date,
    CASE WHEN e.LastCheckDate >= CAST( ''1960-01-01'' AS DATE) AND e.LastCheckDate <= DATEADD( YEAR, +1, CURRENT_DATE) AND e.LastCheckDate >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN e.LastCheckDate
         WHEN CAST( gp.Last_Check_Date AS DATE) >= CAST( ''1960-01-01'' AS DATE) AND CAST( gp.Last_Check_Date AS DATE) <= DATEADD( YEAR, +1, CURRENT_DATE) AND gp.Last_Check_Date >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN CAST( gp.Last_Check_Date AS DATE)
         ELSE NULL
    END AS EMPLOYEE_LAST_CHECK_DATE,
    CASE WHEN CAST( gp.Last_Day_Worked AS DATE) >= CAST( ''1960-01-01'' AS DATE) AND CAST( gp.Last_Day_Worked AS DATE) > Employee_Hire_Date AND CAST( gp.Last_Day_Worked AS DATE) >= NVL( Employee_Hire_Date, CAST( ''1960-01-01'' AS DATE)) THEN CAST( gp.Last_Day_Worked AS DATE)
         WHEN e.TerminateDate >= CAST( ''1960-01-01'' AS DATE) AND e.TerminateDate > Employee_Hire_Date AND e.TerminateDate >= NVL( Employee_Hire_Date, CAST( ''1960-01-01'' AS DATE)) THEN e.TerminateDate
         ELSE NULL
    END AS Employee_Last_Worked_DATE,
    CASE WHEN e.TerminateDate >= CAST( ''1960-01-01'' AS DATE) AND e.TerminateDate > Employee_Hire_Date AND e.TerminateDate >= NVL( Employee_Hire_Date, CAST( ''1960-01-01'' AS DATE)) THEN e.TerminateDate
         WHEN CAST( gp.Terminate_Date AS DATE) >= CAST( ''1960-01-01'' AS DATE) AND CAST( gp.Terminate_Date AS DATE) > Employee_Hire_Date AND CAST( gp.Terminate_Date AS DATE) >= NVL( Employee_Hire_Date, CAST( ''1960-01-01'' AS DATE)) THEN CAST( gp.Terminate_Date AS DATE)
         ELSE NULL
    END AS EMPLOYEE_TERMINATE_DATE,
    UPPER( TRIM( gp.Reason_To_Term)) AS REASON_TO_TERMINATE,
    e.IsActive AS ACTIVE_EMPLOYEE_FLAG,
    e.AbleToRehire AS ABLE_TO_REHIRE_FLAG,
    NULL AS EMPLOYEE_PREFIX,
    CASE WHEN UPPER( TRIM( e.FirstName)) <> '''' AND e.FirstName IS NOT NULL THEN UPPER( TRIM( e.FirstName))
         WHEN UPPER( TRIM( gp.First_Name)) <> '''' THEN UPPER( TRIM( gp.First_Name))
         ELSE NULL
    END AS Employee_First_Name,
    CASE WHEN TRIM( e.MIDDLENAME) <> '''' AND e.MiddleName IS NOT NULL THEN TRIM( UPPER( regexp_replace( e.MiddleName,''\\\\\\\\d|\\\\\\\\.|\\\\\\\\+|\\\\\\\\,|\\\\\\\\-'','''')))
         WHEN TRIM( gp.MIDDLE_NAME) <> '''' THEN TRIM( UPPER( regexp_replace( gp.Middle_Name,''\\\\\\\\d|\\\\\\\\.|\\\\\\\\+|\\\\\\\\,|\\\\\\\\-'','''')))
         ELSE NULL
    END AS Employee_Middle_Name,
    CASE WHEN UPPER( TRIM( e.LastName)) <> '''' AND e.LastName IS NOT NULL THEN UPPER( TRIM( e.LastName))
         WHEN UPPER( TRIM( gp.Last_Name)) <> '''' THEN UPPER( TRIM( gp.Last_Name))
         ELSE NULL
    END AS Employee_Last_Name,
    NULL AS EMPLOYEE_SUFFIX,
    CASE WHEN UPPER( TRIM( e.Address1)) <>  '''' AND UPPER( TRIM( e.Address1)) IS NOT NULL THEN UPPER( TRIM( e.Address1))
         WHEN UPPER( TRIM( gp.Address1)) <>  '''' THEN UPPER( TRIM( gp.Address1))
         ELSE NULL
    END AS Employee_Address1,
    CASE WHEN UPPER( TRIM( e.Address2)) <>  '''' AND UPPER( TRIM( e.Address2)) IS NOT NULL THEN UPPER( TRIM( e.Address2))
         WHEN UPPER( TRIM( gp.Address2)) <>  '''' OR UPPER( TRIM( gp.Address3)) <>  '''' THEN IFF( UPPER( TRIM( gp.Address2)) IS NOT NULL, UPPER( TRIM( gp.Address2)), '''') || IFF( UPPER( TRIM( gp.Address3)) IS NOT NULL, '' ''||UPPER( TRIM( gp.Address3)), '''')
         ELSE NULL
    END AS Employee_Address2,
    CASE WHEN UPPER( TRIM( e.City)) <>  '''' AND UPPER( TRIM( e.City)) IS NOT NULL THEN UPPER( TRIM( e.City))
         WHEN UPPER( TRIM( gp.City)) <>  '''' THEN UPPER( TRIM( gp.City))
         ELSE NULL
    END AS Employee_City,
    st.State_ISO_Code AS EMPLOYEE_STATE_CODE,
    zip.Zip_Code AS Employee_Zip,
	CASE WHEN TRIM( REGEXP_REPLACE( e.PhoneNumber,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'','''')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND e.PhoneNumber NOT LIKE ''%0000000%'' AND LENGTH( TRIM( REGEXP_REPLACE( e.PhoneNumber,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'',''''))) = 10 THEN TRIM( REGEXP_REPLACE( e.PhoneNumber,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'',''''))
		WHEN TRIM( REGEXP_REPLACE( gp.Phone_Number,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'','''')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND gp.Phone_Number NOT LIKE ''%0000000%'' AND LENGTH( TRIM( REGEXP_REPLACE( gp.Phone_Number,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'',''''))) = 10 THEN TRIM( REGEXP_REPLACE( gp.Phone_Number,''\\\\.|\\\\,|\\\\+|\\\\-|\\\\?|\\\\]|\\\\/|\\\\(|\\\\)|\\\\\\\\|\\\\s|[a-z]|[A-Z]|'',''''))
		ELSE NULL
    END AS Employee_Home_Phone,
    CASE WHEN TRIM(e.CellPhoneNumber) = ''''
         	  THEN NULL 
         WHEN TRIM(e.CellPhoneNumber) ILIKE ''%00000000%''
              THEN NULL
	     WHEN TRIM(REGEXP_REPLACE( e.CellPhoneNumber,''\\\\\\\\.|\\\\\\\\,|\\\\\\\\+|\\\\\\\\-|\\\\\\\\?|\\\\\\\\]|\\\\\\\\/|\\\\\\\\(|\\\\\\\\)|\\\\\\\\\\\\\\\\|\\\\\\\\s|[a-z]|[A-Z]|'','''')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND e.CellPhoneNumber NOT LIKE ''%0000000%'' AND LENGTH( TRIM( REGEXP_REPLACE( e.CellPhoneNumber,''\\\\\\\\.|\\\\\\\\,|\\\\\\\\+|\\\\\\\\-|\\\\\\\\?|\\\\\\\\]|\\\\\\\\/|\\\\\\\\(|\\\\\\\\)|\\\\\\\\\\\\\\\\|\\\\\\\\s|[a-z]|[A-Z]|'',''''))) = 10 
              THEN TRIM( REGEXP_REPLACE( e.CellPhoneNumber,''\\\\\\\\.|\\\\\\\\,|\\\\\\\\+|\\\\\\\\-|\\\\\\\\?|\\\\\\\\]|\\\\\\\\/|\\\\\\\\(|\\\\\\\\)|\\\\\\\\\\\\\\\\|\\\\\\\\s|[a-z]|[A-Z]|'',''''))
            ELSE e.CellPhoneNumber
     END AS Employee_Cell_Phone,
    NULL AS Employee_Work_Phone,
    CASE WHEN E.Email ILIKE ''%@helpathome.com%''
         THEN NULL
         ELSE NULLIF(E.email,'''') END AS Employee_Personal_Email,
    CASE WHEN E.Email ILIKE ''%@helpathome.com%''
         THEN E.Email
         ELSE NULL END AS Employee_Work_Email,
    NULL AS Linked_In_Profile_URL,
    CASE WHEN UPPER( e.Gender) = ''F'' THEN ''FEMALE''
         WHEN UPPER( e.Gender) = ''M'' THEN ''MALE''
         WHEN UPPER( TRIM( gp.Gender_Text)) IN (''FEMALE'', ''MALE'') THEN UPPER( TRIM( gp.Gender_Text))
         ELSE NULL
    END AS EMPLOYEE_GENDER,
    CASE WHEN e.Ethics = ''W'' THEN UPPER(''White'')
         WHEN e.Ethics = ''B'' THEN UPPER(''Black or African American'')
         WHEN e.Ethics = ''H'' THEN NULL 
         WHEN e.Ethics = ''A'' THEN UPPER(''Asian'')
          WHEN TRIM(gp.ETHICS) ILIKE ''%Two or More Races%'' THEN UPPER(''Two or More'')
           WHEN TRIM(gp.ETHICS) ILIKE ''%Native Hawaiian or Pacific Islander%'' THEN UPPER(''Native Hawaiian or Other Pacific Islander'')
           WHEN TRIM(gp.ETHICS) ILIKE ''%American Indian or Alaskan Native%'' THEN UPPER(''American Indian or Alaska Native'')
           WHEN TRIM(gp.ETHICS) ILIKE ANY (''%HISPANIC%'',''%LATINO%'') THEN NULL
           WHEN UPPER(TRIM( gp.Ethics)) NOT IN ( ''N/A'', '''') THEN UPPER(TRIM( gp.Ethics)) 
         ELSE NULL
    END AS Ethnicity,
        CASE WHEN e.Ethics = ''H'' THEN TRUE 
        WHEN  (trim(e.Ethics) = '''' OR trim(e.Ethics) NOT IN (''W'',''B'',''A'')) AND TRIM(UPPER(gp.ETHICS)) IN (''HISPANIC'',''LATINO'',''HISPANIC OR LATINO'') THEN TRUE 
        ELSE FALSE END 
        AS HISPANIC_OR_LATINO,
	NULL AS EMPLOYEE_LANGUAGE,
    CASE WHEN UPPER( TRIM( gp.Marital_Status_Text)) NOT IN ( ''N/A'', '''') THEN gp.Marital_Status_Text
         ELSE NULL
    END AS EMPLOYEE_MARITAL_STATUS,
       CASE WHEN UPPER( TRIM( gp.EMPLOYMENT_TYPE_TEXT)) <> ''UNKNOWN (         6)'' THEN TRIM( gp.EMPLOYMENT_TYPE_TEXT)
            ELSE NULL
       END AS Employment_Type,
    COALESCE(CASE 
		WHEN UPPER(TRIM(POS.WORKER_TYPE)) IN (''CAREGIVER'') THEN ''FIELD''
		WHEN UPPER(TRIM(POS.WORKER_TYPE)) IN (''FIELD ADMIN'') THEN ''ADMIN''
		WHEN UPPER(TRIM(POS.WORKER_TYPE)) IN (''AGENCY'',''FSC'') THEN ''CORP''
		WHEN UPPER(TRIM(POS.WORKER_TYPE)) IN (''CONTINGENT'',''CONTRACTOR'') THEN ''CONTRACTOR''
		WHEN UPPER(TRIM(POS.WORKER_TYPE)) IN (''INTERN'') THEN ''INTERN''
		ELSE UPPER(TRIM(POS.WORKER_TYPE))
		END,
			CASE
				WHEN gp.IS_ADMIN = 0 THEN ''FIELD''
				WHEN gp.IS_ADMIN <> 0 THEN ''ADMIN''
				ELSE NULL
				END) AS Employee_Category,
    NULL AS Exempt_Flag,
    TRIM( gp.JOB_TITLE) AS Job_Title,
    TRIM( gp.JOB_DESCRIPTION) AS Job_Description,
    TRIM( gp.CLASS_ID) AS Class_Id,
    TRIM( gp.WORKERS_COMP) AS Workers_Comp,
    TRIM( e.PayrollId) AS PAYROLL_ID,
    NULL AS Percent_401k_Deduction,
    NULL AS Amount_401k_Deduction,
    NULL AS JazzHR_Applicant_ID,
    NULL AS JazzHR_User_ID,
    NULL AS JazzHR_Contact_ID,
    brnch.Office_State_Code AS Work_State,
    SUBSTRING( gp.SUTA_State, 1, 2) AS SUTA_State,
    UPPER( e.Department) AS EMPLOYEE_DEPARTMENT,
    e.OfficeNumber AS EMPLOYEE_OFFICE_Code,
    brnch.Branch_Key AS Primary_Branch_Key,
    brnch.Office_State_Code AS Primary_Branch_State,
    brnch.Detailed_Office_Name AS Primary_Branch_Name,
    brnch.System_Code AS Primary_Branch_System_Code,
	NULL AS CASE_MANAGER_FLAG,
	NULL AS SUPERVISOR_FLAG,
	NULL AS COORDINATOR_FLAG,
    TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
    TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
    -- ETL Fields
    
   :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
   :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
   
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG,
    0 AS ETL_INFERRED_MEMBER_FLAG
FROM EMPLOYEES e
LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.GPSyncData.GPAllEmployeesBase AS gp ON TRIM( e.PayrollID) = TRIM( gp.Employee_ID) AND TRIM( e.DBName) = TRIM( gp.Office_State) AND TRIM( gp.DB) <> ''HAHIL''
LEFT OUTER JOIN HAH.DIM_Branch AS brnch ON UPPER( TRIM( e.DBName)) = brnch.System_Code AND 3 = brnch.Source_System_ID AND e.OfficeNumber = brnch.Office_Number
LEFT OUTER JOIN HAH.DIM_State AS st ON st.State_ISO_Code = UPPER( SUBSTRING( TRIM( e.State), 1, 2))
LEFT OUTER JOIN HAH.DIM_Zip_Code AS zip ON UPPER( zip.Zip_Code) = UPPER( e.Zip)
--LEFT OUTER JOIN employee_service_dates AS csd ON csd.DBName = e.DBName AND csd.Employee_Number = e.Number
LEFT JOIN WORKDAY_EXCLUDE_EMPLOYEES AS WEE ON e.PayrollID = WEE.GP_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.WORKDAY.WORKER_POSITION_DATA AS POS ON WEE.EMPLOYEE_ID = POS.EMPLOYEE_ID
WHERE UPPER( TRIM( e.DBName)) <> ''PA''
UNION ALL
SELECT md5(COALESCE(e.DBNAME,'''') || ''-'' || UPPER(NVL(TRIM(e.DUMMY_EMPLOYEE_NUMBER), '''')) || ''-''  ||  ''1900-01-01'' || ''-'' || ''DATAFLEXSYNCDATA-DUMMY'') AS EMPLOYEE_KEY,
E.DUMMY_EMPLOYEE_NUMBER AS EMPLOYEE_ID,
E.DBNAME AS SYSTEM_CODE,
3 AS SOURCE_SYSTEM_ID,
NULL AS EMPLOYEE_PID,
E.DUMMY_EMPLOYEE_NUMBER AS EMPLOYEE_NUMBER,
NULL AS EMPLOYEE_DOB,
NULL AS EMPLOYEE_DATE_OF_DEATH,
NULL AS EMPLOYEE_HIRE_DATE,
NULL AS EMPLOYEE_REHIRE_DATE,
NULL AS EMPLOYEE_BENEFIT_START_DATE,
NULL AS EMPLOYEE_FIRST_CHECK_DATE,
NULL AS EMPLOYEE_LAST_CHECK_DATE,
NULL AS EMPLOYEE_LAST_WORKED_DATE,
NULL AS EMPLOYEE_TERMINATE_DATE,
NULL AS REASON_TO_TERMINATE,
FALSE AS ACTIVE_EMPLOYEE_FLAG,
NULL AS ABLE_TO_REHIRE_FLAG,
NULL AS EMPLOYEE_PREFIX,
E.BRANCH_NAME AS EMPLOYEE_FIRST_NAME,
NULL AS EMPLOYEE_MIDDLE_NAME,
''BULK BILLING DUMMY EMPLOYEE'' AS EMPLOYEE_LAST_NAME,
NULL AS EMPLOYEE_SUFFIX,
NULL AS EMPLOYEE_ADDRESS1,
NULL AS EMPLOYEE_ADDRESS2,
NULL AS EMPLOYEE_CITY,
NULL AS EMPLOYEE_STATE_CODE,
NULL AS EMPLOYEE_ZIP,
NULL AS EMPLOYEE_HOME_PHONE,
NULL AS EMPLOYEE_CELL_PHONE,
NULL AS EMPLOYEE_WORK_PHONE,
NULL AS EMPLOYEE_PERSONAL_EMAIL,
NULL AS EMPLOYEE_WORK_EMAIL,
NULL AS LINKED_IN_PROFILE_URL,
NULL AS EMPLOYEE_GENDER,
NULL AS EMPLOYEE_ETHNICITY,
FALSE AS HISPANIC_OR_LATINO,							
NULL AS EMPLOYEE_LANGUAGE,
NULL AS EMPLOYEE_MARITAL_STATUS,
NULL AS EMPLOYEE_TYPE,
NULL AS EMPLOYEE_CATEGORY,
NULL AS EXEMPT_FLAG,
NULL AS JOB_TITLE,
NULL AS JOB_DESCRIPTION,
NULL AS CLASS_ID,
NULL AS WORKERS_COMP,
NULL AS PAYROLL_ID,
NULL AS PERCENT_401K_DEDUCTION,
NULL AS AMOUNT_401K_DEDUCTION,
NULL AS JAZZHR_APPLICANT_ID,
NULL AS JAZZHR_USER_ID,
NULL AS JAZZHR_CONTACT_ID,
NULL AS WORK_STATE,
NULL AS SUTA_STATE,
NULL AS EMPLOYEE_DEPARTMENT,
E.OFFICE AS EMPLOYEE_OFFICE_CODE,
E.BRANCH_KEY AS PRIMARY_BRANCH_KEY,
E.DBNAME AS PRIMARY_BRANCH_STATE,
COALESCE(E.DETAILED_OFFICE_NAME, E.BRANCH_NAME) AS PRIMARY_BRANCH_NAME,
E.DBNAME AS PRIMARY_BRANCH_SYSTEM_CODE,
NULL AS CASE_MANAGER_FLAG,
NULL AS SUPERVISOR_FLAG,
NULL AS COORDINATOR_FLAG,
    TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
    TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
    -- ETL Fields
    
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
    
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG,
    0 AS ETL_INFERRED_MEMBER_FLAG
FROM BULK_BILLING_EMPLOYEES E;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

