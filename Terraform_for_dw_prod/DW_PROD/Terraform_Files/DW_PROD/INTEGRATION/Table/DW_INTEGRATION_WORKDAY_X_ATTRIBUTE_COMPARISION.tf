resource "snowflake_table" "DW_INTEGRATION_WORKDAY_X_ATTRIBUTE_COMPARISION" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "WORKDAY_X_ATTRIBUTE_COMPARISION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.WORKDAY_X_ATTRIBUTE_COMPARISION

    -- Purpose : Business Integration Data Population

    -- Project : INTEGRATION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_ENTERPRISE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID_WD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID_AMS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID_PAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_PID_WD"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_PID_AMS"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_PID_PAY"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_PID_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_PID_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_PID_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_ID_WD"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "PAYROLL_ID_AMS"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "PAYROLL_ID_PAY"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "PAYROLL_ID_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_ID_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_ID_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "APPLICANT_ID_WD"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "APPLICANT_ID_AMS"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "APPLICANT_ID_PAY"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "APPLICANT_ID_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "APPLICANT_ID_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "APPLICANT_ID_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE_WD"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE_AMS"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE_PAY"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_LAST_WORKED_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_LAST_WORKED_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_LAST_WORKED_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_LAST_WORKED_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_LAST_WORKED_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_LAST_WORKED_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY_WD"
	type = "VARCHAR(4500)"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY_AMS"
	type = "VARCHAR(4500)"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY_PAY"
	type = "VARCHAR(4500)"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_WORKED_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_WORKED_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_WORKED_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_WORKED_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_WORKED_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_WORKED_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LINKED_ID_WD"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "LINKED_ID_AMS"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "LINKED_ID_PAY"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "LINKED_ID_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LINKED_ID_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LINKED_ID_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_REHIRE_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_REHIRE_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_REHIRE_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_REHIRE_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_REHIRE_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_REHIRE_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_FIRST_CHECK_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_FIRST_CHECK_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_FIRST_CHECK_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_FIRST_CHECK_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_FIRST_CHECK_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_FIRST_CHECK_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_PAYROLL_LAST_CHECK_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_PAYROLL_LAST_CHECK_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_PAYROLL_LAST_CHECK_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_PAYROLL_LAST_CHECK_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_PAYROLL_LAST_CHECK_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_PAYROLL_LAST_CHECK_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_EMAIL_WD"
	type = "VARCHAR(1350)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_EMAIL_AMS"
	type = "VARCHAR(1350)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_EMAIL_PAY"
	type = "VARCHAR(1350)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_EMAIL_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_EMAIL_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_EMAIL_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LANGUAGE_WD"
	type = "VARCHAR(2250)"
	nullable = true
}


column {
	name = "EMPLOYEE_LANGUAGE_AMS"
	type = "VARCHAR(2250)"
	nullable = true
}


column {
	name = "EMPLOYEE_LANGUAGE_PAY"
	type = "VARCHAR(2250)"
	nullable = true
}


column {
	name = "EMPLOYEE_LANGUAGE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LANGUAGE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LANGUAGE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER_WD"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER_AMS"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER_PAY"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID_WD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID_AMS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID_PAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2_WD"
	type = "VARCHAR(13500)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2_AMS"
	type = "VARCHAR(13500)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2_PAY"
	type = "VARCHAR(13500)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HISPANIC_OR_LATINO_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HISPANIC_OR_LATINO_AMS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HISPANIC_OR_LATINO_PAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HISPANIC_OR_LATINO_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HISPANIC_OR_LATINO_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HISPANIC_OR_LATINO_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME_WD"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME_AMS"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME_PAY"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_SOURCE_SYSTEM_WD"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "PAYROLL_SOURCE_SYSTEM_AMS"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "PAYROLL_SOURCE_SYSTEM_PAY"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "PAYROLL_SOURCE_SYSTEM_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_SOURCE_SYSTEM_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_SOURCE_SYSTEM_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JAZZHR_CONTACT_ID_WD"
	type = "VARCHAR(13500)"
	nullable = true
}


column {
	name = "JAZZHR_CONTACT_ID_AMS"
	type = "VARCHAR(13500)"
	nullable = true
}


column {
	name = "JAZZHR_CONTACT_ID_PAY"
	type = "VARCHAR(13500)"
	nullable = true
}


