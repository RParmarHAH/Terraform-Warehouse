resource "snowflake_table" "DISC_PARADOX_CANDIDATE_FORM_PA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "CANDIDATE_FORM_PA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.CANDIDATE_FORM_PA

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
	name = "PERSONAL_INFORMATION_SOCIAL_SECURITY_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_EMERGENCY_CONTACT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_EMERGENCY_CONTACT_CELL_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_EMERGENCY_CONTACT_HOME_PHONE_NUMBER"
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
	name = "PERSONAL_INFORMATION_HAVE_YOU_PREVIOUSLY_WORKED_FOR_HELP_AT_HOME_OR_EXCEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_DO_YOU_HAVE_THE_LEGAL_RIGHT_TO_WORK_IN_THE_US_WITHOUT_SPONSORSHIPS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_DO_YOU_HAVE_A_COPY_OF_A_TB_TEST_COMPLETED_LESS_THAN_12_MONTHS_AGO"
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
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_1__EMPLOYER_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_2__EMPLOYER_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_3__EMPLOYER_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_1__EMPLOYER_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_2__EMPLOYER_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_3__EMPLOYER_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_1__EMPLOYER_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_2__EMPLOYER_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_3__EMPLOYER_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_1__EMPLOYER_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_2__EMPLOYER_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_3__EMPLOYER_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_1__SUPERVISOR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_2__SUPERVISOR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_3__SUPERVISOR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_1__POSITION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_2__POSITION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_3__POSITION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_1__DATE_STARTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_2__DATE_STARTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_3__DATE_STARTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_1__DATE_ENDED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_2__DATE_ENDED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_3__DATE_ENDED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_1__REASON_FOR_LEAVING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_2__REASON_FOR_LEAVING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_HISTORYPLEASE_PROVIDE_MINIMUM_2_YEARS_3__REASON_FOR_LEAVING"
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
	name = "EQUAL_EMPLOYMENT_OPPORTUNITY_GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EQUAL_EMPLOYMENT_OPPORTUNITY_RACEETHNICITY_SELFIDENTIFICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EQUAL_EMPLOYMENT_OPPORTUNITY_WHAT_IS_YOUR_PREFERRED_LANGUAGE_FOR_COMMUNICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INITIAL_COMPETENCY_EXAM_MATH_SUPPLEMENT_DO_YOU_HAVE_A_HIGH_SCHOOL_DIPLOMA_OR_GED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDINGBACKGROUND_CHECK_REQUIREMENTS_JOB_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDINGBACKGROUND_CHECK_REQUIREMENTS_PROVISIONAL_EMPLOYMENT_DISCLOSURE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDINGBACKGROUND_CHECK_REQUIREMENTS_PENNSYLVANIA_CHILD_ABUSE_HISTORY_CERTIFICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDINGBACKGROUND_CHECK_REQUIREMENTS_CONSENT_RELEASE_OF_INFORMATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDINGBACKGROUND_CHECK_REQUIREMENTS_REFERENCES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDINGBACKGROUND_CHECK_REQUIREMENTS_EMPLOYMENT_AGREEMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDINGBACKGROUND_CHECK_REQUIREMENTS_EVERIFY_FORM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDINGBACKGROUND_CHECK_REQUIREMENTS_PLEASE_READ_AND_SIGN_THIS_FORM_IN_THE_SPACE_PROVIDED_BELOW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDINGBACKGROUND_CHECK_REQUIREMENTS_PLEASE_CONFIRM_YOU_HAVE_REVIEWED_THE_STATEMENT_ABOVE_AND_AGREE_TO_THE_TERMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROOF_OF_RESIDENCY_PASSPORT_BIRTH_CERTIFICATE_OR_SOCIAL_SECURITY_CARD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROOF_OF_RESIDENCY_STATE_ISSUED_ID_OR_DRIVERS_LICENSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROOF_OF_RESIDENCY_STATEISSUED_ID_OR_DRIVERS_LICENSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROOF_OF_RESIDENCY_HAVE_YOU_BEEN_A_RESIDENT_OF_PENNSYLVANIA_FOR_2_CONSECUTIVE_YEARS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ATTESTATION_I_CERTIFY_THAT_THE_FACTS_CONTAINED_IN_THIS_APPLICATION_ARE_TRUE_AND_COMPLETE_AND_TO_THE_BEST_OF_MY_KNOWLEDGE_I_UNDERSTAND_THAT_IF_EMPLOYED"
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

