resource "snowflake_procedure" "DW_INTEGRATION_GET_MASTER_DIM_EMPLOYEE_NY_MERGED_DEDUPE" {
	name ="GET_MASTER_DIM_EMPLOYEE_NY_MERGED_DEDUPE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
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
  RETURN_RESULT VARCHAR(1000);
BEGIN
INSERT INTO DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_MERGED_DEDUPE
WITH LWD_NEW AS
(
	SELECT ID,
	ROW_number() OVER (PARTITION BY CLUSTER_ID ORDER BY EMPLOYEE_LAST_CHECK_DATE DESC NULLS LAST, EMPLOYEE_FIRST_CHECK_DATE DESC NULLS LAST, EMPLOYEE_LAST_WORKED_DATE DESC NULLS LAST, EMPLOYEE_HIRE_DATE DESC NULLS LAST, EMPLOYEE_TERMINATE_DATE DESC NULLS LAST, SYSTEM_CODE ASC) AS SRC_PRI,
	CLUSTER_ID
	FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_NY_RL_OUTPUT
	WHERE CLUSTER_ID IS NOT NULL
),
LWD_OLD AS
(
	SELECT ID,
	ROW_number() OVER (PARTITION BY CLUSTER_ID ORDER BY EMPLOYEE_LAST_CHECK_DATE ASC NULLS LAST, EMPLOYEE_FIRST_CHECK_DATE ASC NULLS LAST, EMPLOYEE_LAST_WORKED_DATE ASC NULLS LAST, EMPLOYEE_HIRE_DATE ASC NULLS LAST, EMPLOYEE_TERMINATE_DATE ASC NULLS LAST, SYSTEM_CODE DESC) AS SRC_PRI,
	CLUSTER_ID
	FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_NY_RL_OUTPUT
	WHERE CLUSTER_ID IS NOT NULL
)
,NEW AS (
	SELECT * FROM (
		SELECT
			SRC_PRI,
			row_number() over(partition by NYO.CLUSTER_ID order by SRC_PRI ASC) min_record_id,
			NYO.ID,EMPLOYEE_ID,SYSTEM_CODE,SOURCE_SYSTEM_ID,EMPLOYEE_PID,EMPLOYEE_NUMBER,EMPLOYEE_DOB,
			EMPLOYEE_DATE_OF_DEATH,
			MIN(EMPLOYEE_HIRE_DATE::date) OVER(PARTITION BY NYO.CLUSTER_ID) AS DERIVED_EMPLOYEE_HIRE_DATE,
			MAX(EMPLOYEE_REHIRE_DATE::date) OVER(PARTITION BY NYO.CLUSTER_ID) AS DERIVED_EMPLOYEE_REHIRE_DATE,
			MIN(EMPLOYEE_BENEFIT_START_DATE::date) OVER(PARTITION BY NYO.CLUSTER_ID) AS DERIVED_EMPLOYEE_BENEFIT_START_DATE,
			MIN(EMPLOYEE_FIRST_CHECK_DATE::date) OVER(PARTITION BY NYO.CLUSTER_ID) AS DERIVED_EMPLOYEE_FIRST_CHECK_DATE,
			MAX(EMPLOYEE_LAST_CHECK_DATE::date) OVER(PARTITION BY NYO.CLUSTER_ID) AS DERIVED_EMPLOYEE_LAST_CHECK_DATE,
			MAX(EMPLOYEE_LAST_WORKED_DATE::date) OVER(PARTITION BY NYO.CLUSTER_ID) AS DERIVED_EMPLOYEE_LAST_WORKED_DATE,
			EMPLOYEE_TERMINATE_DATE,EMPLOYEE_HIRE_DATE::date AS EMPLOYEE_HIRE_DATE,EMPLOYEE_REHIRE_DATE::date AS EMPLOYEE_REHIRE_DATE,EMPLOYEE_BENEFIT_START_DATE::date AS EMPLOYEE_BENEFIT_START_DATE,
			EMPLOYEE_FIRST_CHECK_DATE::date AS EMPLOYEE_FIRST_CHECK_DATE, EMPLOYEE_LAST_CHECK_DATE::date AS EMPLOYEE_LAST_CHECK_DATE,EMPLOYEE_LAST_WORKED_DATE::date AS EMPLOYEE_LAST_WORKED_DATE,
			REASON_TO_TERMINATE,ACTIVE_EMPLOYEE_FLAG,ABLE_TO_REHIRE_FLAG,EMPLOYEE_PREFIX,EMPLOYEE_FIRST_NAME,EMPLOYEE_MIDDLE_NAME,EMPLOYEE_LAST_NAME,EMPLOYEE_SUFFIX,EMPLOYEE_ADDRESS1,EMPLOYEE_ADDRESS2,EMPLOYEE_CITY,EMPLOYEE_STATE_CODE,EMPLOYEE_ZIP,EMPLOYEE_HOME_PHONE,EMPLOYEE_CELL_PHONE,EMPLOYEE_WORK_PHONE,EMPLOYEE_PERSONAL_EMAIL,EMPLOYEE_WORK_EMAIL,LINKED_IN_PROFILE_URL,EMPLOYEE_GENDER,EMPLOYEE_ETHNICITY,EMPLOYEE_LANGUAGE,EMPLOYEE_MARITAL_STATUS,EMPLOYEE_TYPE,EMPLOYEE_CATEGORY,EXEMPT_FLAG,JOB_TITLE,JOB_DESCRIPTION,CLASS_ID,WORKERS_COMP,PAYROLL_ID,PERCENT_401K_DEDUCTION,AMOUNT_401K_DEDUCTION,JAZZHR_APPLICANT_ID,JAZZHR_USER_ID,JAZZHR_CONTACT_ID,WORK_STATE,SUTA_STATE,EMPLOYEE_DEPARTMENT,EMPLOYEE_OFFICE_CODE,PRIMARY_BRANCH_KEY,PRIMARY_BRANCH_STATE,PRIMARY_BRANCH_NAME,PRIMARY_BRANCH_SYSTEM_CODE,CASE_MANAGER_FLAG,SUPERVISOR_FLAG,COORDINATOR_FLAG,LINKED_ID, SALARY, PAY_RATE, EFFECTIVE_FROM_DATE,EFFECTIVE_TO_DATE,MDM_DIM_EMPLOYEE_KEY,ETL_TASK_KEY,ETL_INSERTED_TASK_KEY,ETL_INSERTED_DATE,ETL_INSERTED_BY,ETL_LAST_UPDATED_DATE,ETL_LAST_UPDATED_BY,ETL_DELETED_FLAG,ETL_INFERRED_MEMBER_FLAG
			,NYO.CLUSTER_ID 
		FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_NY_RL_OUTPUT NYO
		INNER JOIN LWD_NEW 
			ON LWD_NEW.ID = NYO.ID
		WHERE NYO.CLUSTER_ID IS NOT NULL
	)
	WHERE min_record_id = 1
) -- SELECT * FROM NEW;
, OLD AS (
SELECT * FROM (
	SELECT 
		SRC_PRI,
		row_number() over(partition by NYO.CLUSTER_ID order by SRC_PRI DESC) min_record_id,
		NYO.ID,SOURCE_SYSTEM_ID,SYSTEM_CODE,EMPLOYEE_NUMBER,EMPLOYEE_PID,NYO.CLUSTER_ID
		FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_NY_RL_OUTPUT NYO
		INNER JOIN LWD_OLD 
			ON LWD_OLD.ID = NYO.ID
		WHERE NYO.CLUSTER_ID IS NOT NULL
	) -- WHERE min_record_id = 1
) --SELECT * FROM OLD;
SELECT distinct 
	O.ID ORIGINAL_EMPLOYEE_KEY,O.SOURCE_SYSTEM_ID ORIGINAL_SOURCE_SYSTEM_ID ,O.SYSTEM_CODE ORIGINAL_SYSTEM_CODE,O.EMPLOYEE_NUMBER ORIGINAL_EMPLOYEE_NUMBER,O.EMPLOYEE_PID ORIGINAL_EMPLOYEE_PID,
	N.ID AS EMPLOYEE_KEY,N.EMPLOYEE_ID,N.SYSTEM_CODE,N.SOURCE_SYSTEM_ID,N.EMPLOYEE_PID,N.EMPLOYEE_NUMBER,N.EMPLOYEE_DOB,
	N.EMPLOYEE_DATE_OF_DEATH,
	N.EMPLOYEE_HIRE_DATE,
	N.EMPLOYEE_REHIRE_DATE,
	N.EMPLOYEE_BENEFIT_START_DATE,
	N.EMPLOYEE_FIRST_CHECK_DATE,
	N.EMPLOYEE_LAST_CHECK_DATE,
	N.EMPLOYEE_LAST_WORKED_DATE,
	N.EMPLOYEE_TERMINATE_DATE,
	N.REASON_TO_TERMINATE,N.ACTIVE_EMPLOYEE_FLAG,N.ABLE_TO_REHIRE_FLAG,N.EMPLOYEE_PREFIX,N.EMPLOYEE_FIRST_NAME,N.EMPLOYEE_MIDDLE_NAME,N.EMPLOYEE_LAST_NAME,N.EMPLOYEE_SUFFIX,N.EMPLOYEE_ADDRESS1,N.EMPLOYEE_ADDRESS2,N.EMPLOYEE_CITY,N.EMPLOYEE_STATE_CODE,N.EMPLOYEE_ZIP,N.EMPLOYEE_HOME_PHONE,N.EMPLOYEE_CELL_PHONE,N.EMPLOYEE_WORK_PHONE,N.EMPLOYEE_PERSONAL_EMAIL,N.EMPLOYEE_WORK_EMAIL,N.LINKED_IN_PROFILE_URL,N.EMPLOYEE_GENDER,N.EMPLOYEE_ETHNICITY,N.EMPLOYEE_LANGUAGE,N.EMPLOYEE_MARITAL_STATUS,N.EMPLOYEE_TYPE,N.EMPLOYEE_CATEGORY,N.EXEMPT_FLAG,N.JOB_TITLE,N.JOB_DESCRIPTION,N.CLASS_ID,N.WORKERS_COMP,N.PAYROLL_ID,N.PERCENT_401K_DEDUCTION,N.AMOUNT_401K_DEDUCTION,N.JAZZHR_APPLICANT_ID,N.JAZZHR_USER_ID,N.JAZZHR_CONTACT_ID,N.WORK_STATE,N.SUTA_STATE,N.EMPLOYEE_DEPARTMENT,N.EMPLOYEE_OFFICE_CODE,N.PRIMARY_BRANCH_KEY,N.PRIMARY_BRANCH_STATE,N.PRIMARY_BRANCH_NAME,N.PRIMARY_BRANCH_SYSTEM_CODE,N.CASE_MANAGER_FLAG,N.SUPERVISOR_FLAG,N.COORDINATOR_FLAG,N.LINKED_ID, N.SALARY, N.PAY_RATE,N.EFFECTIVE_FROM_DATE,N.EFFECTIVE_TO_DATE,N.MDM_DIM_EMPLOYEE_KEY,N.ETL_TASK_KEY,N.ETL_INSERTED_TASK_KEY,N.ETL_INSERTED_DATE,N.ETL_INSERTED_BY,N.ETL_LAST_UPDATED_DATE,N.ETL_LAST_UPDATED_BY,N.ETL_DELETED_FLAG,N.ETL_INFERRED_MEMBER_FLAG,
	N.DERIVED_EMPLOYEE_HIRE_DATE AS DERIVED_EMPLOYEE_HIRE_DATE,
	N.DERIVED_EMPLOYEE_REHIRE_DATE AS DERIVED_EMPLOYEE_REHIRE_DATE,
	N.DERIVED_EMPLOYEE_BENEFIT_START_DATE AS DERIVED_EMPLOYEE_BENEFIT_START_DATE,
	N.DERIVED_EMPLOYEE_FIRST_CHECK_DATE AS DERIVED_EMPLOYEE_FIRST_CHECK_DATE,
	N.DERIVED_EMPLOYEE_LAST_CHECK_DATE AS DERIVED_EMPLOYEE_LAST_CHECK_DATE,
	N.DERIVED_EMPLOYEE_LAST_WORKED_DATE AS DERIVED_EMPLOYEE_LAST_WORKED_DATE,
	N.ACTIVE_EMPLOYEE_FLAG AS DERIVED_ACTIVE_EMPLOYEE_FLAG, --- NEED TO ASK
	N.EMPLOYEE_TERMINATE_DATE AS DERIVED_EMPLOYEE_TERMINATE_DATE
FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_NY_RL_OUTPUT R
LEFT JOIN OLD O 
	ON O.CLUSTER_ID = R.CLUSTER_ID
LEFT JOIN NEW N 
	ON N.CLUSTER_ID = R.CLUSTER_ID
WHERE R.CLUSTER_ID IS NOT NULL
UNION
SELECT U.ID ORIGINAL_EMPLOYEE_KEY,U.SOURCE_SYSTEM_ID ORIGINAL_SOURCE_SYSTEM_ID ,U.SYSTEM_CODE ORIGINAL_SYSTEM_CODE,U.EMPLOYEE_NUMBER ORIGINAL_EMPLOYEE_NUMBER,U.EMPLOYEE_PID ORIGINAL_EMPLOYEE_PID,
	U.ID AS EMPLOYEE_KEY,U.EMPLOYEE_ID,U.SYSTEM_CODE,U.SOURCE_SYSTEM_ID,U.EMPLOYEE_PID,U.EMPLOYEE_NUMBER,U.EMPLOYEE_DOB,
	U.EMPLOYEE_DATE_OF_DEATH,
	U.EMPLOYEE_HIRE_DATE,
	U.EMPLOYEE_REHIRE_DATE,
	U.EMPLOYEE_BENEFIT_START_DATE,
	U.EMPLOYEE_FIRST_CHECK_DATE,
	U.EMPLOYEE_LAST_CHECK_DATE,
	U.EMPLOYEE_LAST_WORKED_DATE,
	U.EMPLOYEE_TERMINATE_DATE,
	U.REASON_TO_TERMINATE,U.ACTIVE_EMPLOYEE_FLAG,U.ABLE_TO_REHIRE_FLAG,U.EMPLOYEE_PREFIX,U.EMPLOYEE_FIRST_NAME,U.EMPLOYEE_MIDDLE_NAME,U.EMPLOYEE_LAST_NAME,U.EMPLOYEE_SUFFIX,U.EMPLOYEE_ADDRESS1,U.EMPLOYEE_ADDRESS2,U.EMPLOYEE_CITY,U.EMPLOYEE_STATE_CODE,U.EMPLOYEE_ZIP,U.EMPLOYEE_HOME_PHONE,U.EMPLOYEE_CELL_PHONE,U.EMPLOYEE_WORK_PHONE,U.EMPLOYEE_PERSONAL_EMAIL,U.EMPLOYEE_WORK_EMAIL,U.LINKED_IN_PROFILE_URL,U.EMPLOYEE_GENDER,U.EMPLOYEE_ETHNICITY,U.EMPLOYEE_LANGUAGE,U.EMPLOYEE_MARITAL_STATUS,U.EMPLOYEE_TYPE,U.EMPLOYEE_CATEGORY,U.EXEMPT_FLAG,U.JOB_TITLE,U.JOB_DESCRIPTION,U.CLASS_ID,U.WORKERS_COMP,U.PAYROLL_ID,U.PERCENT_401K_DEDUCTION,U.AMOUNT_401K_DEDUCTION,U.JAZZHR_APPLICANT_ID,U.JAZZHR_USER_ID,U.JAZZHR_CONTACT_ID,U.WORK_STATE,U.SUTA_STATE,U.EMPLOYEE_DEPARTMENT,U.EMPLOYEE_OFFICE_CODE,U.PRIMARY_BRANCH_KEY,U.PRIMARY_BRANCH_STATE,U.PRIMARY_BRANCH_NAME,U.PRIMARY_BRANCH_SYSTEM_CODE,U.CASE_MANAGER_FLAG,U.SUPERVISOR_FLAG,U.COORDINATOR_FLAG,U.LINKED_ID, U.SALARY, U.PAY_RATE, U.EFFECTIVE_FROM_DATE,U.EFFECTIVE_TO_DATE,U.MDM_DIM_EMPLOYEE_KEY,U.ETL_TASK_KEY,U.ETL_INSERTED_TASK_KEY,U.ETL_INSERTED_DATE,U.ETL_INSERTED_BY,U.ETL_LAST_UPDATED_DATE,U.ETL_LAST_UPDATED_BY,U.ETL_DELETED_FLAG,U.ETL_INFERRED_MEMBER_FLAG,
	U.EMPLOYEE_HIRE_DATE AS DERIVED_EMPLOYEE_HIRE_DATE,
	U.EMPLOYEE_REHIRE_DATE AS DERIVED_EMPLOYEE_REHIRE_DATE,
	U.EMPLOYEE_BENEFIT_START_DATE AS DERIVED_EMPLOYEE_BENEFIT_START_DATE,
	U.EMPLOYEE_FIRST_CHECK_DATE AS DERIVED_EMPLOYEE_FIRST_CHECK_DATE,
	U.EMPLOYEE_LAST_CHECK_DATE AS DERIVED_EMPLOYEE_LAST_CHECK_DATE,
	U.EMPLOYEE_LAST_WORKED_DATE AS DERIVED_EMPLOYEE_LAST_WORKED_DATE,
	U.ACTIVE_EMPLOYEE_FLAG AS DERIVED_ACTIVE_EMPLOYEE_FLAG, --- NEED TO ASK
	U.EMPLOYEE_TERMINATE_DATE AS DERIVED_EMPLOYEE_TERMINATE_DATE
FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_EMPLOYEE_NY_RL_OUTPUT U
WHERE CLUSTER_ID IS NULL;
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