column {
	name = "JAZZHR_CONTACT_ID_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JAZZHR_CONTACT_ID_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JAZZHR_CONTACT_ID_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_BENEFIT_START_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_BENEFIT_START_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_BENEFIT_START_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_BENEFIT_START_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_BENEFIT_START_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_BENEFIT_START_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MDM_DIM_EMPLOYEE_KEY_WD"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "MDM_DIM_EMPLOYEE_KEY_AMS"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "MDM_DIM_EMPLOYEE_KEY_PAY"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "MDM_DIM_EMPLOYEE_KEY_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MDM_DIM_EMPLOYEE_KEY_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MDM_DIM_EMPLOYEE_KEY_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JOB_DESCRIPTION_WD"
	type = "VARCHAR(45000)"
	nullable = true
}


column {
	name = "JOB_DESCRIPTION_AMS"
	type = "VARCHAR(45000)"
	nullable = true
}


column {
	name = "JOB_DESCRIPTION_PAY"
	type = "VARCHAR(45000)"
	nullable = true
}


column {
	name = "JOB_DESCRIPTION_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JOB_DESCRIPTION_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JOB_DESCRIPTION_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOCATION_HIERARCHY_WD"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "LOCATION_HIERARCHY_AMS"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "LOCATION_HIERARCHY_PAY"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "LOCATION_HIERARCHY_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOCATION_HIERARCHY_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOCATION_HIERARCHY_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_MARITAL_STATUS_WD"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_MARITAL_STATUS_AMS"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_MARITAL_STATUS_PAY"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_MARITAL_STATUS_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_MARITAL_STATUS_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_MARITAL_STATUS_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_OFFICE_CODE_WD"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_OFFICE_CODE_AMS"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_OFFICE_CODE_PAY"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_OFFICE_CODE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_OFFICE_CODE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_OFFICE_CODE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_DATE_OF_DEATH_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_DATE_OF_DEATH_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_DATE_OF_DEATH_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_DATE_OF_DEATH_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_DATE_OF_DEATH_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_DATE_OF_DEATH_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLASS_ID_WD"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "CLASS_ID_AMS"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "CLASS_ID_PAY"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "CLASS_ID_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLASS_ID_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLASS_ID_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL_WD"
	type = "VARCHAR(1350)"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL_AMS"
	type = "VARCHAR(1350)"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL_PAY"
	type = "VARCHAR(1350)"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_RATE_WD"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "PAY_RATE_AMS"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "PAY_RATE_PAY"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "PAY_RATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_RATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_RATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUPERVISOR_FLAG_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUPERVISOR_FLAG_AMS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUPERVISOR_FLAG_PAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUPERVISOR_FLAG_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUPERVISOR_FLAG_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUPERVISOR_FLAG_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LINKED_IN_PROFILE_URL_WD"
	type = "VARCHAR(2250)"
	nullable = true
}


column {
	name = "LINKED_IN_PROFILE_URL_AMS"
	type = "VARCHAR(2250)"
	nullable = true
}


column {
	name = "LINKED_IN_PROFILE_URL_PAY"
	type = "VARCHAR(2250)"
	nullable = true
}


column {
	name = "LINKED_IN_PROFILE_URL_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LINKED_IN_PROFILE_URL_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LINKED_IN_PROFILE_URL_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_SYSTEM_CODE_WD"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_SYSTEM_CODE_AMS"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_SYSTEM_CODE_PAY"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_SYSTEM_CODE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_SYSTEM_CODE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_SYSTEM_CODE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_KEY_WD"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_KEY_AMS"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_KEY_PAY"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_KEY_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_KEY_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_KEY_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE_WD"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE_AMS"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE_PAY"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_BENEFIT_START_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_BENEFIT_START_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_BENEFIT_START_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_BENEFIT_START_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_BENEFIT_START_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_BENEFIT_START_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_CHECK_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_CHECK_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_CHECK_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_CHECK_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_CHECK_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_CHECK_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_KEY_WD"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_KEY_AMS"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_KEY_PAY"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_KEY_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_KEY_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_KEY_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PERCENT_401K_DEDUCTION_WD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PERCENT_401K_DEDUCTION_AMS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PERCENT_401K_DEDUCTION_PAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PERCENT_401K_DEDUCTION_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PERCENT_401K_DEDUCTION_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PERCENT_401K_DEDUCTION_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME_WD"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME_AMS"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME_PAY"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_REHIRE_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_REHIRE_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_REHIRE_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_REHIRE_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_REHIRE_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_REHIRE_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ID_WD"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID_AMS"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID_PAY"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ID_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ID_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JOB_TITLE_WD"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "JOB_TITLE_AMS"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "JOB_TITLE_PAY"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "JOB_TITLE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JOB_TITLE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JOB_TITLE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_LAST_SERVICE_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_LAST_SERVICE_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_LAST_SERVICE_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_LAST_SERVICE_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_LAST_SERVICE_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_LAST_SERVICE_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE_WD"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE_AMS"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE_PAY"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_MIDDLE_NAME_WD"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "EMPLOYEE_MIDDLE_NAME_AMS"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "EMPLOYEE_MIDDLE_NAME_PAY"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "EMPLOYEE_MIDDLE_NAME_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_MIDDLE_NAME_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_MIDDLE_NAME_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORK_STATE_WD"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "WORK_STATE_AMS"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "WORK_STATE_PAY"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "WORK_STATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORK_STATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORK_STATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AMOUNT_401K_DEDUCTION_WD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AMOUNT_401K_DEDUCTION_AMS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AMOUNT_401K_DEDUCTION_PAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AMOUNT_401K_DEDUCTION_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AMOUNT_401K_DEDUCTION_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AMOUNT_401K_DEDUCTION_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ABLE_TO_REHIRE_FLAG_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ABLE_TO_REHIRE_FLAG_AMS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ABLE_TO_REHIRE_FLAG_PAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ABLE_TO_REHIRE_FLAG_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ABLE_TO_REHIRE_FLAG_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ABLE_TO_REHIRE_FLAG_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_SYSTEM_CODE_WD"
	type = "VARCHAR(225)"
	nullable = true
}


