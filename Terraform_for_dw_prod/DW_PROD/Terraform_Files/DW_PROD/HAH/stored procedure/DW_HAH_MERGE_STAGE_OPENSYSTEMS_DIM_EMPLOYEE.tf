resource "snowflake_procedure" "DW_HAH_MERGE_STAGE_OPENSYSTEMS_DIM_EMPLOYEE" {
	name ="MERGE_STAGE_OPENSYSTEMS_DIM_EMPLOYEE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN
MERGE INTO DW_${var.SF_ENVIRONMENT}.HAH.DIM_EMPLOYEE TGT 
USING DW_${var.SF_ENVIRONMENT}.STAGE.OPENSYSTEMS_DIM_EMPLOYEE STAGE 
ON TGT.EMPLOYEE_KEY = STAGE.EMPLOYEE_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.EMPLOYEE_ID= STAGE.EMPLOYEE_ID
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.EMPLOYEE_PID= STAGE.EMPLOYEE_PID
   ,TGT.EMPLOYEE_NUMBER= STAGE.EMPLOYEE_NUMBER
   ,TGT.EMPLOYEE_DOB= STAGE.EMPLOYEE_DOB
   ,TGT.EMPLOYEE_DATE_OF_DEATH= STAGE.EMPLOYEE_DATE_OF_DEATH
   ,TGT.EMPLOYEE_HIRE_DATE= STAGE.EMPLOYEE_HIRE_DATE
   ,TGT.EMPLOYEE_REHIRE_DATE= STAGE.EMPLOYEE_REHIRE_DATE
   ,TGT.EMPLOYEE_BENEFIT_START_DATE= STAGE.EMPLOYEE_BENEFIT_START_DATE
   ,TGT.EMPLOYEE_FIRST_CHECK_DATE= STAGE.EMPLOYEE_FIRST_CHECK_DATE
   ,TGT.EMPLOYEE_LAST_CHECK_DATE= STAGE.EMPLOYEE_LAST_CHECK_DATE
   ,TGT.EMPLOYEE_LAST_WORKED_DATE= STAGE.EMPLOYEE_LAST_WORKED_DATE
   ,TGT.EMPLOYEE_TERMINATE_DATE= STAGE.EMPLOYEE_TERMINATE_DATE
   ,TGT.REASON_TO_TERMINATE= STAGE.REASON_TO_TERMINATE
   ,TGT.ACTIVE_EMPLOYEE_FLAG= STAGE.ACTIVE_EMPLOYEE_FLAG
   ,TGT.ABLE_TO_REHIRE_FLAG= STAGE.ABLE_TO_REHIRE_FLAG
   ,TGT.EMPLOYEE_PREFIX= STAGE.EMPLOYEE_PREFIX
   ,TGT.EMPLOYEE_FIRST_NAME= STAGE.EMPLOYEE_FIRST_NAME
   ,TGT.EMPLOYEE_MIDDLE_NAME= STAGE.EMPLOYEE_MIDDLE_NAME
   ,TGT.EMPLOYEE_LAST_NAME= STAGE.EMPLOYEE_LAST_NAME
   ,TGT.EMPLOYEE_SUFFIX= STAGE.EMPLOYEE_SUFFIX
   ,TGT.EMPLOYEE_ADDRESS1= STAGE.EMPLOYEE_ADDRESS1
   ,TGT.EMPLOYEE_ADDRESS2= STAGE.EMPLOYEE_ADDRESS2
   ,TGT.EMPLOYEE_CITY= STAGE.EMPLOYEE_CITY
   ,TGT.EMPLOYEE_STATE_CODE= STAGE.EMPLOYEE_STATE_CODE
   ,TGT.EMPLOYEE_ZIP= STAGE.EMPLOYEE_ZIP
   ,TGT.EMPLOYEE_HOME_PHONE= STAGE.EMPLOYEE_HOME_PHONE
   ,TGT.EMPLOYEE_CELL_PHONE= STAGE.EMPLOYEE_CELL_PHONE
   ,TGT.EMPLOYEE_WORK_PHONE= STAGE.EMPLOYEE_WORK_PHONE
   ,TGT.EMPLOYEE_PERSONAL_EMAIL= STAGE.EMPLOYEE_PERSONAL_EMAIL
   ,TGT.EMPLOYEE_WORK_EMAIL= STAGE.EMPLOYEE_WORK_EMAIL
   ,TGT.LINKED_IN_PROFILE_URL= STAGE.LINKED_IN_PROFILE_URL
   ,TGT.EMPLOYEE_GENDER= STAGE.EMPLOYEE_GENDER
   ,TGT.EMPLOYEE_ETHNICITY= STAGE.EMPLOYEE_ETHNICITY
   ,TGT.HISPANIC_OR_LATINO = STAGE.HISPANIC_OR_LATINO
   ,TGT.EMPLOYEE_LANGUAGE= STAGE.EMPLOYEE_LANGUAGE
   ,TGT.EMPLOYEE_MARITAL_STATUS= STAGE.EMPLOYEE_MARITAL_STATUS
   ,TGT.EMPLOYEE_TYPE= STAGE.EMPLOYEE_TYPE
   ,TGT.EMPLOYEE_CATEGORY= STAGE.EMPLOYEE_CATEGORY
   ,TGT.EXEMPT_FLAG= STAGE.EXEMPT_FLAG
   ,TGT.JOB_TITLE= STAGE.JOB_TITLE
   ,TGT.JOB_DESCRIPTION= STAGE.JOB_DESCRIPTION
   ,TGT.CLASS_ID= STAGE.CLASS_ID
   ,TGT.WORKERS_COMP= STAGE.WORKERS_COMP
   ,TGT.PAYROLL_ID= STAGE.PAYROLL_ID
   ,TGT.PERCENT_401K_DEDUCTION= STAGE.PERCENT_401K_DEDUCTION
   ,TGT.AMOUNT_401K_DEDUCTION= STAGE.AMOUNT_401K_DEDUCTION
   ,TGT.JAZZHR_APPLICANT_ID= STAGE.JAZZHR_APPLICANT_ID
   ,TGT.JAZZHR_USER_ID= STAGE.JAZZHR_USER_ID
   ,TGT.JAZZHR_CONTACT_ID= STAGE.JAZZHR_CONTACT_ID
   ,TGT.WORK_STATE= STAGE.WORK_STATE
   ,TGT.SUTA_STATE= STAGE.SUTA_STATE
   ,TGT.EMPLOYEE_DEPARTMENT= STAGE.EMPLOYEE_DEPARTMENT
   ,TGT.EMPLOYEE_OFFICE_CODE= STAGE.EMPLOYEE_OFFICE_CODE
   ,TGT.PRIMARY_BRANCH_KEY= STAGE.PRIMARY_BRANCH_KEY
   ,TGT.PRIMARY_BRANCH_STATE= STAGE.PRIMARY_BRANCH_STATE
   ,TGT.PRIMARY_BRANCH_NAME= STAGE.PRIMARY_BRANCH_NAME
   ,TGT.PRIMARY_BRANCH_SYSTEM_CODE= STAGE.PRIMARY_BRANCH_SYSTEM_CODE
   ,TGT.CASE_MANAGER_FLAG= STAGE.CASE_MANAGER_FLAG
   ,TGT.SUPERVISOR_FLAG= STAGE.SUPERVISOR_FLAG
   ,TGT.COORDINATOR_FLAG= STAGE.COORDINATOR_FLAG
   ,TGT.LINKED_ID= STAGE.LINKED_ID
   ,TGT.EFFECTIVE_FROM_DATE= STAGE.EFFECTIVE_FROM_DATE
   ,TGT.EFFECTIVE_TO_DATE= STAGE.EFFECTIVE_TO_DATE
   ,TGT.MDM_DIM_EMPLOYEE_KEY= STAGE.MDM_DIM_EMPLOYEE_KEY
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
   ,TGT.ETL_INFERRED_MEMBER_FLAG= STAGE.ETL_INFERRED_MEMBER_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
    EMPLOYEE_KEY
   ,EMPLOYEE_ID
   ,SYSTEM_CODE
   ,SOURCE_SYSTEM_ID
   ,EMPLOYEE_PID
   ,EMPLOYEE_NUMBER
   ,EMPLOYEE_DOB
   ,EMPLOYEE_DATE_OF_DEATH
   ,EMPLOYEE_HIRE_DATE
   ,EMPLOYEE_REHIRE_DATE
   ,EMPLOYEE_BENEFIT_START_DATE
   ,EMPLOYEE_FIRST_CHECK_DATE
   ,EMPLOYEE_LAST_CHECK_DATE
   ,EMPLOYEE_LAST_WORKED_DATE
   ,EMPLOYEE_TERMINATE_DATE
   ,REASON_TO_TERMINATE
   ,ACTIVE_EMPLOYEE_FLAG
   ,ABLE_TO_REHIRE_FLAG
   ,EMPLOYEE_PREFIX
   ,EMPLOYEE_FIRST_NAME
   ,EMPLOYEE_MIDDLE_NAME
   ,EMPLOYEE_LAST_NAME
   ,EMPLOYEE_SUFFIX
   ,EMPLOYEE_ADDRESS1
   ,EMPLOYEE_ADDRESS2
   ,EMPLOYEE_CITY
   ,EMPLOYEE_STATE_CODE
   ,EMPLOYEE_ZIP
   ,EMPLOYEE_HOME_PHONE
   ,EMPLOYEE_CELL_PHONE
   ,EMPLOYEE_WORK_PHONE
   ,EMPLOYEE_PERSONAL_EMAIL
   ,EMPLOYEE_WORK_EMAIL
   ,LINKED_IN_PROFILE_URL
   ,EMPLOYEE_GENDER
   ,EMPLOYEE_ETHNICITY
   ,HISPANIC_OR_LATINO
   ,EMPLOYEE_LANGUAGE
   ,EMPLOYEE_MARITAL_STATUS
   ,EMPLOYEE_TYPE
   ,EMPLOYEE_CATEGORY
   ,EXEMPT_FLAG
   ,JOB_TITLE
   ,JOB_DESCRIPTION
   ,CLASS_ID
   ,WORKERS_COMP
   ,PAYROLL_ID
   ,PERCENT_401K_DEDUCTION
   ,AMOUNT_401K_DEDUCTION
   ,JAZZHR_APPLICANT_ID
   ,JAZZHR_USER_ID
   ,JAZZHR_CONTACT_ID
   ,WORK_STATE
   ,SUTA_STATE
   ,EMPLOYEE_DEPARTMENT
   ,EMPLOYEE_OFFICE_CODE
   ,PRIMARY_BRANCH_KEY
   ,PRIMARY_BRANCH_STATE
   ,PRIMARY_BRANCH_NAME
   ,PRIMARY_BRANCH_SYSTEM_CODE
   ,CASE_MANAGER_FLAG
   ,SUPERVISOR_FLAG
   ,COORDINATOR_FLAG
   ,LINKED_ID
   ,EFFECTIVE_FROM_DATE
   ,EFFECTIVE_TO_DATE
   ,MDM_DIM_EMPLOYEE_KEY
   ,ETL_TASK_KEY
   ,ETL_INSERTED_TASK_KEY
   ,ETL_INSERTED_DATE
   ,ETL_INSERTED_BY
   ,ETL_LAST_UPDATED_DATE
   ,ETL_LAST_UPDATED_BY
   ,ETL_DELETED_FLAG
   ,ETL_INFERRED_MEMBER_FLAG
) 
VALUES (
    STAGE.EMPLOYEE_KEY
   ,STAGE.EMPLOYEE_ID
   ,STAGE.SYSTEM_CODE
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.EMPLOYEE_PID
   ,STAGE.EMPLOYEE_NUMBER
   ,STAGE.EMPLOYEE_DOB
   ,STAGE.EMPLOYEE_DATE_OF_DEATH
   ,STAGE.EMPLOYEE_HIRE_DATE
   ,STAGE.EMPLOYEE_REHIRE_DATE
   ,STAGE.EMPLOYEE_BENEFIT_START_DATE
   ,STAGE.EMPLOYEE_FIRST_CHECK_DATE
   ,STAGE.EMPLOYEE_LAST_CHECK_DATE
   ,STAGE.EMPLOYEE_LAST_WORKED_DATE
   ,STAGE.EMPLOYEE_TERMINATE_DATE
   ,STAGE.REASON_TO_TERMINATE
   ,STAGE.ACTIVE_EMPLOYEE_FLAG
   ,STAGE.ABLE_TO_REHIRE_FLAG
   ,STAGE.EMPLOYEE_PREFIX
   ,STAGE.EMPLOYEE_FIRST_NAME
   ,STAGE.EMPLOYEE_MIDDLE_NAME
   ,STAGE.EMPLOYEE_LAST_NAME
   ,STAGE.EMPLOYEE_SUFFIX
   ,STAGE.EMPLOYEE_ADDRESS1
   ,STAGE.EMPLOYEE_ADDRESS2
   ,STAGE.EMPLOYEE_CITY
   ,STAGE.EMPLOYEE_STATE_CODE
   ,STAGE.EMPLOYEE_ZIP
   ,STAGE.EMPLOYEE_HOME_PHONE
   ,STAGE.EMPLOYEE_CELL_PHONE
   ,STAGE.EMPLOYEE_WORK_PHONE
   ,STAGE.EMPLOYEE_PERSONAL_EMAIL
   ,STAGE.EMPLOYEE_WORK_EMAIL
   ,STAGE.LINKED_IN_PROFILE_URL
   ,STAGE.EMPLOYEE_GENDER
   ,STAGE.EMPLOYEE_ETHNICITY
   ,STAGE.HISPANIC_OR_LATINO
   ,STAGE.EMPLOYEE_LANGUAGE
   ,STAGE.EMPLOYEE_MARITAL_STATUS
   ,STAGE.EMPLOYEE_TYPE
   ,STAGE.EMPLOYEE_CATEGORY
   ,STAGE.EXEMPT_FLAG
   ,STAGE.JOB_TITLE
   ,STAGE.JOB_DESCRIPTION
   ,STAGE.CLASS_ID
   ,STAGE.WORKERS_COMP
   ,STAGE.PAYROLL_ID
   ,STAGE.PERCENT_401K_DEDUCTION
   ,STAGE.AMOUNT_401K_DEDUCTION
   ,STAGE.JAZZHR_APPLICANT_ID
   ,STAGE.JAZZHR_USER_ID
   ,STAGE.JAZZHR_CONTACT_ID
   ,STAGE.WORK_STATE
   ,STAGE.SUTA_STATE
   ,STAGE.EMPLOYEE_DEPARTMENT
   ,STAGE.EMPLOYEE_OFFICE_CODE
   ,STAGE.PRIMARY_BRANCH_KEY
   ,STAGE.PRIMARY_BRANCH_STATE
   ,STAGE.PRIMARY_BRANCH_NAME
   ,STAGE.PRIMARY_BRANCH_SYSTEM_CODE
   ,STAGE.CASE_MANAGER_FLAG
   ,STAGE.SUPERVISOR_FLAG
   ,STAGE.COORDINATOR_FLAG
   ,STAGE.LINKED_ID
   ,STAGE.EFFECTIVE_FROM_DATE
   ,STAGE.EFFECTIVE_TO_DATE
   ,STAGE.MDM_DIM_EMPLOYEE_KEY
   ,STAGE.ETL_TASK_KEY
   ,STAGE.ETL_INSERTED_TASK_KEY
   ,STAGE.ETL_INSERTED_DATE
   ,STAGE.ETL_INSERTED_BY
   ,STAGE.ETL_LAST_UPDATED_DATE
   ,STAGE.ETL_LAST_UPDATED_BY
   ,STAGE.ETL_DELETED_FLAG
   ,STAGE.ETL_INFERRED_MEMBER_FLAG
);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Insrted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

