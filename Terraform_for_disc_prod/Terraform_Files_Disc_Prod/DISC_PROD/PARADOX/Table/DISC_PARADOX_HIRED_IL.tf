resource "snowflake_table" "DISC_PARADOX_HIRED_IL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "HIRED_IL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.HIRED_IL

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
	name = "CANDIDATE_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLICATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQUISITION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAPTURE_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAPTURE_COMPLETE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TALK_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAST_JOB_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONVERSATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONVERSATION_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "KEYWORD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAST_LOCATION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REPLIED_TO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATETIME_REPLIED_TO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATETIME_REQUEST_SENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_START_TO_SCHEDULE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATETIME_SCHEDULED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECRUITER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_SOURCED_FROM_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_EXTERNAL_ID_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_EXTERNAL_ID_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_EXTERNAL_ID_3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RESUME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHAT_TO_APPLY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULING_OPTIN_PENDING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_LANGUAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SMS_REMINDERS_SENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL_REMINDERS_SENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONVERSATION_REMINDER_OPTOUT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION_STATE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION_COUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION__LEVEL_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION__LEVEL_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION__LEVEL_3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNSUBSCRIBED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_ASSOCIATED_TO__USERS_FULL_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_ASSOCIATED_TO__USERS_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_ASSOCIATED_TO__USERS_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_TIMEZONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDIUM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAMPAIGN_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TERM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTENT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRALS__PROFILE_ID_MATCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDED_VIDEO_INTERVIEW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDED_VIDEO_RESPONSE_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDED_VIDEO_QUESTIONS_SENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALL_RECORDED_VIDEO_ANSWERS_WITHIN_24_HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ASSISTANT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENGAGED_RECRUITERTA_USERS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_PARADOX_VIDEO_MEETINGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_PARADOX_VIDEO_DURATION_IN_MINUTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENT_CANDIDATE_JOURNEY_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SHORTCODEPHONE_NUMBER"
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
	name = "PAY_RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STREET_ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STREET_ADDRESS_LINE_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPANY_BRAND"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_1_CURRENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_2_CURRENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_3_CURRENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_1_DEGREE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_2_DEGREE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_3_DEGREE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_1_END_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_2_END_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_3_END_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_1_MAJOR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXPERIENCE_3_JOB_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_2_MAJOR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_3_MAJOR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_1_INSTITUTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_2_INSTITUTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_3_INSTITUTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_1_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

