resource "snowflake_view" "DW_STAGE_VW_CURRENT_ALAYACARE_DIM_EMPLOYEE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_ALAYACARE_DIM_EMPLOYEE"
	statement = <<-SQL
	 WITH EMPLOYEE AS 
(
SELECT * FROM 
(
	SELECT EMPLOYEE_ID,MASTER_ID,EMPLOYEE_ID AS ORIGINAL_RECORD_ID,BRANCH_ID
	FROM  DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.EMPLOYEE_MASTER_LIST  
) 
UNION
SELECT * FROM 
(
	SELECT DISTINCT ID,MASTER_ID,ID AS ORIGINAL_RECORD_ID,BRANCH_ID
	FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.EMPLOYEE_MATCH_LIST 
	WHERE ID NOT IN (SELECT EMPLOYEE_ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.EMPLOYEE_MASTER_LIST ) 
) 
)
, LAST_SERVICE AS (
SELECT  NVL(E.BRANCH_ID,VISITS.BRANCH_ID) AS BRANCH_ID
		,NVL(E.MASTER_ID::INT,VISITS.EMPLOYEE_ID::INT) AS EMPLOYEE_ID 
		,MAX(DATE_TRUNC (DAY,START_AT)) AS LAST_SERVICE_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.ALAYACARE.VISIT VISITS
	LEFT JOIN EMPLOYEE E ON VISITS.EMPLOYEE_ID = E.EMPLOYEE_ID AND VISITS.BRANCH_ID = E.BRANCH_ID
	WHERE  VISITS.IS_PAID = 1 OR VISITS.IS_INVOICED = 1 OR VISITS.VISIT_COMPLETED = 1 --WHEN VISITS.IS_PAID = 1 THEN '05' WHEN VISITS.IS_INVOICED = 1 THEN '04' WHEN VISITS.VISIT_COMPLETED = 1 THEN '02'
	GROUP BY NVL(E.BRANCH_ID,VISITS.BRANCH_ID),NVL(E.MASTER_ID::INT,VISITS.EMPLOYEE_ID::INT)
)
SELECT EMPLOYEE_KEY
FROM (
	SELECT DISTINCT 
	MD5(NVL(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), 'Unknown') || ' (' || NVL(E.BRANCH_ID,'-1') || ')' || '-' || E.MASTER_ID || '-' || 'ALAYACARE') AS EMPLOYEE_KEY
	,E.EMPLOYEE_ID
	,NVL(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), 'Unknown') || ' (' || NVL(E.BRANCH_ID,'-1') || ')' AS SYSTEM_CODE
	,9 AS SOURCE_SYSTEM_ID
	,CASE WHEN TRIM( E.PROFILE_SSN) NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN)
				AND TRIM( E.PROFILE_SSN) NOT LIKE '00000%' AND LENGTH( TRIM( E.PROFILE_SSN)) = 9
				THEN HEX_ENCODE( TRIM( E.PROFILE_SSN))
			ELSE NULL
			END AS EMPLOYEE_PID
	,E.EMPLOYEE_ID AS EMPLOYEE_NUMBER
	,CASE WHEN E.PROFILE_BIRTHDAY::DATE < '1901-01-01'::DATE 
				OR E.PROFILE_BIRTHDAY::DATE > DATEADD( YEAR, -12, CURRENT_DATE) THEN NULL
			ELSE COALESCE(TRY_TO_DATE(E.PROFILE_BIRTHDAY, 'YYYY-MM-DD'), TRY_TO_DATE(E.PROFILE_BIRTHDAY, 'YYYY-M-DD'))
			END AS EMPLOYEE_DOB
	,NULL AS EMPLOYEE_DATE_OF_DEATH
	,COALESCE(E.PROFILE_START_DATE::DATE,E.CREATED_AT::DATE) AS EMPLOYEE_HIRE_DATE 
	,NULL AS EMPLOYEE_REHIRE_DATE 
	,NULL AS EMPLOYEE_BENEFIT_START_DATE 
	,NULL AS EMPLOYEE_FIRST_CHECK_DATE
	,NULL AS EMPLOYEE_LAST_CHECK_DATE
	,LAST_SERVICE_DATE AS EMPLOYEE_LAST_WORKED_DATE
	,CASE WHEN PROFILE_TERMINATION_DATE = '' THEN NULL ELSE 
		COALESCE(TRY_TO_DATE(E.PROFILE_TERMINATION_DATE, 'YYYY-MM-DD'), TRY_TO_DATE(E.PROFILE_TERMINATION_DATE, 'YYYY-M-DD'))
		END AS EMPLOYEE_TERMINATE_DATE
	,LEFT(TRIM(PROFILE_TERMINATION_REASON), 50) AS REASON_TO_TERMINATE
	,CASE WHEN E.STATUS IN (1,4,5) THEN 'TRUE' ELSE 'FALSE' END AS ACTIVE_EMPLOYEE_FLAG --01 - Active, 02 - Terminated, 03 - Suspended, 04 - Hold, 05 - Pending, 06 - Applicant, 07 - Rejected
	,CASE  PROFILE_DO_NOT_HIRE_ WHEN 'YES' THEN TRUE WHEN  'NO' THEN FALSE ELSE NULL END AS ABLE_TO_REHIRE_FLAG 
	,NULL AS Employee_Prefix 
	,UPPER( TRIM( E.PROFILE_FIRST_NAME)) AS EMPLOYEE_FIRST_NAME
	,UPPER( TRIM( E.PROFILE_MIDDLE_NAME)) AS EMPLOYEE_MIDDLE_NAME
	,UPPER( TRIM( E.PROFILE_LAST_NAME)) AS EMPLOYEE_LAST_NAME
	,NULL AS EMPLOYEE_SUFFIX
	,UPPER( TRIM( E.PROFILE_ADDRESS)) AS EMPLOYEE_ADDRESS_1
	,UPPER( TRIM( E.PROFILE_ADDRESS_SUITE)) AS EMPLOYEE_ADDRESS_2
	,UPPER( TRIM(E.PROFILE_CITY)) AS EMPLOYEE_CITY
	,UPPER( TRIM(E.PROFILE_STATE)) AS EMPLOYEE_STATE_CODE
	,TRIM(E.PROFILE_ZIP) AS EMPLOYEE_ZIP
	,NULL AS EMPLOYEE_HOME_PHONE
	,CASE WHEN TRIM( REGEXP_REPLACE( E.PROFILE_PHONE_MAIN,'\\.|\\,|\\+|\\-|\\?|\\]|\\/|\\(|\\)|\\\\|\\s|[a-z]|[A-Z]|','')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND E.PROFILE_PHONE_MAIN NOT LIKE '%0000000%' AND LENGTH( TRIM( REGEXP_REPLACE( E.PROFILE_PHONE_MAIN,'\\.|\\,|\\+|\\-|\\?|\\]|\\/|\\(|\\)|\\\\|\\s|[a-z]|[A-Z]|',''))) = 10 
	THEN TRIM( REGEXP_REPLACE( E.PROFILE_PHONE_MAIN,'\\.|\\,|\\+|\\-|\\?|\\]|\\/|\\(|\\)|\\\\|\\s|[a-z]|[A-Z]|',''))
			ELSE NULL END AS EMPLOYEE_CELL_PHONE
	,CASE WHEN TRIM( REGEXP_REPLACE( E.PROFILE_PHONE_PERSONAL,'\\.|\\,|\\+|\\-|\\?|\\]|\\/|\\(|\\)|\\\\|\\s|[a-z]|[A-Z]|','')) NOT IN (SELECT Phone_Number FROM Data_Management.Data_Quality.Invalid_Phone_Number) AND E.PROFILE_PHONE_PERSONAL NOT LIKE '%0000000%' AND LENGTH( TRIM( REGEXP_REPLACE( E.PROFILE_PHONE_PERSONAL,'\\.|\\,|\\+|\\-|\\?|\\]|\\/|\\(|\\)|\\\\|\\s|[a-z]|[A-Z]|',''))) = 10 
	THEN TRIM( REGEXP_REPLACE( E.PROFILE_PHONE_PERSONAL,'\\.|\\,|\\+|\\-|\\?|\\]|\\/|\\(|\\)|\\\\|\\s|[a-z]|[A-Z]|',''))
			ELSE NULL END AS EMPLOYEE_WORK_PHONE
	,TRIM(E.PROFILE_PERSONAL_EMAIL) AS Employee_Personal_Email
	,TRIM(E.PROFILE_EMAIL) AS Employee_Work_Email
	,NULL AS Linked_In_Profile_URL
	,CASE WHEN UPPER(TRIM(E.PROFILE_GENDER)) = 'M' THEN 'MALE'
					WHEN UPPER(TRIM(E.PROFILE_GENDER)) = 'F' THEN 'FEMALE'
					ELSE E.PROFILE_GENDER 
			END AS Employee_Gender
	,CASE WHEN TRIM(E.PROFILE_ETHNICITY) LIKE '%Black or African%' THEN 'Black or African American'
					WHEN TRIM(E.PROFILE_ETHNICITY) LIKE '%White%' THEN 'White'
					WHEN TRIM(E.PROFILE_ETHNICITY) LIKE '%Asian' THEN 'Asian'
					WHEN TRIM(E.PROFILE_ETHNICITY) LIKE '%Hispanic or Latino%' THEN 'Hispanic or Latino'
					WHEN TRIM(E.PROFILE_ETHNICITY) LIKE '%American Indian or Alaskan Native%' THEN 'American Indian or Alaskan Native'
					ELSE E.PROFILE_ETHNICITY END AS Employee_Ethnicity
	,CASE WHEN PROPERTIES_TBL_USERS_LANGUAGE = 'en_us' THEN 'English' END AS EMPLOYEE_LANGUAGE
	,CASE UPPER(TRIM(E.PROFILE_MARITAL_STATUS))
				WHEN 'D' THEN 'Divorced'
				WHEN 'S' THEN 'Single'
				WHEN 'W' THEN 'Widowed'
				WHEN 'M' THEN 'Married'
				WHEN 'DIVORCED' THEN 'Divorced'
				WHEN 'SINGLE' THEN 'Single'
				WHEN 'WIDOWED' THEN 'Widowed'
				WHEN 'MARRIED' THEN 'Married'
				ELSE NULL END AS EMPLOYEE_MARITAL_STATUS
	,NULL AS EMPLOYEE_TYPE --NEED TO CONFIRM PROFILE_TYPE_OF_CAREGIVER IS PROPER COLUMN TO USE HERE?
	,'Field' AS EMPLOYEE_CATEGORY --THERE ARE SOME  EMPLOYEE WHICH ARE NOT FILED, NEED TO CONFIRM
	,NULL AS EXEMPT_FLAG
	,UPPER( TRIM( E.PROFILE_JOB_TITLE)) AS JOB_TITLE
	,NULL AS Job_Description
	,NULL AS CLASS_ID
	,NULL AS WORKERS_COMP
	,CONCAT('AC', LPAD(E.GUID, 9, '0')) AS PAYROLL_ID
	,NULL AS PERCENT_401K_DEDUCTION
	,NULL AS AMOUNT_401K_DEDUCTION
	,NULL AS JAZZHR_APPLICANT_ID
	,NULL AS JAZZHR_USER_ID
	,NULL AS JAZZHR_CONTACT_ID
	,UPPER( TRIM(E.PROFILE_STATE)) AS Work_State 
	,NULL AS SUTA_State
	,NULL AS Employee_Department
	,GROUPS.GROUP_ID AS EMPLOYEE_OFFICE_CODE 
	,MD5(NVL(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), 'Unknown') || ' (' || NVL(E.BRANCH_ID,'-1') || ')' || '-' || GROUPS.GROUP_ID || '-' || 'ALAYACARE') AS PRIMARY_BRANCH_KEY
	,UPPER(TRIM(COALESCE(STATE.STATE_ISO_CODE, COMPANY.PROFILE_STATE))) AS PRIMARY_BRANCH_STATE
	,UPPER(TRIM(GROUPS.PROFILE_COMPANY)) AS PRIMARY_BRANCH_NAME
	,NVL(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), 'Unknown') || ' (' || NVL(E.BRANCH_ID,'-1') || ')' AS PRIMARY_BRANCH_SYSTEM_CODE 
	,NULL AS CASE_MANAGER_FLAG
	,NULL AS SUPERVISOR_FLAG
	,NULL AS COORDINATOR_FLAG
	,E.PROFILE_IMPORT_ID AS LINKED_ID
	,TO_DATE('1900-01-01', 'YYYY-MM-DD') AS EFFECTIVE_FROM_DATE
	,TO_DATE('9999-12-31', 'YYYY-MM-DD') AS EFFECTIVE_TO_DATE
	,NULL AS MDM_DIM_EMPLOYEE_KEY,
	-1 AS ETL_TASK_KEY,
	-1 AS ETL_INSERTED_TASK_KEY,
	convert_timezone('UTC', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY,
	convert_timezone('UTC', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY,
	0 as ETL_DELETED_FLAG,
	0 as ETL_INFERRED_MEMBER_FLAG
	FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.EMPLOYEE_MASTER_LIST E
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.TBL_GUID_COST_CENTRE_TIER_4 COST_CENTRE_MAPPING
	ON COST_CENTRE_MAPPING.GUID_TO = E.GUID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.TBL_COST_CENTRES_TIER_4 AS COST_CENTRE
	ON COST_CENTRE.ID = COST_CENTRE_MAPPING.COST_CENTRE_ID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.GROUPS AS GROUPS
	ON GROUPS.BRANCH_ID = COST_CENTRE.PROPERTIES_BRANCH_ID
	AND GROUPS.PROFILE_COMPANY = COST_CENTRE.PROPERTIES_DESCRIPTION
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.BRANCH AS COMPANY
	ON COMPANY.BRANCH_ID = E.BRANCH_ID 
	LEFT JOIN HAH.DIM_STATE AS STATE
		ON UPPER(TRIM(STATE.STATE_NAME)) = UPPER(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION))
	LEFT JOIN LAST_SERVICE AS LS 
	ON  E.MASTER_ID = LS.EMPLOYEE_ID 
	AND E.BRANCH_ID=LS.BRANCH_ID
) L
WHERE L.SYSTEM_CODE = 'Georgia (1002)';
SQL
	or_replace = true 
	is_secure = false 
}

