resource "snowflake_procedure" "DW_HAH_GET_STAGE_CLEARCARE_DIM_EMPLOYEE" {
	name ="GET_STAGE_CLEARCARE_DIM_EMPLOYEE"
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
--*****************************************************************************************************************************
-- NAME:  Clear care DIM EMPLOYEE
--
-- PURPOSE: Populates Stage Dim EMPLOYEE for Clear Care 
--			
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 08/05/21    SAM HUFF             Initial version
-- 09/25/2023  Trushali Ramoliya    added the logic for payroll_ID as per subtask of IDDOX- 386
-- 11/10/2023  Shikhar Saxena 		Updated Employee ethnicity logic and added HISPANIC_OR_LATINO column
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.CLEARCARE_DIM_EMPLOYEE
SELECT DISTINCT
MD5(''CLEARCARE'' || ''-'' || EM.MASTER_ID  || ''-'' || ''CLEARCARE'') AS EMPLOYEE_KEY,
EM.MASTER_ID::INT AS EMPLOYEE_ID,
''CLEARCARE'' AS SYSTEM_CODE,
16 AS SOURCE_SYSTEM_ID,
--NVL(TE.EMPLOYEE_SSN, EM.CAREGIVER_ID) AS EMPLOYEE_PID,
NULL AS EMPLOYEE_PID,
EM.ID AS EMPLOYEE_NUMBER,
TO_DATE(EM.DOB)  AS EMPLOYEE_DOB,
NULL AS EMPLOYEE_DATE_OF_DEATH,
--USED SYSTEM CREATED DATE
TO_DATE(SE.HIRE_DATE)  AS EMPLOYEE_HIRE_DATE,
NULL AS EMPLOYEE_REHIRE_DATE,
NULL AS EMPLOYEE_BENEFIT_START_DATE,
--FIRST AND LAST CARELOG DATES FOR NEXT 4
NULL AS EMPLOYEE_FIRST_CHECK_DATE,    --- MIN OF FIRST CHECK DATE FROM PAYROLL TABLE
NULL AS EMPLOYEE_LAST_CHECK_DATE,   --- MAX OF FIRST CHECK DATE FROM PAYROLL TABLE
TO_DATE(CA.LAST_CARELOG_DATE)  AS EMPLOYEE_LAST_WORKED_DATE,
TO_DATE(SE.TERMINATION_DATE) AS EMPLOYEE_TERMINATE_DATE,
CASE WHEN CA.DEACTIVATION_REASON = 10 THEN ''LEAVE OF ABSENCE''
     WHEN CA.DEACTIVATION_REASON = 20 THEN ''SUSPENSION''
     WHEN CA.DEACTIVATION_REASON = 30 THEN ''QUIT''
     WHEN CA.DEACTIVATION_REASON = 40 THEN ''INSUFFICIENT WORK AVAILABLE''
     WHEN CA.DEACTIVATION_REASON = 50 THEN ''FOR CAUSE''
     WHEN CA.DEACTIVATION_REASON = 60 THEN ''INACTIVE''
     WHEN CA.DEACTIVATION_REASON = 70 THEN ''OTHER''
     WHEN CA.DEACTIVATION_REASON = 80 THEN ''DISABILITY''
     END AS REASON_TO_TERMINATE,
CASE WHEN CA.DEACTIVATION_REASON IS NULL THEN UPPER(TRIM(CA.IS_HIRED)) ELSE ''FALSE'' END AS ACTIVE_EMPLOYEE_FLAG,
NULL AS ABLE_TO_REHIRE_FLAG,
NULL AS EMPLOYEE_PREFIX,
TRIM(UPPER(EM.FIRST_NAME))  AS EMPLOYEE_FIRST_NAME,
TRIM(UPPER(PR.MIDDLE_NAME))  AS EMPLOYEE_MIDDLE_NAME,
TRIM(UPPER(EM.LAST_NAME))  AS EMPLOYEE_LAST_NAME,
NULL AS EMPLOYEE_SUFFIX,
TRIM(UPPER(EM.ADDRESS)) AS EMPLOYEE_ADDRESS1,
TRIM(UPPER(PR.ADDRESS_LINE_2)) AS EMPLOYEE_ADDRESS2,
TRIM(UPPER(EM.CITY)) AS EMPLOYEE_CITY,
--IDENTIFY STATE
PR.STATE AS EMPLOYEE_STATE_CODE,
TRIM(PR.ZIP)  AS EMPLOYEE_ZIP,
TRIM(EM.PHONE)  AS EMPLOYEE_HOME_PHONE,
TRIM(PR.MOBILE_PHONE)  AS EMPLOYEE_CELL_PHONE,
TRIM(PR.WORK_PHONE)  AS EMPLOYEE_WORK_PHONE,
PR.EMAIL AS EMPLOYEE_PERSONAL_EMAIL,         
PR.EMAIL AS EMPLOYEE_WORK_EMAIL,             
NULL AS LINKED_IN_PROFILE_URL,
CASE
	WHEN EM.GENDER = ''F'' THEN ''FEMALE''
	WHEN EM.GENDER = ''M'' THEN ''MALE''
END AS EMPLOYEE_GENDER,
NULL AS EMPLOYEE_ETHNICITY,
FALSE AS HISPANIC_OR_LATINO,
NULL AS EMPLOYEE_LANGUAGE,
NULL AS EMPLOYEE_MARITAL_STATUS,
CASE WHEN CA.EMPLOYMENT_TYPE = 0 THEN ''BOTH''
     WHEN CA.EMPLOYMENT_TYPE = 1 THEN ''CONTRACTOR''
     WHEN CA.EMPLOYMENT_TYPE = 2 THEN ''EMPLOYEE''
     END AS EMPLOYEE_TYPE,
--FIELD? IDENTIFY ALTERNATE EMPLOYEE TYPE
''FIELD'' AS EMPLOYEE_CATEGORY,   
NULL AS EXEMPT_FLAG,
PR.TITLE AS JOB_TITLE,     
NULL AS JOB_DESCRIPTION,       
NULL AS CLASS_ID,
NULL AS WORKERS_COMP,
CASE WHEN trim(PR.EXTERNAL_ID) = '''' OR trim(PR.EXTERNAL_ID) ILIKE ANY (''%@%'',''%#%'',''%-%'',''%:%'',''%xx%'') THEN NULL 
ELSE trim(PR.EXTERNAL_ID) END AS PAYROLL_ID,
NULL AS PERCENT_401K_DEDUCTION,
NULL AS AMOUNT_401K_DEDUCTION,
NULL AS JAZZHR_APPLICANT_ID,
NULL AS JAZZHR_USER_ID,
NULL AS JAZZHR_CONTACT_ID,
--IDENTIFY WORK STATE
''OH'' AS WORK_STATE,  
NULL AS SUTA_STATE,
NULL AS EMPLOYEE_DEPARTMENT,         
AG.AGENCY_ID AS EMPLOYEE_OFFICE_CODE, 
MD5( AG.AGENCY_ID || ''-'' || AG.NAME || ''-'' || ''CLEARCARE'') AS PRIMARY_BRANCH_KEY, 
''OH'' AS PRIMARY_BRANCH_STATE,  
''OH'' || '' - '' || UPPER(AG.NAME) || '' - '' || AG.ID AS PRIMARY_BRANCH_NAME, 
''CLEARCARE'' AS PRIMARY_BRANCH_SYSTEM_CODE,
NULL AS CASE_MANAGER_FLAG,        
NULL AS SUPERVISOR_FLAG,
NULL AS COORDINATOR_FLAG,
NULL AS LINKED_ID,
TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
NULL AS MDM_DIM_EMPLOYEE_KEY,
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
                        
CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
CURRENT_USER AS ETL_INSERTED_BY ,
CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
CURRENT_USER AS ETL_LAST_UPDATED_BY,
0 AS ETL_DELETED_FLAG,
0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.CLEARCARE.EMPLOYEE_MASTER_LIST EM
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.profile_patient_agencylocation AS PR ON EM.CAREGIVER_ID = PR.CAREGIVER_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.caregiver_caregiver AS CA ON PR.caregiver_id = CA.id 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.caregiver_caregiverskillseducation SE ON SE.caregiver_id = PR.caregiver_id
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.AGENCY_AGENCYLOCATION AG ON AG.ID = CA.LOCATION_ID
--LEFT JOIN CHECK_DATES CD ON CD.CAREGIVER_ID = EM.CAREGIVER_ID
--LEFT JOIN DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEES TE ON UPPER(TE.EMPLOYEE_FIRST_NAME) = EM.FIRST_NAME AND UPPER(TE.EMPLOYEE_LAST_NAME) = EM.LAST_NAME
WHERE CA.is_hired = true AND AG.AGENCY_ID IN (2459);
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}