column {
	name = "ORIGINAL_SYSTEM_CODE_AMS"
	type = "VARCHAR(225)"
	nullable = true
}


column {
	name = "ORIGINAL_SYSTEM_CODE_PAY"
	type = "VARCHAR(225)"
	nullable = true
}


column {
	name = "ORIGINAL_SYSTEM_CODE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_SYSTEM_CODE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_SYSTEM_CODE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SALARY_WD"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "SALARY_AMS"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "SALARY_PAY"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "SALARY_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SALARY_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SALARY_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_CHECK_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_CHECK_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_CHECK_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_CHECK_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_CHECK_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_CHECK_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXEMPT_FLAG_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXEMPT_FLAG_AMS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXEMPT_FLAG_PAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXEMPT_FLAG_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXEMPT_FLAG_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXEMPT_FLAG_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_STATE_WD"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_STATE_AMS"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_STATE_PAY"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_STATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_STATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_STATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_PAYROLL_FIRST_CHECK_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_PAYROLL_FIRST_CHECK_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_PAYROLL_FIRST_CHECK_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_PAYROLL_FIRST_CHECK_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_PAYROLL_FIRST_CHECK_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_PAYROLL_FIRST_CHECK_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_ACTIVE_EMPLOYEE_FLAG_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_ACTIVE_EMPLOYEE_FLAG_AMS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_ACTIVE_EMPLOYEE_FLAG_PAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_ACTIVE_EMPLOYEE_FLAG_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_ACTIVE_EMPLOYEE_FLAG_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_ACTIVE_EMPLOYEE_FLAG_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUTA_STATE_WD"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "SUTA_STATE_AMS"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "SUTA_STATE_PAY"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "SUTA_STATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUTA_STATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUTA_STATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ETHNICITY_WD"
	type = "VARCHAR(4500)"
	nullable = true
}


column {
	name = "EMPLOYEE_ETHNICITY_AMS"
	type = "VARCHAR(4500)"
	nullable = true
}


column {
	name = "EMPLOYEE_ETHNICITY_PAY"
	type = "VARCHAR(4500)"
	nullable = true
}


column {
	name = "EMPLOYEE_ETHNICITY_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ETHNICITY_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ETHNICITY_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_NUMBER_WD"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_NUMBER_AMS"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_NUMBER_PAY"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_NUMBER_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_NUMBER_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_NUMBER_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_FIRST_SERVICE_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_FIRST_SERVICE_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_FIRST_SERVICE_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_FIRST_SERVICE_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_FIRST_SERVICE_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_FIRST_SERVICE_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CASE_MANAGER_FLAG_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CASE_MANAGER_FLAG_AMS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CASE_MANAGER_FLAG_PAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CASE_MANAGER_FLAG_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CASE_MANAGER_FLAG_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CASE_MANAGER_FLAG_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REASON_TO_TERMINATE_WD"
	type = "VARCHAR(2295)"
	nullable = true
}


column {
	name = "REASON_TO_TERMINATE_AMS"
	type = "VARCHAR(2295)"
	nullable = true
}


column {
	name = "REASON_TO_TERMINATE_PAY"
	type = "VARCHAR(2295)"
	nullable = true
}


column {
	name = "REASON_TO_TERMINATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REASON_TO_TERMINATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REASON_TO_TERMINATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AMS_SOURCE_SYSTEM_WD"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "AMS_SOURCE_SYSTEM_AMS"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "AMS_SOURCE_SYSTEM_PAY"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "AMS_SOURCE_SYSTEM_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AMS_SOURCE_SYSTEM_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AMS_SOURCE_SYSTEM_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATUS_WD"
	type = "VARCHAR(2295)"
	nullable = true
}


