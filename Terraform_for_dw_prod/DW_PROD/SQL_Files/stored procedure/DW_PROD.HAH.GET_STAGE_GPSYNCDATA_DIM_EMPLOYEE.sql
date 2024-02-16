CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_GPSYNCDATA_DIM_EMPLOYEE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

--*****************************************************************************************************************************
-- NAME:  GPSyncData_DIM_EMPLOYEE
--
-- PURPOSE: Creates one row per employee_id/database according to Great Plains
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   ------------------------------------------------------------------------------------------
-- 02/18/20    Frank Noordover       Initial development
-- 04/01/20		Mohd Kamaludin		 Added CDC
-- 06/16/20	   Arif Ansari			 Update logic to generate EmployeeKEy	
-- 06/21/20    Frank Noordover       Added logic for visit attributes and improve data quality
-- 08/20/20		ARif Ansari			 Added or condition to get branch key for corporate employees
-- 10/22/20    Frank Noordover       Revised logic and added additional columns for DIM_EMPLOYEE
-- 01/23/23    Abhishek Sunil		 Revised ZipCode Join Logic
-- 04/03/23    Manmohan Soni		 Revised EMPLOYEE_TERMINATE_DATE field Logic
-- 04/04/23    Abhishek Sunil		 Revised Phone Number logic	
-- 11/10/2023  Trushali Ramoliya     Added a logic for HISPANIC_OR_LATINO and update the logic for ethnicity as per ticket - IDDOX- 388.
--*****************************************************************************************************************************


INSERT OVERWRITE INTO STAGE.GPSYNCDATA_DIM_EMPLOYEE

