resource "snowflake_table" "DISC_PARADOX_CANDIDATE_FORM_MO" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "CANDIDATE_FORM_MO"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.CANDIDATE_FORM_MO

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
	name = "PERSONAL_INFORMATION_YOUR_FULL_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_EMAIL_ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_STREET_ADDRESS_LINE_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_STREET_ADDRESS_LINE_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_EMERGENCY_CONTACT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_EMERGENCY_CONTACT_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_EMERGENCY_CONTACT_ALTERNATE_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_RELATION_TO_CAREGIVER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_HOW_DID_YOU_HEAR_ABOUT_THIS_JOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_IF_OTHER_WHERE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_DO_YOU_HAVE_A_RELATIVE_THAT_WORKS_FOR_HELP_AT_HOME_IF_SO_WHAT_IS_THEIR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_AVAILABLE_DAYS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_HAVE_YOU_PREVIOUSLY_WORKED_FOR_HELP_AT_HOME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_DO_YOU_HAVE_THE_LEGAL_RIGHT_TO_WORK_IN_THE_US_WITHOUT_SPONSORSHIPS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_HISTORY_DO_YOU_HAVE_A_HIGH_SCHOOL_DIPLOMA_OR_GED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_HISTORY_IF_YES_WHAT_IS_THE_NAME_OF_THE_SCHOOL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_1__EMPLOYMENT_HISTORY_PLEASE_PROVIDE_MINIMUM_2_YEARS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_2__EMPLOYMENT_HISTORY_PLEASE_PROVIDE_MINIMUM_2_YEARS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_3__EMPLOYMENT_HISTORY_PLEASE_PROVIDE_MINIMUM_2_YEARS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_1__EMPLOYER_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_2__EMPLOYER_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_3__EMPLOYER_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_1__EMPLOYER_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_2__EMPLOYER_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_3__EMPLOYER_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_1__EMPLOYER_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_2__EMPLOYER_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_3__EMPLOYER_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_1__SUPERVISOR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_2__SUPERVISOR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_3__SUPERVISOR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_1__POSITION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_2__POSITION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_3__POSITION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_1__DATE_STARTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_2__DATE_STARTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_3__DATE_STARTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_1__DATE_ENDED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_2__DATE_ENDED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_3__DATE_ENDED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_1__REASON_FOR_LEAVING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_2__REASON_FOR_LEAVING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORY_3__REASON_FOR_LEAVING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCES_NAME_OF_REFERENCE_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCES_PHONE_NUMBER_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCES_RELATIONSHIP_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCES_NAME_OF_REFERENCE_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCES_REFERENCE_2_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCES_REFERENCE_2_RELATIONSHIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EQUAL_EMPLOYMENT_OPPORTUNITY_EEO_VOLUNTARY_SELFIDENTIFICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EQUAL_EMPLOYMENT_OPPORTUNITY_EQUAL_EMPLOYMENT_OPPORTUNITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EQUAL_EMPLOYMENT_OPPORTUNITY_WHAT_IS_YOUR_PREFERRED_LANGUAGE_FOR_COMMUNICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROOF_OF_RESIDENCY_PASSPORT_BIRTH_CERTIFICATE_OR_SOCIAL_SECURITY_CARD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROOF_OF_RESIDENCY_STATE_ISSUED_ID_OR_DRIVERS_LICENSE_FRONT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROOF_OF_RESIDENCY_STATE_ISSUED_ID_OR_DRIVERS_LICENSE_BACK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROOF_OF_RESIDENCY_PLEASE_SELECT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROOF_OF_RESIDENCY_HAVE_YOU_BEEN_A_RESIDENT_OF_MISSOURI_FOR_5_CONSECUTIVE_YEARS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDINGBACKGROUND_CHECK_REQUIREMENTS_BACKGROUND_CONSENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ATTESTATION_PLEASE_READ_AND_SIGN_THIS_FORM_IN_THE_SPACE_PROVIDED_BELOW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ATTESTATION_PLEASE_CONFIRM_YOU_HAVE_REVIEWED_THE_STATEMENT_ABOVE_AND_AGREE_TO_THE_TERMS"
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