column {
	name = "STATUS_AMS"
	type = "VARCHAR(2295)"
	nullable = true
}


column {
	name = "STATUS_PAY"
	type = "VARCHAR(2295)"
	nullable = true
}


column {
	name = "STATUS_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATUS_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATUS_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_SUFFIX_WD"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_SUFFIX_AMS"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_SUFFIX_PAY"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_SUFFIX_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_SUFFIX_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_SUFFIX_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_TERMINATE_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_TERMINATE_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_TERMINATE_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_TERMINATE_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_TERMINATE_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_TERMINATE_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1_WD"
	type = "VARCHAR(13500)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1_AMS"
	type = "VARCHAR(13500)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1_PAY"
	type = "VARCHAR(13500)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CATEGORY_WD"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_CATEGORY_AMS"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_CATEGORY_PAY"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_CATEGORY_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CATEGORY_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CATEGORY_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_LAST_CHECK_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_LAST_CHECK_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_LAST_CHECK_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_LAST_CHECK_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_LAST_CHECK_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_LAST_CHECK_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_TYPE_WD"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_TYPE_AMS"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_TYPE_PAY"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_TYPE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_TYPE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_TYPE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE_WD"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE_AMS"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE_PAY"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PID_WD"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "EMPLOYEE_PID_AMS"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "EMPLOYEE_PID_PAY"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "EMPLOYEE_PID_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PID_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PID_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_DEPARTMENT_WD"
	type = "VARCHAR(90)"
	nullable = true
}


column {
	name = "EMPLOYEE_DEPARTMENT_AMS"
	type = "VARCHAR(90)"
	nullable = true
}


column {
	name = "EMPLOYEE_DEPARTMENT_PAY"
	type = "VARCHAR(90)"
	nullable = true
}


column {
	name = "EMPLOYEE_DEPARTMENT_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_DEPARTMENT_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_DEPARTMENT_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY_WD"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY_AMS"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY_PAY"
	type = "VARCHAR(288)"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_HIRE_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_HIRE_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_HIRE_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_HIRE_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_HIRE_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_HIRE_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER_WD"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER_AMS"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER_PAY"
	type = "VARCHAR(180)"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME_WD"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME_AMS"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME_PAY"
	type = "VARCHAR(9000)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORKERS_COMP_WD"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "WORKERS_COMP_AMS"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "WORKERS_COMP_PAY"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "WORKERS_COMP_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORKERS_COMP_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORKERS_COMP_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COORDINATOR_FLAG_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COORDINATOR_FLAG_AMS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COORDINATOR_FLAG_PAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COORDINATOR_FLAG_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COORDINATOR_FLAG_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COORDINATOR_FLAG_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PREFIX_WD"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_PREFIX_AMS"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_PREFIX_PAY"
	type = "VARCHAR(1800)"
	nullable = true
}


column {
	name = "EMPLOYEE_PREFIX_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PREFIX_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PREFIX_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JAZZHR_APPLICANT_ID_WD"
	type = "VARCHAR(1350)"
	nullable = true
}


column {
	name = "JAZZHR_APPLICANT_ID_AMS"
	type = "VARCHAR(1350)"
	nullable = true
}


column {
	name = "JAZZHR_APPLICANT_ID_PAY"
	type = "VARCHAR(1350)"
	nullable = true
}


column {
	name = "JAZZHR_APPLICANT_ID_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JAZZHR_APPLICANT_ID_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JAZZHR_APPLICANT_ID_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JAZZHR_USER_ID_WD"
	type = "VARCHAR(13500)"
	nullable = true
}


column {
	name = "JAZZHR_USER_ID_AMS"
	type = "VARCHAR(13500)"
	nullable = true
}


column {
	name = "JAZZHR_USER_ID_PAY"
	type = "VARCHAR(13500)"
	nullable = true
}


column {
	name = "JAZZHR_USER_ID_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JAZZHR_USER_ID_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "JAZZHR_USER_ID_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP_WD"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP_AMS"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP_PAY"
	type = "VARCHAR(900)"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTIVE_EMPLOYEE_FLAG_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTIVE_EMPLOYEE_FLAG_AMS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTIVE_EMPLOYEE_FLAG_PAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTIVE_EMPLOYEE_FLAG_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTIVE_EMPLOYEE_FLAG_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTIVE_EMPLOYEE_FLAG_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SYSTEM_CODE_WD"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SYSTEM_CODE_AMS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SYSTEM_CODE_PAY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ROW_IS_MATCH"
	type = "BOOLEAN"
	nullable = true
}

}