--WITH latest_emp AS
--(
--SELECT  emp2.Employee_ID,
--        MAX(COALESCE(emp2.HIRE_DATE,''1900-01-01'')) AS HIRE_DATE_CHECK,
--        MAX( IFF( emp2.Terminate_Date IS NULL, IFF( emp2.Last_Day_Worked IS NULL, IFF( emp2.Last_Check_Date IS NULL, CAST( ''2030-12-31'' AS DATE), emp2.Last_Check_Date), emp2.Last_Day_Worked), emp2.Terminate_Date)) AS Max_Effective_To_Date
--FROM DISC_PROD.GPSyncData.GPAllEmployeesBase AS emp2
--GROUP BY emp2.Employee_ID
---- 135,981 rows
--)
WITH employee_service_dates AS
(
	SELECT 
		ts.DBName, ts.EmployeeNumber AS Employee_Number, emp.SSN, CAST( MIN( tsh.ServiceDate) AS DATE) AS First_Service_Date, CAST( MAX( tsh.ServiceDate) AS DATE) AS Last_Service_Date
	FROM DISC_PROD.DataFlexSyncData.DFTimeSheets AS ts
	INNER JOIN DISC_PROD.DataFlexSyncData.DFTimeSheetHours AS tsh 
		ON ts.DBName = tsh.DBName AND ts.ReferenceNo = tsh.ReferenceNo
	LEFT OUTER JOIN DISC_PROD.DataFlexSyncData.DFEmployees AS emp 
		ON ts.DBName = emp.DBName AND ts.EmployeeNumber = emp.Number AND emp.SSN IS NOT NULL
	GROUP BY ts.DBName, ts.EmployeeNumber, emp.SSN
--65,374,730
),
Find_Latest_Changes AS
(
	SELECT 
		LEAST( MAX( emp.ETL_Last_Updated_Date), MAX( dfe.ETL_Last_Updated_Date)) AS Date_to_Start_Processing
	FROM DISC_PROD.GPSyncData.GPAllEmployeesBase AS emp
	LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DfEmployees AS dfe 
		ON TRIM( dfe.PayrollID) = TRIM( emp.Employee_ID) AND TRIM( dfe.DBName) = TRIM( emp.Office_State) AND TRIM( emp.DB) <> ''HAHIL''
),
RATE_BASE_PAY_RATE AS (
	SELECT DISTINCT 
		ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_ID ORDER BY LAST_PAID_DATE DESC NULLS LAST) AS RANK,
		TRIM(EMPLOYEE_ID) AS EMPLOYEE_ID, TRIM(PAY_CODE) AS PAY_CODE, LAST_PAID_DATE, PAY_RATE, PAY_RATE * 40 * 52 AS SALARY
	FROM DISC_PROD.GPSYNCDATA.GPALLEMPLOYEERATESBASE 
	WHERE TRIM(PAY_CODE) IN (SELECT DISTINCT TRIM(PAY_CODE) FROM HAH.DIM_PAYCODE_MAPPING WHERE SOURCE_SYSTEM_ID = 5 AND PAY_CODE_CATEGORY ILIKE ''%REGULAR%'')
	QUALIFY RANK = 1
),
ADMIN_PAY_RATE AS (
	SELECT EMPLOYEE_ID, GP_HOURLY_RATE, GP_ANNUAL_SALARY FROM (
        SELECT DISTINCT TRIM( erb.EMPLOYEE_ID) AS EMPLOYEE_ID,
            erb.PAY_RATE AS GP_HOURLY_RATE, GP_HOURLY_RATE*40*52 AS GP_ANNUAL_SALARY,
            RANK() OVER ( PARTITION BY TRIM( erb.EMPLOYEE_ID) ORDER BY erb.LAST_PAID_DATE DESC, erb.PAY_RATE DESC) AS ROWNUM
        FROM DISC_PROD.GPSYNCDATA.GPALLEMPLOYEERATESBASE erb
        INNER JOIN DISC_PROD.GPSYNCDATA.GPALLEMPLOYEESBASE emp
            ON TRIM( erb.EMPLOYEE_ID) = TRIM( emp.EMPLOYEE_ID) AND emp.IS_ADMIN = 1	
        WHERE /*erb.INACTIVE = 0 AND*/ TRIM( erb.PAY_CODE) = ''ADM'' AND erb.PAY_RATE IS NOT NULL AND erb.PAY_RATE > 0
        ) RATE
    WHERE RATE.ROWNUM = 1
),
PAY_RATE_SALARY AS (
	SELECT DISTINCT 
		ROW_NUMBER() OVER (PARTITION BY FP.EMPLOYEE_ID ORDER BY PAYROLL_DATE DESC) AS RANK, 
		FP.EMPLOYEE_ID, MQ.pay_code, 
--		FP.PAY_RATE AS PAYROLL_PAY_RATE, 
		CASE WHEN EMP.EMPLOYEE_CATEGORY ILIKE ''ADMIN'' THEN MAL.GP_HOURLY_RATE ELSE MQ.PAY_RATE END AS DERIVED_PAY_RATE,
		DERIVED_PAY_RATE * 40 * 52 AS SALARY,
		PAYROLL_DATE,
--		PAYROLL_PAY_RATE - MQ.PAY_RATE AS DIFF, 
		EMP.EMPLOYEE_CATEGORY,
		FP.SYSTEM_CODE
	FROM HAH.FACT_PAYROLL FP
	LEFT JOIN HAH.DIM_EMPLOYEE EMP
		ON EMP.EMPLOYEE_KEY = FP.EMPLOYEE_KEY 
	LEFT JOIN RATE_BASE_PAY_RATE MQ
		ON TRIM(mq.employee_id) = TRIM(FP.EMPLOYEE_ID) AND FP.PAYROLL_DATE = MQ.LAST_PAID_DATE::DATE
	LEFT JOIN ADMIN_PAY_RATE MAL
		ON MAL.EMPLOYEE_ID = FP.EMPLOYEE_ID 
	WHERE FP.SOURCE_SYSTEM_ID = 5 
	QUALIFY RANK = 1 ORDER BY PAYROLL_DATE DESC
) --SELECT * FROM PAY_RATE_SALARY;
SELECT DISTINCT
	MD5( CAST( emp.MASTER_ID AS VARCHAR)||''-''|| emp.db ) AS Employee_Key,
    emp.Employee_ID AS Employee_ID,
	emp.db AS System_Code,
	5 AS Source_System_ID,
	CASE WHEN TRIM( emp.ssn) NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) AND TRIM( emp.ssn) NOT LIKE ''00000%'' AND LENGTH( TRIM( emp.SSN)) = 9 THEN HEX_ENCODE( TRIM( emp.SSN))
		WHEN TRIM( dfe.ssn) NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) AND TRIM( dfe.ssn) NOT LIKE ''00000%'' AND LENGTH( TRIM( dfe.SSN)) = 9 THEN HEX_ENCODE( TRIM( dfe.SSN))
		ELSE NULL
	END AS EMPLOYEE_PID,
	CASE WHEN TRY_CAST(emp.Employee_ID AS NUMBER) < 0 THEN NULL
		ELSE TRY_CAST(emp.Employee_ID AS NUMBER)
    END AS EMPLOYEE_NUMBER,
	CASE WHEN CAST( emp.DOB AS DATE) >= CAST( ''1901-01-01'' AS DATE) AND CAST( emp.DOB AS DATE) <= DATEADD( YEAR, -12, CURRENT_DATE) THEN CAST( emp.DOB AS DATE)
		WHEN dfe.DOB >= CAST( ''1901-01-01'' AS DATE) AND dfe.DOB <= DATEADD( YEAR, -12, CURRENT_DATE) THEN dfe.DOB
    	ELSE NULL
     END AS EMPLOYEE_DOB,
	NULL AS Employee_Date_of_Death,
    CASE WHEN emp.Hire_Date >= CAST( ''1960-01-01'' AS DATE) AND emp.Hire_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND emp.HIRE_DATE >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN CAST( emp.Hire_Date AS DATE)
    	WHEN dfe.HireDate >= CAST( ''1960-01-01'' AS DATE) AND dfe.HireDate <= DATEADD( YEAR, +1, CURRENT_DATE) AND dfe.HIREDATE >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN dfe.HireDate
        ELSE NULL
	END AS EMPLOYEE_HIRE_DATE,
    NULL AS Employee_Rehire_Date,
	CASE WHEN CAST( emp.BENEFIT_START_DATE AS DATE) >= CAST( ''1960-01-01'' AS DATE) AND CAST( emp.Benefit_Start_Date AS DATE) <= DATEADD( YEAR, +1, CURRENT_DATE) AND CAST( emp.BENEFIT_START_DATE AS DATE) >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN CAST( emp.BENEFIT_START_DATE AS DATE)
    	ELSE NULL
	END AS Employee_Benefit_Start_Date,
    CASE WHEN CAST( emp.FIRST_CHECK_DATE AS DATE) >= CAST( ''1960-01-01'' AS DATE) AND emp.First_Check_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND emp.First_Check_Date >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN CAST( emp.FIRST_CHECK_DATE AS DATE)
		ELSE NULL
	END AS Employee_First_Check_Date,
	CASE WHEN CAST( emp.Last_Check_Date AS DATE) >= CAST( ''1960-01-01'' AS DATE) AND CAST( emp.Last_Check_Date AS DATE) <= DATEADD( YEAR, +1, CURRENT_DATE) AND emp.Last_Check_Date >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN CAST( emp.Last_Check_Date AS DATE)
		WHEN dfe.LastCheckDate >= CAST( ''1960-01-01'' AS DATE) AND dfe.LastCheckDate <= DATEADD( YEAR, +1, CURRENT_DATE) AND dfe.LastCheckDate >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN dfe.LastCheckDate
		ELSE NULL
	END AS EMPLOYEE_LAST_CHECK_DATE,
	CASE WHEN CAST( emp.Last_Day_Worked AS DATE) >= CAST( ''1960-01-01'' AS DATE) AND CAST( emp.Last_Day_Worked AS DATE) > Employee_Hire_Date AND CAST( emp.Last_Day_Worked AS DATE) >= NVL( Employee_Hire_Date, CAST( ''1960-01-01'' AS DATE)) THEN CAST( emp.Last_Day_Worked AS DATE)
    	WHEN dfe.TerminateDate >= CAST( ''1960-01-01'' AS DATE) AND dfe.TerminateDate > Employee_Hire_Date AND dfe.TerminateDate >= NVL( Employee_Hire_Date, CAST( ''1960-01-01'' AS DATE)) THEN dfe.TerminateDate
		ELSE NULL
	END AS Employee_Last_Worked_DATE,
    CASE WHEN CAST( emp.Terminate_Date AS DATE) >= CAST( ''1960-01-01'' AS DATE) AND CAST( emp.Terminate_Date AS DATE) > Employee_Hire_Date AND CAST( emp.Terminate_Date AS DATE) >= NVL( Employee_Hire_Date, CAST( ''1960-01-01'' AS DATE)) THEN CAST( emp.Terminate_Date AS DATE)
