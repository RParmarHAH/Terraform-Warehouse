resource "snowflake_table" "DISC_PARADOX_HIST_GA_ONBOARDING_ADMIN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "HIST_GA_ONBOARDING_ADMIN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.HIST_GA_ONBOARDING_ADMIN

    -- Purpose : Discovery Data Population

    -- Project : PARADOX

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "FORM_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_APPLIED_TO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_REQ_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENT_CANDIDATE_JOURNEY_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORM_DATE_SENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORM_IN_PROGRESS_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORM_COMPLETION_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORM_DATE_SUBMITTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORM_PREVIEW_LINK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PUBLISHED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PUBLISHED_VERSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROFILE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MULTIPLE_RECORDS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_IDENTIFIER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REAPPLY_IN_CAPTURE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REAPPLY_IN_JOB_SEARCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REAPPLY_IN_CAMPAIGN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WELCOME_LETTER_HELP_AT_HOME_EEO_SURVEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WELCOME_LETTER_PLEASE_REVIEW_AND_ACCEPT_THE_JOB_REQUIREMENTS_JD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WELCOME_LETTER_WELCOME_LETTER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_YOUR_FULL_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_STREET_ADDRESS_LINE_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_STREET_ADDRESS_LINE_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_EMPLOYEE_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_EMPLOYEE_EMAIL_ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_PRIMARY_EMERGENCY_CONTACT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_PRIMARY_EMERGENCY_CONTACT_CELL_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_RELATION_TO_CAREGIVER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_SECONDARY_EMERGENCY_CONTACT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY_CONTACT_SECONDARY_EMERGENCY_CONTACT_CELL_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATEMENT_OF_NO_ABUSE_STATEMENT_OF_NO_ABUSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_DESCRIPTION_PLEASE_REVIEW_AND_ACCEPT_THE_JOB_REQUIREMENTS_JD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAX_DOCUMENTS__DIRECT_DEPOSIT_I9"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAX_DOCUMENTS__DIRECT_DEPOSIT_DIRECT_DEPOSIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAX_WITHHOLDING_TAX_WITHHOLDING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAX_WITHHOLDING_FEDERAL_TAX_FORMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAX_WITHHOLDING_STATE_TAX_FORMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CODE_OF_CONDUCT__HANDBOOK_HELP_AT_HOME_ADMIN_HANDBOOK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CODE_OF_CONDUCT__HANDBOOK_HAH_CODE_OF_ETHICAL_STANDARDS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_ELIGIBILITY_CERTIFICATION_FORM_EMPLOYMENT_ELIGIBILITY_CERTIFICATION_FORM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACKNOWLEDGEMENT_OF_INSURANCE_ACKNOWLEDGMENT_OF_THE_INSURANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HEPATITIS_B_VIRUS_HBV_VACCINATION_AUTHORIZATION_HEPATITIS_B_VIRUS_HBV_VACCINATION_AUTHORIZATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VEHICLE_USE_POLICY_AND_AGREEMENT_VEHICLE_USE_POLICY_AND_AGREEMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_RIGHTS__RESPONSIBILITIES_CLIENT_RIGHTS__RESPONSIBILITIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FINAL_SUBMISSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(6,0)"
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

}

