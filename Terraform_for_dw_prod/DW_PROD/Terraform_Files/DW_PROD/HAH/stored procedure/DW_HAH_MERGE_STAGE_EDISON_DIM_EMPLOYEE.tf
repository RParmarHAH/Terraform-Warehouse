resource "snowflake_procedure" "DW_HAH_MERGE_STAGE_EDISON_DIM_EMPLOYEE" {
	name ="MERGE_STAGE_EDISON_DIM_EMPLOYEE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN
    MERGE INTO HAH.DIM_EMPLOYEE TGT 	USING STAGE.EDISON_DIM_EMPLOYEE STG 
	ON TGT.EMPLOYEE_KEY = STG.EMPLOYEE_KEY
	WHEN MATCHED THEN 
	UPDATE SET 
	    TGT.EMPLOYEE_KEY=STG.EMPLOYEE_KEY
,TGT.EMPLOYEE_ID=STG.EMPLOYEE_ID
,TGT.SYSTEM_CODE=STG.SYSTEM_CODE
,TGT.SOURCE_SYSTEM_ID=STG.SOURCE_SYSTEM_ID
,TGT.EMPLOYEE_PID=STG.EMPLOYEE_PID
,TGT.EMPLOYEE_NUMBER=STG.EMPLOYEE_NUMBER
,TGT.EMPLOYEE_DOB=STG.EMPLOYEE_DOB
,TGT.EMPLOYEE_DATE_OF_DEATH=STG.EMPLOYEE_DATE_OF_DEATH
,TGT.EMPLOYEE_HIRE_DATE=STG.EMPLOYEE_HIRE_DATE
,TGT.EMPLOYEE_REHIRE_DATE=STG.EMPLOYEE_REHIRE_DATE
,TGT.EMPLOYEE_BENEFIT_START_DATE=STG.EMPLOYEE_BENEFIT_START_DATE
,TGT.EMPLOYEE_FIRST_CHECK_DATE=STG.EMPLOYEE_FIRST_CHECK_DATE
,TGT.EMPLOYEE_LAST_CHECK_DATE=STG.EMPLOYEE_LAST_CHECK_DATE
,TGT.EMPLOYEE_LAST_WORKED_DATE=STG.EMPLOYEE_LAST_WORKED_DATE
,TGT.EMPLOYEE_TERMINATE_DATE=STG.EMPLOYEE_TERMINATE_DATE
,TGT.REASON_TO_TERMINATE=STG.REASON_TO_TERMINATE
,TGT.ACTIVE_EMPLOYEE_FLAG=STG.ACTIVE_EMPLOYEE_FLAG
,TGT.ABLE_TO_REHIRE_FLAG=STG.ABLE_TO_REHIRE_FLAG
,TGT.EMPLOYEE_PREFIX=STG.EMPLOYEE_PREFIX
,TGT.EMPLOYEE_FIRST_NAME=STG.EMPLOYEE_FIRST_NAME
,TGT.EMPLOYEE_MIDDLE_NAME=STG.EMPLOYEE_MIDDLE_NAME
,TGT.EMPLOYEE_LAST_NAME=STG.EMPLOYEE_LAST_NAME
,TGT.EMPLOYEE_SUFFIX=STG.EMPLOYEE_SUFFIX
,TGT.EMPLOYEE_ADDRESS1=STG.EMPLOYEE_ADDRESS1
,TGT.EMPLOYEE_ADDRESS2=STG.EMPLOYEE_ADDRESS2
,TGT.EMPLOYEE_CITY=STG.EMPLOYEE_CITY
,TGT.EMPLOYEE_STATE_CODE=STG.EMPLOYEE_STATE_CODE
,TGT.EMPLOYEE_ZIP=STG.EMPLOYEE_ZIP
,TGT.EMPLOYEE_HOME_PHONE=STG.EMPLOYEE_HOME_PHONE
,TGT.EMPLOYEE_CELL_PHONE=STG.EMPLOYEE_CELL_PHONE
,TGT.EMPLOYEE_WORK_PHONE=STG.EMPLOYEE_WORK_PHONE
,TGT.EMPLOYEE_PERSONAL_EMAIL=STG.EMPLOYEE_PERSONAL_EMAIL
,TGT.EMPLOYEE_WORK_EMAIL=STG.EMPLOYEE_WORK_EMAIL
,TGT.LINKED_IN_PROFILE_URL=STG.LINKED_IN_PROFILE_URL
,TGT.EMPLOYEE_GENDER=STG.EMPLOYEE_GENDER
,TGT.EMPLOYEE_ETHNICITY=STG.EMPLOYEE_ETHNICITY
,TGT.HISPANIC_OR_LATINO = STG.HISPANIC_OR_LATINO
,TGT.EMPLOYEE_LANGUAGE=STG.EMPLOYEE_LANGUAGE
,TGT.EMPLOYEE_MARITAL_STATUS=STG.EMPLOYEE_MARITAL_STATUS
,TGT.EMPLOYEE_TYPE=STG.EMPLOYEE_TYPE
,TGT.EMPLOYEE_CATEGORY=STG.EMPLOYEE_CATEGORY
,TGT.EXEMPT_FLAG=STG.EXEMPT_FLAG
,TGT.JOB_TITLE=STG.JOB_TITLE
,TGT.JOB_DESCRIPTION=STG.JOB_DESCRIPTION
,TGT.CLASS_ID=STG.CLASS_ID
,TGT.WORKERS_COMP=STG.WORKERS_COMP
,TGT.PAYROLL_ID=STG.PAYROLL_ID
,TGT.PERCENT_401K_DEDUCTION=STG.PERCENT_401K_DEDUCTION
,TGT.AMOUNT_401K_DEDUCTION=STG.AMOUNT_401K_DEDUCTION
,TGT.JAZZHR_APPLICANT_ID=STG.JAZZHR_APPLICANT_ID
,TGT.JAZZHR_USER_ID=STG.JAZZHR_USER_ID
,TGT.JAZZHR_CONTACT_ID=STG.JAZZHR_CONTACT_ID
,TGT.WORK_STATE=STG.WORK_STATE
,TGT.SUTA_STATE=STG.SUTA_STATE
,TGT.EMPLOYEE_DEPARTMENT=STG.EMPLOYEE_DEPARTMENT
,TGT.EMPLOYEE_OFFICE_CODE=STG.EMPLOYEE_OFFICE_CODE
,TGT.PRIMARY_BRANCH_KEY=STG.PRIMARY_BRANCH_KEY
,TGT.PRIMARY_BRANCH_STATE=STG.PRIMARY_BRANCH_STATE
,TGT.PRIMARY_BRANCH_NAME=STG.PRIMARY_BRANCH_NAME
,TGT.PRIMARY_BRANCH_SYSTEM_CODE=STG.PRIMARY_BRANCH_SYSTEM_CODE
,TGT.CASE_MANAGER_FLAG=STG.CASE_MANAGER_FLAG
,TGT.SUPERVISOR_FLAG=STG.SUPERVISOR_FLAG
,TGT.COORDINATOR_FLAG=STG.COORDINATOR_FLAG
,TGT.LINKED_ID=STG.LINKED_ID
,TGT.EFFECTIVE_FROM_DATE=STG.EFFECTIVE_FROM_DATE
,TGT.EFFECTIVE_TO_DATE=STG.EFFECTIVE_TO_DATE
,TGT.MDM_DIM_EMPLOYEE_KEY=STG.MDM_DIM_EMPLOYEE_KEY
,TGT.ETL_TASK_KEY=STG.ETL_TASK_KEY
,TGT.ETL_INSERTED_TASK_KEY=STG.ETL_INSERTED_TASK_KEY
,TGT.ETL_INSERTED_DATE=STG.ETL_INSERTED_DATE
,TGT.ETL_INSERTED_BY=STG.ETL_INSERTED_BY
,TGT.ETL_LAST_UPDATED_DATE=STG.ETL_LAST_UPDATED_DATE
,TGT.ETL_LAST_UPDATED_BY=STG.ETL_LAST_UPDATED_BY
,TGT.ETL_DELETED_FLAG=STG.ETL_DELETED_FLAG
,TGT.ETL_INFERRED_MEMBER_FLAG=STG.ETL_INFERRED_MEMBER_FLAG      
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
	   STG.EMPLOYEE_KEY
,STG.EMPLOYEE_ID
,STG.SYSTEM_CODE
,STG.SOURCE_SYSTEM_ID
,STG.EMPLOYEE_PID
,STG.EMPLOYEE_NUMBER
,STG.EMPLOYEE_DOB
,STG.EMPLOYEE_DATE_OF_DEATH
,STG.EMPLOYEE_HIRE_DATE
,STG.EMPLOYEE_REHIRE_DATE
,STG.EMPLOYEE_BENEFIT_START_DATE
,STG.EMPLOYEE_FIRST_CHECK_DATE
,STG.EMPLOYEE_LAST_CHECK_DATE
,STG.EMPLOYEE_LAST_WORKED_DATE
,STG.EMPLOYEE_TERMINATE_DATE
,STG.REASON_TO_TERMINATE
,STG.ACTIVE_EMPLOYEE_FLAG
,STG.ABLE_TO_REHIRE_FLAG
,STG.EMPLOYEE_PREFIX
,STG.EMPLOYEE_FIRST_NAME
,STG.EMPLOYEE_MIDDLE_NAME
,STG.EMPLOYEE_LAST_NAME
,STG.EMPLOYEE_SUFFIX
,STG.EMPLOYEE_ADDRESS1
,STG.EMPLOYEE_ADDRESS2
,STG.EMPLOYEE_CITY
,STG.EMPLOYEE_STATE_CODE
,STG.EMPLOYEE_ZIP
,STG.EMPLOYEE_HOME_PHONE
,STG.EMPLOYEE_CELL_PHONE
,STG.EMPLOYEE_WORK_PHONE
,STG.EMPLOYEE_PERSONAL_EMAIL
,STG.EMPLOYEE_WORK_EMAIL
,STG.LINKED_IN_PROFILE_URL
,STG.EMPLOYEE_GENDER
,STG.EMPLOYEE_ETHNICITY
,STG.HISPANIC_OR_LATINO
,STG.EMPLOYEE_LANGUAGE
,STG.EMPLOYEE_MARITAL_STATUS
,STG.EMPLOYEE_TYPE
,STG.EMPLOYEE_CATEGORY
,STG.EXEMPT_FLAG
,STG.JOB_TITLE
,STG.JOB_DESCRIPTION
,STG.CLASS_ID
,STG.WORKERS_COMP
,STG.PAYROLL_ID
,STG.PERCENT_401K_DEDUCTION
,STG.AMOUNT_401K_DEDUCTION
,STG.JAZZHR_APPLICANT_ID
,STG.JAZZHR_USER_ID
,STG.JAZZHR_CONTACT_ID
,STG.WORK_STATE
,STG.SUTA_STATE
,STG.EMPLOYEE_DEPARTMENT
,STG.EMPLOYEE_OFFICE_CODE
,STG.PRIMARY_BRANCH_KEY
,STG.PRIMARY_BRANCH_STATE
,STG.PRIMARY_BRANCH_NAME
,STG.PRIMARY_BRANCH_SYSTEM_CODE
,STG.CASE_MANAGER_FLAG
,STG.SUPERVISOR_FLAG
,STG.COORDINATOR_FLAG
,STG.LINKED_ID
,STG.EFFECTIVE_FROM_DATE
,STG.EFFECTIVE_TO_DATE
,STG.MDM_DIM_EMPLOYEE_KEY
,STG.ETL_TASK_KEY
,STG.ETL_INSERTED_TASK_KEY
,STG.ETL_INSERTED_DATE
,STG.ETL_INSERTED_BY
,STG.ETL_LAST_UPDATED_DATE
,STG.ETL_LAST_UPDATED_BY
,STG.ETL_DELETED_FLAG
,STG.ETL_INFERRED_MEMBER_FLAG
);
SELECT CONCAT(''Message >> Inserted : '',"number of rows inserted", '', Updated : '' ,"number of rows updated",'' Rows.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
    
 EOT
}

