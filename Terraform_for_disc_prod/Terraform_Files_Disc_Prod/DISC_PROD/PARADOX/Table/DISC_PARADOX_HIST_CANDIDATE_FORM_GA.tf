resource "snowflake_table" "DISC_PARADOX_HIST_CANDIDATE_FORM_GA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "HIST_CANDIDATE_FORM_GA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.HIST_CANDIDATE_FORM_GA

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
	name = "PERSONAL_INFORMATION_CELL_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_ALTERNATE_PHONE_NUMBER"
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
	name = "PERSONAL_INFORMATION_DESIRED_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_HOW_DID_YOU_HEAR_ABOUT_THIS_JOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_IF_REFERRAL_PLEASE_LIST_EMPLOYEE_NAME_TYPE_NA_IF_NOT_APPLICABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_AVAILABLE_DAYS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_HOW_MANY_HOURS_ARE_YOU_AVAILABLE_PER_DAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_HAVE_YOU_PREVIOUSLY_WORKED_FOR_HELP_AT_HOME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_DO_YOU_HAVE_RELATIVES_ANDOR_FAMILY_MEMBERS_OF_YOUR_HOUSEHOLD_WHO_ARE_EMPLOYED_BY_HELP_AT_HOME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_DO_YOU_HAVE_THE_LEGAL_RIGHT_TO_WORK_IN_THE_US_WITHOUT_SPONSORSHIPS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_ARE_YOU_AGE_18_OR_OLDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONAL_INFORMATION_HAVE_YOU_COMPLETED_A_TB_TEST_IN_THE_PAST_6_MONTHS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_1__WORK_EXPERIENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_2__WORK_EXPERIENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_3__WORK_EXPERIENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_4__WORK_EXPERIENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_5__WORK_EXPERIENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_1__COMPANY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_2__COMPANY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_3__COMPANY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_4__COMPANY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_5__COMPANY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_1__LOCATION_CITYSTATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_2__LOCATION_CITYSTATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_3__LOCATION_CITYSTATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_4__LOCATION_CITYSTATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_5__LOCATION_CITYSTATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_1__PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_2__PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_3__PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_4__PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_5__PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_1__SUPERVISOR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_2__SUPERVISOR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_3__SUPERVISOR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_4__SUPERVISOR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_5__SUPERVISOR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_1__JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_2__JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_3__JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_4__JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_5__JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_1__DATE_STARTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_2__DATE_STARTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_3__DATE_STARTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_4__DATE_STARTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_5__DATE_STARTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_1__DATE_ENDED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_2__DATE_ENDED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_3__DATE_ENDED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_4__DATE_ENDED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_5__DATE_ENDED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_1__REASON_FOR_LEAVING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_2__REASON_FOR_LEAVING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_3__REASON_FOR_LEAVING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_4__REASON_FOR_LEAVING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_5__REASON_FOR_LEAVING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_1__MAY_WE_CONTACT_YOUR_PREVIOUS_EMPLOYER_FOR_A_REFERENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_2__MAY_WE_CONTACT_YOUR_PREVIOUS_EMPLOYER_FOR_A_REFERENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_3__MAY_WE_CONTACT_YOUR_PREVIOUS_EMPLOYER_FOR_A_REFERENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_4__MAY_WE_CONTACT_YOUR_PREVIOUS_EMPLOYER_FOR_A_REFERENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_EXPERIENCE_5__MAY_WE_CONTACT_YOUR_PREVIOUS_EMPLOYER_FOR_A_REFERENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_NAME_OF_SCHOOL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_LOCATION_OF_SCHOOL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_TYPE_OF_SCHOOL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_GRADUATED_OR_COMPLETED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCES_REFERENCE_1_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCES_REFERENCE_1_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCES_REFERENCE_1_RELATIONSHIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCES_REFERENCE_2_NAME"
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
	name = "DIVERSITY_QUESTIONS_ETHNICITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIVERSITY_QUESTIONS_GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIVERSITY_QUESTIONS_MARITAL_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIVERSITY_QUESTIONS_PLEASE_PROVIDE_AN_ANSWER_BELOW"
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

