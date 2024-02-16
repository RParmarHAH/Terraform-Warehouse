resource "snowflake_table" "DISC_PARADOX_HIST_PA_ONBOARDING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "HIST_PA_ONBOARDING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.HIST_PA_ONBOARDING

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
	name = "ONBOARDING_DOCUMENTS_JOB_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_DIRECT_DEPOSIT_ENROLLMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__WOTC_APPLICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__FACE_TO_FACE_INTERVIEW_DOCUMENTATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__ACKNOWLEDGMENT_OF_THE_INSURANCE_OFFER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__HEPATITIS_B_VACCINE_ACCEPTANCE_DECLINATION_FORM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__EMPLOYMENT_PROHIBITION_ACKNOWLEDGMENT_FORM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__DIRECT_DEPOSIT_ENROLLMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__I9"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__W4"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__TB_SYMPTOM_ASSESSMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__TB_RISK_ASSESSMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__TRAININGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__PPD_COVID_TRAINING_ACKNOWLEDGEMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__EMPLOYEE_HANDBOOK_ACKNOWLEDGEMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__ACKNOWLEDGMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_FIELD_EMPLOYEE_HANDBOOK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_TRAININGS_ACKNOWLEDGMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_TRAININGS_ACKNOWLEDGMENTS_SIGN_OFF"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_FWA_FORM_SIGN_OFF"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_HAH_CODE_OF_ETHICAL_STANDARDS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_WORKER_S_COMPENSATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS_BADGE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_DOCUMENTS__I_CONSENT_TO_HELP_AT_HOME_COMMUNICATING_WITH_ME_DURING_MY_EMPLOYMENT_USING_THE_PERSONAL_CONTACT_INFORMATION_I_PROVIDED__THIS_COMMUNICATION_MAY_BE_MADE_BY_BUT_IS_NOT_LIMITED_TO_TELEPHONE_SMS_TEXT_AND_EMAIL"
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