--    	WHEN dfe.TerminateDate >= CAST( ''1960-01-01'' AS DATE) AND dfe.TerminateDate > Employee_Hire_Date AND dfe.TerminateDate >= NVL( GREATEST(dfe.HireDate, Employee_Hire_Date), CAST( ''1960-01-01'' AS DATE)) THEN dfe.TerminateDate
    	ELSE NULL
	END AS EMPLOYEE_TERMINATE_DATE,
	UPPER( TRIM( emp.Reason_To_Term)) AS Reason_to_Terminate,
	IFF( emp.Inactive = 0, ''TRUE'', ''FALSE'') AS Active_Employee_Flag,
	dfe.AbleToRehire AS Able_To_Rehire_Flag,
	NULL AS Employee_Prefix,
	CASE WHEN UPPER( TRIM( emp.First_Name)) <> '''' AND UPPER( TRIM( emp.First_Name)) IS NOT NULL THEN UPPER( TRIM( emp.First_Name))
    	WHEN UPPER( TRIM( dfe.FirstName)) <> '''' THEN UPPER( TRIM( dfe.FirstName))
        ELSE NULL
	END AS Employee_First_Name,
    CASE WHEN TRIM( emp.MIDDLE_NAME) <> '''' AND TRIM( emp.MIDDLE_NAME) IS NOT NULL THEN TRIM( UPPER( regexp_replace( emp.Middle_Name,''\\\\\\\\\\\\\\\\d|\\\\\\\\\\\\\\\\.|\\\\\\\\\\\\\\\\+|\\\\\\\\\\\\\\\\,|\\\\\\\\\\\\\\\\-'','''')))
          WHEN TRIM( dfe.MIDDLENAME) <> '''' THEN TRIM( UPPER( regexp_replace( dfe.MiddleName,''\\\\\\\\\\\\\\\\d|\\\\\\\\\\\\\\\\.|\\\\\\\\\\\\\\\\+|\\\\\\\\\\\\\\\\,|\\\\\\\\\\\\\\\\-'','''')))
          ELSE NULL
     END AS Employee_Middle_Name,
    CASE WHEN UPPER( TRIM( emp.Last_Name)) <> '''' AND UPPER( TRIM( emp.Last_Name)) IS NOT NULL THEN UPPER( TRIM( emp.Last_Name))
    	WHEN UPPER( TRIM( dfe.LastName)) <> '''' THEN UPPER( TRIM( dfe.LastName))
        ELSE NULL
	END AS Employee_Last_Name,
    NULL AS Employee_Suffix,
    CASE WHEN UPPER( TRIM( emp.Address1)) <>  '''' AND UPPER( TRIM( emp.Address1)) IS NOT NULL THEN UPPER( TRIM( emp.Address1))
    	WHEN UPPER( TRIM( dfe.Address1)) <>  '''' THEN UPPER( TRIM( dfe.Address1))
        ELSE NULL
	END AS Employee_Address1,
    CASE WHEN UPPER( TRIM( emp.Address2)) <>  '''' OR UPPER( TRIM( emp.Address3)) <>  '''' THEN IFF( UPPER( TRIM( emp.Address2)) IS NOT NULL, UPPER( TRIM( emp.Address2)), '''') || IFF( UPPER( TRIM( emp.Address3)) IS NOT NULL, '' ''||UPPER( TRIM( emp.Address3)), '''') 
    	WHEN UPPER( TRIM( dfe.Address2)) <>  '''' THEN UPPER( TRIM( dfe.Address2))
        ELSE NULL
	END AS Employee_Address2,
    CASE WHEN UPPER( TRIM( emp.City)) <>  '''' AND UPPER( TRIM( emp.City)) IS NOT NULL THEN UPPER( TRIM( emp.City))
    	WHEN UPPER( TRIM( dfe.City)) <>  '''' THEN UPPER( TRIM( dfe.City))
        ELSE NULL
	END AS Employee_City,
    st.State_ISO_Code AS EMPLOYEE_STATE_CODE,
    zip.Zip_Code AS Employee_Zip,
--    CASE WHEN TRIM( REGEXP_REPLACE( emp.Phone_Number,''\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\.|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\,|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\+|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\-|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\?|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\]|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\(|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\)|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\s|[a-z]|[A-Z]|'''''','''')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND emp.Phone_Number NOT LIKE ''%0000000%'' AND LENGTH( TRIM( REGEXP_REPLACE( emp.Phone_Number,''\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\.|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\,|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\+|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\-|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\?|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\]|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\(|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\)|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\s|[a-z]|[A-Z]|'''''',''''))) = 10 THEN TRIM( REGEXP_REPLACE( emp.Phone_Number,''\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\.|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\,|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\+|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\-|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\?|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\]|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\(|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\)|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\s|[a-z]|[A-Z]|'''''','''')) 
--    	WHEN TRIM( REGEXP_REPLACE( dfe.PhoneNumber,''\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\.|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\,|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\+|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\-|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\?|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\]|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\(|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\)|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\s|[a-z]|[A-Z]|'''''','''')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND dfe.PhoneNumber NOT LIKE ''%0000000%'' AND LENGTH( TRIM( REGEXP_REPLACE( dfe.PhoneNumber,''\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\.|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\,|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\+|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\-|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\?|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\]|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\(|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\)|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\s|[a-z]|[A-Z]|'''''',''''))) = 10 THEN TRIM( REGEXP_REPLACE( dfe.PhoneNumber,''\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\.|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\,|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\+|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\-|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\?|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\]|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\(|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\)|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\|\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\s|[a-z]|[A-Z]|'''''','''')) 
--        ELSE NULL
--	END AS Employee_Home_Phone,
	CASE 
		WHEN DW_PROD.STAGE.PHONE_CLEANUP(emp.Phone_Number) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND DW_PROD.STAGE.PHONE_CLEANUP(emp.Phone_Number) NOT LIKE ''%0000000%'' AND DW_PROD.STAGE.PHONE_CLEANUP(emp.Phone_Number) IS NOT NULL
			THEN DW_PROD.STAGE.PHONE_CLEANUP(emp.Phone_Number)
		WHEN DW_PROD.STAGE.PHONE_CLEANUP(dfe.PhoneNumber) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND DW_PROD.STAGE.PHONE_CLEANUP(dfe.PhoneNumber) NOT LIKE ''%0000000%'' AND DW_PROD.STAGE.PHONE_CLEANUP(dfe.PhoneNumber) IS NOT NULL
			THEN DW_PROD.STAGE.PHONE_CLEANUP(dfe.PhoneNumber)
		ELSE NULL
	END AS Employee_Home_Phone,
    NULL AS Employee_Cell_Phone,
    NULL AS Employee_Work_Phone,
--    UPPER(TRIM(EMA."Home Email")) AS Employee_Personal_Email,
--    UPPER(TRIM(EMA."Company Email")) AS Employee_Work_Email,
    NVL(UPPER(TRIM(EMA."Home Email")),
	CASE 
		WHEN NOT emp.PERSONAL_EMAIL ILIKE ''HELPATHOME'' THEN NULLIF(UPPER(TRIM(emp.PERSONAL_EMAIL)), '''')
		ELSE NULLIF(UPPER(TRIM(emp.PERSONAL_EMAIL)), '''')
	END
	) AS Employee_Personal_Email,
	COALESCE(UPPER(TRIM(EMA."Company Email")), NULLIF(UPPER(TRIM(emp.EMAIL)), ''''),
		CASE
			WHEN NOT emp.PERSONAL_EMAIL ILIKE ''HELPATHOME'' THEN NULLIF(UPPER(TRIM(emp.PERSONAL_EMAIL)),
			'''')
			ELSE NULLIF(UPPER(TRIM(emp.PERSONAL_EMAIL)),
			'''')
		END) AS Employee_work_Email,
    NULL AS Linked_In_Profile_URL,
    CASE WHEN UPPER( TRIM( emp.Gender_Text)) IN (''FEMALE'', ''MALE'') THEN UPPER( TRIM( emp.Gender_Text))
    	WHEN UPPER( dfe.Gender) = ''F'' THEN ''FEMALE''
        WHEN UPPER( dfe.Gender) = ''M'' THEN ''MALE''
        ELSE NULL
	END AS EMPLOYEE_GENDER,
  CASE WHEN TRIM(emp.ETHICS) ILIKE ''%Two or More Races%'' THEN UPPER(''Two or More'')
        WHEN TRIM(emp.ETHICS) ILIKE ''%Native Hawaiian or Pacific Islander%'' THEN UPPER(''Native Hawaiian or Other Pacific Islander'')
        WHEN TRIM(emp.ETHICS) ILIKE ''%American Indian or Alaskan Native%'' THEN UPPER(''American Indian or Alaska Native'')
	    WHEN emp.ETHICS ILIKE ANY (''%HISPANIC%'',''%LATINO%'') THEN NULL
        WHEN UPPER( TRIM( emp.Ethics)) NOT IN ( ''N/A'', '''') THEN UPPER(TRIM( emp.Ethics))
    	WHEN dfe.Ethics = ''W'' THEN UPPER(''White'')
		WHEN dfe.Ethics = ''B'' THEN UPPER(''Black or African American'')
        WHEN dfe.Ethics = ''A'' THEN UPPER(''Asian'')
		ELSE NULL	
END AS EMPLOYEE_ETHNICITY,
CASE WHEN TRIM(emp.ETHICS) ILIKE ANY(''HISPANIC%'',''LATINO%'',''HISPANIC OR LATINO%'') THEN TRUE 
        WHEN (trim(emp.ETHICS) = '''' OR trim(emp.ETHICS)= ''N/A'') AND  dfe.Ethics = ''H'' THEN TRUE 
        ELSE FALSE END AS HISPANIC_OR_LATINO,
	NULL AS EMPLOYEE_LANGUAGE,
    CASE WHEN UPPER( TRIM( emp.Marital_Status_Text)) NOT IN ( ''N/A'', '''') THEN emp.Marital_Status_Text
    	ELSE NULL
	END AS EMPLOYEE_MARITAL_STATUS,
	CASE WHEN UPPER( TRIM( emp.EMPLOYMENT_TYPE_TEXT)) <> ''UNKNOWN (         6)'' THEN TRIM( emp.EMPLOYMENT_TYPE_TEXT)
		ELSE NULL
	END AS EMPLOYEE_TYPE,
	CASE WHEN TRIM( emp.DB) = ''HAHIL'' THEN ''CORP''
    	WHEN EMP.IS_ADMIN = 0 THEN ''FIELD'' 
		ELSE ''ADMIN'' 
	END AS Employee_Category,
    NULL AS Exempt_Flag,
	TRIM( emp.JOB_TITLE) AS Job_Title, 
	TRIM( emp.JOB_DESCRIPTION) AS Job_Description, 
	TRIM( emp.CLASS_ID) AS Class_Id, 
	TRIM( emp.WORKERS_COMP) AS Workers_Comp,
	TRIM( dfe.PayrollId) AS PAYROLL_ID,
	NULL AS Percent_401k_Deduction,
	NULL AS Amount_401k_Deduction,
	NULL AS JazzHR_Applicant_ID,
	NULL AS JazzHR_User_ID,
	NULL AS JazzHR_Contact_ID,
	brnch.Office_State_Code AS Work_State,
	suta_st.State_ISO_Code AS SUTA_State,
	UPPER( emp.Department) AS Employee_Department,
	emp.Office_NO AS Employee_Office_CODE,
	brnch.Branch_Key AS Primary_Branch_Key,
	brnch.Office_State_Code AS Primary_Branch_State,
	brnch.Detailed_Office_Name AS Primary_Branch_Name,
	brnch.System_Code AS Primary_Branch_System_Code,
	NULL AS CASE_MANAGER_FLAG,
	NULL AS SUPERVISOR_FLAG,
	NULL AS COORDINATOR_FLAG,
	NULL AS LINKED_ID,
	HEX_ENCODE(PRS.SALARY) AS SALARY,
	HEX_ENCODE(PRS.DERIVED_PAY_RATE) AS PAY_RATE,
	IFF( Employee_Hire_Date IS NULL, IFF( Employee_First_Check_Date IS NULL,  IFF( Employee_Benefit_Start_Date IS NULL, CAST( ''1900-01-01'' AS DATE), Employee_Benefit_Start_Date), Employee_First_Check_Date), Employee_Hire_Date) AS EFFECTIVE_FROM_DATE,
	IFF( Employee_Terminate_Date IS NULL, IFF( Employee_Last_Worked_Date IS NULL, IFF( Employee_Last_Check_Date IS NULL, CAST( ''2030-12-31'' AS DATE), Employee_Last_Check_Date), Employee_Last_Worked_Date), Employee_Terminate_Date) AS EFFECTIVE_TO_DATE,
	NULL AS MDM_DIM_EMPLOYEE_KEY,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY ,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY,
	0 as ETL_DELETED_FLAG,
	0 as ETL_INFERRED_MEMBER_FLAG
FROM DISC_DEDUPE_PROD.GPSYNCDATA.EMPLOYEE_MASTER_LIST AS emp
LEFT JOIN DISC_PROD.GPSYNCDATA.GPSYNC_EMPLOYEES_EMAIL EMA
	ON TRIM(EMA.SSN) = TRIM(EMP.SSN)
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DfEmployees AS dfe ON TRIM( dfe.PayrollID) = TRIM( emp.Employee_ID) AND TRIM( dfe.DBName) = TRIM( emp.Office_State) AND TRIM( emp.DB) <> ''HAHIL''
LEFT OUTER JOIN HAH.DIM_State AS st ON UPPER( TRIM( emp.State)) = st.State_ISO_Code OR UPPER( TRIM( emp.State)) = UPPER( st.State_Name)
LEFT OUTER JOIN HAH.DIM_Branch AS brnch ON ( LPAD( CAST( brnch.Office_Number AS VARCHAR), 3, ''0'') = LPAD( TRIM( emp.Office_NO), 3, ''0'') AND brnch.Source_System_ID = 3 AND emp.Office_No NOT IN (908, 950, 951, 17, 52, 53, 60, -1)) 
                                               OR ( LPAD( CAST( brnch.Office_Number AS VARCHAR), 3, ''0'') = LPAD( TRIM( emp.Office_NO), 3, ''0'') AND brnch.Source_System_ID = 3 AND emp.Office_No IN (908, 950, 951, 17, 52, 53, 60, -1) AND brnch.Office_State_Code = UPPER( TRIM( emp.Work_State)))
                                               OR ( TRY_CAST(emp.office_no AS INT) = brnch.OFFICE_NUMBER  AND brnch.source_system_id = 5)
LEFT OUTER JOIN HAH.DIM_Zip_Code AS zip ON UPPER( zip.Zip_Code) = RIGHT(''00000'' || LEFT(TRIM(UPPER( emp.Zip)),5),5)
LEFT OUTER JOIN HAH.DIM_State AS suta_st ON UPPER( TRIM( SUBSTRING( emp.SUTA_State,1 ,2))) = suta_st.State_ISO_Code OR UPPER( TRIM( emp.SUTA_State)) = UPPER( suta_st.State_Name)
LEFT JOIN PAY_RATE_SALARY PRS 
	ON TRIM(PRS.EMPLOYEE_ID) = TRIM(EMP.EMPLOYEE_ID)
	AND TRIM(PRS.SYSTEM_CODE) = TRIM(EMP.DB);

RETURN ''SUCCESS'';

END;
';