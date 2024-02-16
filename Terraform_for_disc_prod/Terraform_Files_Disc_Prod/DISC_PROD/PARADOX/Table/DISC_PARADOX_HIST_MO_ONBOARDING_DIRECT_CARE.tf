resource "snowflake_table" "DISC_PARADOX_HIST_MO_ONBOARDING_DIRECT_CARE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "HIST_MO_ONBOARDING_DIRECT_CARE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.HIST_MO_ONBOARDING_DIRECT_CARE

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
	name = "ONBOARDING_DOCUMENTS_PLEASE_REVIEW_AND_ACCEPT_THE_JOB_REQUIREMENTS_JD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_HELP_AT_HOME_EEO_SURVEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_I9"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_HELP_AT_HOME_DIRECT_DEPOSIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_WOTC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_RECEIPT_OF_ID_CARD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_TB_EDUCATION_FORM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_ACKNOWLEDGEMENT_OF_INSURANCE_OFFER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_EMPLOYEE_HANDBOOK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_ACKNOWLEDGEMENT_HANDBOOK_SIGNOFF"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_HELP_AT_HOME_HANDBOOK_SIGN_OFF"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_HAH_CODE_OF_ETHICAL_STANDARDS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_INHOME_SERVICE_STANDARDS__NEPOTISM_ACKNOWLEDGEMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_BASIC_TRAINING_AND_NON_TRANSPORT_ACKNOWLEDGEMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_ACKNOWLEDGEMENT_OF_FVV_AND_EVV_TRAINING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_19_CSR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_I_CONSENT"
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

