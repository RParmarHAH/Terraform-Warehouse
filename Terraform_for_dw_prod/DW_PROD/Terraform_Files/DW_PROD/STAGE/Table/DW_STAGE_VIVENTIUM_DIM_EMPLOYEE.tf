resource "snowflake_table" "DW_STAGE_VIVENTIUM_DIM_EMPLOYEE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VIVENTIUM_DIM_EMPLOYEE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.VIVENTIUM_DIM_EMPLOYEE

    -- Purpose : Business Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(16777216)"
	nullable = false
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_PID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_DATE_OF_DEATH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_REHIRE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_BENEFIT_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_CHECK_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_CHECK_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_WORKED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "REASON_TO_TERMINATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTIVE_EMPLOYEE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ABLE_TO_REHIRE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PREFIX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_MIDDLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_SUFFIX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LINKED_IN_PROFILE_URL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ETHNICITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HISPANIC_OR_LATINO"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LANGUAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_MARITAL_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXEMPT_FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLASS_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKERS_COMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYROLL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERCENT_401K_DEDUCTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMOUNT_401K_DEDUCTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JAZZHR_APPLICANT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JAZZHR_USER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JAZZHR_CONTACT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUTA_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_DEPARTMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_OFFICE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASE_MANAGER_FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUPERVISOR_FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COORDINATOR_FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SALARY"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAY_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "EFFECTIVE_FROM_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EFFECTIVE_TO_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "MDM_DIM_EMPLOYEE_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ACQUIRED_SYSTEM"
	type = "VARCHAR(50)"
	nullable = true
}

}

