resource "snowflake_procedure" "DW_HAH_GET_STAGE_TRUSTPOINTDATA_DIM_EMPLOYEE" {
	name ="GET_STAGE_TRUSTPOINTDATA_DIM_EMPLOYEE"
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


BEGIN

--*****************************************************************************************************************************
-- NAME: TRUSTPOINT_DIM_EMPLOYEE
--
-- PURPOSE: Creates one row per employee_id/database according to Trustpoint
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 02/21/20    Frank Noordover       Initial development
-- 04/01/20    Mohd Kamaludin        Added CDC
-- 05/04/20    Mohd Kamaludin        Updated Hash Employee to match Sandata Fact Visit and Fact Revenue (StaffAgencyID)
-- 06/21/20    Frank Noordover       Added logic for visit attributes and improve data quality
-- 10/22/20    Frank Noordover       Revised logic and added additional columns for DIM_EMPLOYEE     
-- 01/05/20    Mir Ali               Changed Branch_Key to be more consistent
-- 02/13/20    Frank Noordover       Fixed the State and Zip join logic for Sandata when State and Zip are empty strings
-- 09/08/21    Mir Ali               Fixed to accomodate other companies from TrustPoint
-- 09/25/21    Frank Noordover       Revised for Trustpoint GA data and enhanced primary branch logic
-- 01/23/23    Abhishek Sunil		 Revised ZipCode Join Logic
-- 08/28/23	   Dhaval Vachheta		 Updated the branch logic
-- 09/05/2023  trushali ramoliya      ethnicity - change to uppercase only
-- 11/10/2023  Deepen Gajjar         Added a logic for HISPANIC_OR_LATINO and update the logic for ethnicity as per ticket - IDDOX- 388.
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.TRUSTPOINTDATA_DIM_EMPLOYEE

WITH EMPLOYEES AS (
    SELECT DISTINCT 
        MASTER_ID, EMPLOYEE_NUMBER, COMPANY
    FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEE_MASTER_LIST
    UNION ALL
    SELECT DISTINCT 
        MASTER_ID, EMPLOYEE_NUMBER, COMPANY
    FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEE_MATCH_LIST 
    WHERE EMPLOYEE_NUMBER NOT IN (SELECT DISTINCT EMPLOYEE_NUMBER FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEE_MASTER_LIST)
    UNION
    SELECT DISTINCT
        MASTER_ID, ID AS EMPLOYEE_NUMBER, UPPER(TRIM(EMPLOYEE_EIN)) AS COMPANY
    FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEE_MAPPING_MATCH_LIST
    WHERE ID NOT IN (SELECT EMPLOYEE_NUMBER FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEE_MASTER_LIST UNION SELECT EMPLOYEE_NUMBER FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEE_MATCH_LIST)
),EMPLOYEE_CHECK_DATE AS
(
	SELECT COMPANY,EMPLOYEE_ID AS EMPLOYEE_ID,MIN(PAYROLL_DATE) AS FIRST_CHECK_DATE,MAX(PAYROLL_DATE) AS LAST_CHECK_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.PAYROLL
	GROUP BY COMPANY,EMPLOYEE_ID
),
TRUSTPOINT_MAPPING AS (
SELECT DISTINCT MAP.MASTER_ID, MAP.ID AS EMPLOYEE_NUMBER, UPPER(TRIM(MAP.EMPLOYEE_EIN)) AS COMPANY, ML.EMPLOYEE_OFFICE_NUMBER
FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEE_MAPPING_MATCH_LIST AS MAP
LEFT JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEE_MASTER_LIST AS ML ON MAP.MASTER_ID = ML.MASTER_ID
WHERE MAP.ID NOT IN (SELECT EMPLOYEE_NUMBER 
                 FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEE_MASTER_LIST 
                 UNION 
                 SELECT EMPLOYEE_NUMBER 
                 FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEE_MATCH_LIST)
),
TRUSTPOINT_BRANCHES AS (
WITH LATEST_PAYROLL AS 
        (
            SELECT DISTINCT 
                ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_ID, COMPANY ORDER BY PAYROLL_DATE::DATE DESC) RANK,
                PAY.EMPLOYEE_ID, PAYROLL_DATE, PAY.ID AS RECORD_ID, PAY.COMPANY, PAY.BRANCH_NAME
                FROM DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.PAYROLL AS PAY
                WHERE TRIM( PAY.BRANCH_NAME) IS NOT NULL
                QUALIFY RANK = 1
        )
SELECT DISTINCT TRIM( emp.Employee_Number) AS Employee_Number,
		TRIM( emp.Company) AS Company,
--		emp.ID,
		TRIM( emp.Employee_Office_Number) AS Office_Number,
		br.Office_Number::STRING AS Emp_Office_Number,
		br.Branch_Name AS Branch_Name,
		br.Branch_Key AS Prim_Branch_Key,
		br.Office_State_Code AS Prim_Branch_State,
--		br.Detailed_Office_Name AS Prim_Branch_Name,
		CASE WHEN br.DETAILED_OFFICE_NAME IS NULL 
        	THEN TRIM(BR.OFFICE_STATE_CODE) || '' - '' || (BR.BRANCH_NAME) || '' ('' || TRIM(BR.OFFICE_NUMBER) || '')''
        	 ELSE br.DETAILED_OFFICE_NAME
        END AS PRIM_BRANCH_NAME,
		br.System_Code AS Prim_Branch_System_Code
FROM DISC_${var.SF_ENVIRONMENT}.TrustPointData.Employees AS emp
LEFT JOIN LATEST_PAYROLL PAYROLL
	ON TRIM( PAYROLL.Employee_ID) = TRIM( emp.Employee_Number) AND TRIM( PAYROLL.Company) = TRIM( emp.Company)
LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_Branch BR
    ON
    (UPPER(TRIM(BR.BRANCH_NAME)) = UPPER(TRIM(PAYROLL.BRANCH_NAME))
        OR BR.SYSTEM_CODE || '' - '' || UPPER(TRIM(BR.BRANCH_NAME))= UPPER(TRIM(PAYROLL.BRANCH_NAME))
        OR BR.SYSTEM_CODE || '' - '' || UPPER(TRIM(BR.BRANCH_NAME)) = UPPER(TRIM(PAYROLL.BRANCH_NAME)) || IFF(PAYROLL.COMPANY = ''EXCEL'','' PA'',NULL))
    AND br.SYSTEM_CODE = PAYROLL.COMPANY
GROUP BY ALL
UNION
SELECT DISTINCT TRIM( emp.Employee_Number) AS Employee_Number,
		TRIM( emp.Company) AS Company,
--		emp.ID,
		TRIM( emp.EMPLOYEE_OFFICE_NUMBER) AS Office_Number,
		br.Office_Number::STRING AS Emp_Office_Number,
		br.Branch_Name AS Branch_Name,
		br.Branch_Key AS Prim_Branch_Key,
		br.Office_State_Code AS Prim_Branch_State,
--		br.Detailed_Office_Name AS Prim_Branch_Name,
		CASE WHEN br.DETAILED_OFFICE_NAME IS NULL 
        	THEN TRIM(BR.OFFICE_STATE_CODE) || '' - '' || (BR.BRANCH_NAME) || '' ('' || TRIM(BR.OFFICE_NUMBER) || '')''
        	 ELSE br.DETAILED_OFFICE_NAME
        END AS PRIM_BRANCH_NAME,
		br.System_Code AS Prim_Branch_System_Code
FROM TRUSTPOINT_MAPPING AS emp
LEFT JOIN LATEST_PAYROLL PAYROLL
	ON TRIM( PAYROLL.Employee_ID) = TRIM( emp.Employee_Number) AND TRIM( PAYROLL.Company) = TRIM( emp.Company)
LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_Branch BR
    ON
    (UPPER(TRIM(BR.BRANCH_NAME)) = UPPER(TRIM(PAYROLL.BRANCH_NAME))
        OR BR.SYSTEM_CODE || '' - '' || UPPER(TRIM(BR.BRANCH_NAME))= UPPER(TRIM(PAYROLL.BRANCH_NAME))
        OR BR.SYSTEM_CODE || '' - '' || UPPER(TRIM(BR.BRANCH_NAME)) = UPPER(TRIM(PAYROLL.BRANCH_NAME)) || IFF(PAYROLL.COMPANY = ''EXCEL'','' PA'',NULL))
    AND br.SYSTEM_CODE = PAYROLL.COMPANY
GROUP BY ALL
), 
JOIN_EMPLOYEES_TRUSTPOINT_BRANCHES AS (
    SELECT DISTINCT E.*, TB.Branch_Name,TB.Emp_Office_Number, TB.Prim_Branch_Key, TB.Prim_Branch_State, TB.Prim_Branch_System_Code, TB.Prim_Branch_Name, COUNT(E.MASTER_ID ) OVER (PARTITION BY E.MASTER_ID) AS RN--,tb_b.Prim_Branch_Name
    FROM EMPLOYEES E
    LEFT JOIN TRUSTPOINT_BRANCHES tb 
        ON E.EMPLOYEE_NUMBER = tb.Employee_Number AND E.COMPANY = tb.Company 
    WHERE TB.Prim_Branch_Name IS NOT NULL
    QUALIFY RN = 1
    UNION ALL
    SELECT DISTINCT E.*, TB.Branch_Name,TB.Emp_Office_Number, TB.Prim_Branch_Key, TB.Prim_Branch_State, TB.Prim_Branch_System_Code, TB.Prim_Branch_Name, COUNT(E.MASTER_ID ) OVER (PARTITION BY E.MASTER_ID) AS RN
    FROM EMPLOYEES E
    LEFT JOIN TRUSTPOINT_BRANCHES tb 
        ON E.EMPLOYEE_NUMBER = tb.Employee_Number AND E.COMPANY = tb.Company 
    left JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEE_MASTER_LIST M
        ON M.COMPANY = E.COMPANY AND M.EMPLOYEE_NUMBER = E.EMPLOYEE_NUMBER
    WHERE TB.Prim_Branch_Name IS NOT NULL --AND MASTER_EMPLOYEE_NUMBER IS NOT NULL
    QUALIFY RN >1 AND M.EMPLOYEE_NUMBER IS NOT NULL
),
SALARY_RATE AS (
	SELECT DISTINCT 
		ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_ID, COMPANY ORDER BY PAYROLL_DATE::DATE DESC) AS RANK,
		COMPANY, EMPLOYEE_ID, PAYROLL_DATE::DATE, 
		SERVICE_PAY_AMOUNT/ CASE WHEN SERVICE_HOURS = 0 THEN NULL ELSE SERVICE_HOURS END AS DERIVED_RATE, 
		DERIVED_RATE * 40 * 52 AS DERIVED_SALARY
	FROM DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.PAYROLL PAY
	QUALIFY RANK = 1
)
SELECT
	MD5( TRIM( tp.Company) || ''-'' || TRIM(tp.MASTER_ID) || ''-'' || ''1900-01-01'' || ''-'' || ''TRUSTPOINTDATA'') AS Employee_key
	, TRIM(tp.Employee_Number) AS Employee_ID
	, TRIM( tp.Company) AS System_Code
	, 6 AS Source_System_ID
	, CASE WHEN TRIM( tp.Employee_SSN) NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN) AND TRIM( tp.Employee_SSN) NOT LIKE ''00000%'' AND LENGTH( TRIM( tp.Employee_SSN)) = 9 THEN HEX_ENCODE( TRIM( tp.Employee_SSN))
	ELSE NULL
	END AS EMPLOYEE_PID
	, TRY_CAST( tp.Employee_Number AS INT) AS Employee_Number
	, CASE WHEN tp.Employee_DOB >= CAST( ''1901-01-01'' AS DATE) AND tp.Employee_DOB <= DATEADD( YEAR, -12, CURRENT_DATE) THEN tp.Employee_DOB
	ELSE NULL
	END AS EMPLOYEE_DOB
	, NULL AS EMPLOYEE_Date_Of_Death
	, CASE WHEN tp.Employee_Hire_Date >= CAST( ''1960-01-01'' AS DATE) AND tp.Employee_Hire_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND tp.Employee_Hire_Date >= DATEADD( YEAR, 12, NVL( Employee_DOB, CAST(''1948-01-01'' AS DATE))) THEN tp.Employee_Hire_Date
	ELSE NULL
	END AS EMPLOYEE_HIRE_DATE
	, CASE WHEN tp.Employee_Rehire_Date >= CAST( ''1960-01-01'' AS DATE) AND tp.Employee_Rehire_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND tp.Employee_Rehire_Date > tp.Employee_Hire_Date THEN tp.Employee_Rehire_Date
	ELSE NULL
	END AS EMPLOYEE_REHIRE_DATE
	, NULL AS Employee_Benefit_Start_Date
	, EC.FIRST_CHECK_DATE AS Employee_First_Check_Date
	, EC.LAST_CHECK_DATE AS Employee_Last_Check_Date
	, CASE WHEN tp.Employee_Last_Worked_Date >= CAST( ''1960-01-01'' AS DATE) AND tp.Employee_Last_Worked_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND tp.Employee_Last_Worked_Date > Employee_Hire_Date THEN tp.Employee_Last_Worked_Date
	ELSE NULL
	END AS Employee_Last_Worked_DATE
	, CASE WHEN tp.Employee_Terminate_Date >= CAST( ''1960-01-01'' AS DATE) AND tp.Employee_Terminate_Date <= DATEADD( YEAR, +1, CURRENT_DATE) AND tp.Employee_Terminate_Date > Employee_Hire_Date THEN tp.Employee_Terminate_Date
	ELSE NULL
	END AS EMPLOYEE_TERMINATE_DATE
	, tp.Reason_To_Terminate AS Reason_To_Terminate
	, CAST( tp.Active_Employee_Flag AS BOOLEAN) AS Active_Employee_Flag
	, NULL AS Able_to_Rehire_Flag
	, NULL AS Employee_Prefix
	, CASE WHEN UPPER( TRIM( tp.Employee_First_Name)) <> '''' THEN UPPER( TRIM( tp.Employee_First_Name))
	ELSE NULL
	END AS Employee_First_Name
	, CASE WHEN UPPER( TRIM( tp.Employee_MIDDLE_NAME)) <> '''' THEN TRIM( UPPER( regexp_replace( tp.Employee_Middle_Name,''[^a-zA-Z ]'','''')))
	ELSE NULL
	END AS Employee_Middle_Name
	, CASE WHEN UPPER( TRIM( tp.Employee_Last_Name)) <> '''' THEN UPPER( TRIM( tp.Employee_Last_Name))
	ELSE NULL
	END AS Employee_Last_Name
	, CASE WHEN UPPER( TRIM( tp.Employee_Suffix)) <> '''' THEN UPPER( TRIM( tp.Employee_Suffix))
	ELSE NULL
	END AS Employee_Suffix
	, CASE WHEN UPPER( TRIM( tp.Employee_Address1)) <> '''' THEN UPPER( TRIM( tp.Employee_Address1))
	ELSE NULL
	END AS Employee_Address1
	, CASE WHEN UPPER( TRIM( tp.Employee_Address2)) <> '''' THEN UPPER( TRIM( tp.Employee_Address2))
	ELSE NULL
	END AS Employee_Address2
	, CASE WHEN UPPER( TRIM( tp.Employee_City)) <> '''' THEN UPPER( TRIM( tp.Employee_City))
	ELSE NULL
	END AS Employee_City
	, st.State_ISO_Code AS EMPLOYEE_STATE_CODE
	, COALESCE(zip.Zip_Code,tp.EMPLOYEE_ZIP) AS Employee_Zip
	, CASE WHEN TRIM( REGEXP_REPLACE( tp.Employee_Home_Phone,''[^0-9]'','''')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND tp.Employee_Home_Phone NOT LIKE ''%0000000%'' AND LENGTH( TRIM( REGEXP_REPLACE( tp.Employee_Home_Phone,''[^0-9]'',''''))) = 10 THEN TRIM( REGEXP_REPLACE( tp.Employee_Home_Phone,''[^0-9]'',''''))
	ELSE NULL
	END AS Employee_Home_Phone
	, CASE WHEN TRIM( REGEXP_REPLACE( tp.Employee_Cell_Phone,''[^0-9]'','''')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND tp.Employee_Cell_Phone NOT LIKE ''%0000000%'' AND LENGTH( TRIM( REGEXP_REPLACE( tp.Employee_Cell_Phone,''[^0-9]'',''''))) = 10 THEN TRIM( REGEXP_REPLACE( tp.Employee_Cell_Phone,''[^0-9]'',''''))
	ELSE NULL
	END AS Employee_Cell_Phone
	, CASE WHEN TRIM( REGEXP_REPLACE( tp.Employee_Work_Phone,''[^0-9]'','''')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND tp.Employee_Work_Phone NOT LIKE ''%0000000%'' AND LENGTH( TRIM( REGEXP_REPLACE( tp.Employee_Work_Phone,''[^0-9]'',''''))) = 10 THEN TRIM( REGEXP_REPLACE( tp.Employee_Work_Phone,''[^0-9]'',''''))
	ELSE NULL
	END AS Employee_Work_Phone
	, COALESCE(NULLIF(PERSONAL_EMAIL, ''''), PRIMARY_EMAIL) AS Employee_Personal_Email
	, tp.PRIMARY_EMAIL AS Employee_Work_Email
	, NULL AS Linked_In_Profile_URL
	, CASE WHEN UPPER( TRIM( tp.Employee_Gender)) = ''M'' THEN ''MALE''
	WHEN UPPER( TRIM( tp.Employee_Gender)) = ''F'' THEN ''FEMALE''
	ELSE NULL
	END AS Employee_Gender
	,  CASE WHEN UPPER( TRIM( tp.Employee_Ethnicity)) = ''UNIDENTIFIED/OPT OUT'' OR TRIM( tp.Employee_Ethnicity) = '''' OR tp.Employee_Ethnicity IS NULL THEN NULL
	WHEN TRIM( tp.Employee_Ethnicity) = ''Native Hawaiian or Other Pacific Islander (not Hispanic or Latino)'' THEN UPPER(''Native Hawaiian or Other Pacific Islander'')
	WHEN TRIM( tp.Employee_Ethnicity) ILIKE ''%Two or More Races%''THEN UPPER(''Two or more'')
	WHEN  tp.Employee_Ethnicity ILIKE ANY (''not%'',''hispanic%'') THEN NULL
	WHEN TRIM( tp.Employee_Ethnicity) IS NOT NULL THEN UPPER(TRIM( REPLACE( tp.Employee_Ethnicity, ''(not Hispanic or Latino)'', '''')))
	ELSE NULL
	END AS Employee_Ethnicity
	,CASE  WHEN  tp.Employee_Ethnicity ILIKE ANY (''%not%HISPANIC%OR%LATINO%'') THEN FALSE 
  WHEN   tp.Employee_Ethnicity ILIKE ANY  (''%HISPANIC%OR%LATINO%'') THEN TRUE
  ELSE FALSE END AS HISPANIC_OR_LATINO			  
	, NULL AS EMPLOYEE_LANGUAGE
	, NULL AS Employee_Marital_Status
	, TRIM( tp.Employee_Type) AS Employee_Type
	, CASE WHEN UPPER( tp.Field_Worker_Flag) = ''TRUE'' THEN ''FIELD''
	WHEN UPPER( TP.FIELD_WORKER_FLAG) = ''FALSE'' THEN ''ADMIN''
	ELSE ''FIELD''
	END AS Employee_Category
	, NULL AS Exempt_Flag
	, CASE WHEN tp.Job_Title IS NOT NULL THEN TRIM( tp.Job_Title)
	ELSE NULL
	END AS Job_Title
	, NULLIF(TRIM(JOB_DESCRIPTION),'''')AS Job_Description
	, NULL AS Class_ID
	, NULL AS Workers_Comp
	, TRIM(tp.Employee_Number) AS Payroll_ID
	, NULL AS Percent_401k_Deduction
	, NULL AS Amount_401k_Deduction
	, NULL AS JazzHR_Applicant_ID
	, NULL AS JazzHR_User_ID
	, NULL AS JazzHR_Contact_ID
	, tp.SUTA_State AS Work_State
	, tp.SUTA_State AS SUTA_State
	, NULL AS Employee_Department
	, CAST( TRY_CAST( tb.Emp_Office_Number AS INTEGER) AS STRING) AS Employee_Office_Code
	, COALESCE(tb.Prim_Branch_Key, md5(TP.COMPANY || ''-'' || ''Unknown'' || ''-'' ||  ''TRUSTPOINTDATA'')) AS Primary_Branch_Key
	, tb.Prim_Branch_State AS Primary_Branch_State
	, COALESCE(TB.PRIM_BRANCH_NAME, TB.BRANCH_NAME, ''UNKNOWN'') AS PRIMARY_BRANCH_NAME
	, tb.Prim_Branch_System_Code AS Primary_Branch_System_Code
	, NULL AS CASE_MANAGER_FLAG
	, NULL AS SUPERVISOR_FLAG
	, NULL AS COORDINATOR_FLAG
	, HEX_ENCODE(SALARY_PAY) AS SALARY
	, HEX_ENCODE(HOURLY_PAY) AS PAY_RATE
	, IFF( Employee_ReHire_Date IS NULL, IFF( Employee_Hire_Date IS NULL, CAST( ''1900-01-01'' AS DATE), Employee_Hire_Date), Employee_ReHire_Date) AS Effective_From_Date
	, IFF( Employee_Terminate_Date IS NULL, CAST( ''2070-12-31'' AS DATE), Employee_Terminate_Date) AS Effective_To_Date
	, NULL MDM_DIM_Employee_Key,
		:STR_ETL_TASK_KEY -1 AS ETL_TASK_KEY,
		:STR_ETL_TASK_KEY -1 AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
		CURRENT_USER as ETL_INSERTED_BY ,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
		CURRENT_USER as ETL_LAST_UPDATED_BY,
		0 as ETL_DELETED_FLAG,
		0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEE_MASTER_LIST AS tp
LEFT OUTER JOIN JOIN_EMPLOYEES_TRUSTPOINT_BRANCHES AS tb ON TRIM(tp.MASTER_ID) = TRIM(tb.MASTER_ID)
LEFT OUTER JOIN EMPLOYEE_CHECK_DATE AS EC ON TRIM( tp.Employee_Number) = TRIM( EC.EMPLOYEE_ID) AND TRIM( tp.Company) = TRIM( EC.Company)
LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_State AS st ON st.State_ISO_Code = UPPER( tp.Employee_State_Code)
LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_Zip_Code AS zip ON UPPER( zip.Zip_Code) = RIGHT(''00000'' || LEFT(UPPER( tp.Employee_Zip),5),5)
LEFT JOIN SALARY_RATE SR
	ON SR.EMPLOYEE_ID = TP.EMPLOYEE_NUMBER AND SR.Company = TP.COMPANY
WHERE TP.COMPANY IN (''PRIME'', ''PRIMEMIDWAY'',''PRIMEHHA'', ''E3'', ''COASTAL'', ''EXCEL'', ''ALTRUS'', ''ANSWERCARE'',''HAHMI'',  ''HAHDELAWARE'', ''CARECOORDINATION'');

RETURN ''SUCESS'';

END;

 EOT
}

