resource "snowflake_table" "DISC_ALAYACARE_EMPLOYEE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "EMPLOYEE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.EMPLOYEE

    -- Purpose : Discovery Data Population

    -- Project : ALAYACARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROFILE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "GUID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "STATUS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HAS_SKILLS"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "PROFILE_ADDRESS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_BIRTHDAY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_BUSINESS_ENTITY_"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_CITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_COUNTRY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_COUNTY_"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_DO_NOT_HIRE_"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_EMAIL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_FIRST_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_GENDER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_IMPORT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_JOB_TITLE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_LAST_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_LEGACY_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_MARITAL_STATUS"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "PROFILE_PERSONAL_EMAIL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PHONE_MAIN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PHONE_PERSONAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_SSN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_START_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_STATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_TYPE_OF_CAREGIVER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_UID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ZIP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "USER_SETTINGS_STAFFING_EMPLOYEE_POSITION_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "USER_SETTINGS_STAFFING_EMPLOYEE_RULE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "USER_SETTINGS_STAFFING_PAYROLL_NUMBER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "USER_SETTINGS_STAFFING_SIN_NUMBER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EMPLOYEE_MINIMUM_DAILY_CAPACITY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_MAXIMUM_DAILY_CAPACITY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_MINIMUM_WEEKLY_CAPACITY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_MAXIMUM_WEEKLY_CAPACITY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_CURRENT_CASELOAD"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_ACTIVKEY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_DISPLAY_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_EMAIL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_IDACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_IDPROFILE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_IS_VENDOR"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_LASTVISIT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_PASSWORD"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_PASSWORD_UPDATED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_SUPERUSER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_TYPE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_ADDRESS_VALID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_DEPRECATED_GUID_TO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_FULLTEXT_INDEX"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_IDACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_IS_ACTIVE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_LIST_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_VERSION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_USERS_LANGUAGE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ETHNICITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ADDRESS_SUITE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_MIDDLE_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_TERMINATION_REASON"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_TERMINATION_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ACQUIRED_BUSINESS_"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ACQUISITION_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_SUPERVISOR_TAG"
	type = "VARCHAR(250)"
	nullable = true
}

}

