resource "snowflake_table" "DISC_PARADOX_HIST_CANDIDATE_SPECIFIC_BKP_27_12" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "HIST_CANDIDATE_SPECIFIC_BKP_27_12"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.HIST_CANDIDATE_SPECIFIC_BKP_27_12

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
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CANDIDATE_LAST_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CANDIDATE_PHONE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CANDIDATE_EMAIL"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CANDIDATE_ID"
	type = "NUMBER(16,0)"
	nullable = true
}


column {
	name = "APPLICATION_ID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "REQUISITION_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CAPTURE_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAPTURE_COMPLETE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TALK_TIME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "JOB_CATEGORY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "PAST_JOB_CATEGORY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CONVERSATION"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CONVERSATION_TYPE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "KEYWORD"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "LOCATION_NAME"
	type = "VARCHAR(45)"
	nullable = true
}


column {
	name = "PAST_LOCATION_NAME"
	type = "VARCHAR(45)"
	nullable = true
}


column {
	name = "REPLIED_TO"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "DATE_TIME_REPLIED_TO"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "SCHEDULED"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "DATE_TIME_REQUEST_SENT"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "TIME_FROM_START_TO_SCHEDULE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "DATE_TIME_SCHEDULED"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "RECRUITER"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SOURCE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CANDIDATE_SOURCED_FROM_NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SOURCE_ID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CANDIDATE_EXTERNAL_ID_1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CANDIDATE_EXTERNAL_ID_2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CANDIDATE_EXTERNAL_ID_3"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RESUME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CHAT_TO_APPLY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "SCHEDULING_OPTIN_PENDING"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CANDIDATE_LANGUAGE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "SMS_REMINDERS_SENT"
	type = "NUMBER(2,0)"
	nullable = true
}


column {
	name = "EMAIL_REMINDERS_SENT"
	type = "NUMBER(2,0)"
	nullable = true
}


column {
	name = "CONVERSATION_REMINDER_OPTOUT"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "JOB_CITY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "JOB_STATE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION_ID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION_CITY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION_STATE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION_STATE_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION_COUNTRY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION__LEVEL_1"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION__LEVEL_2"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION__LEVEL_3"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "UNSUBSCRIBED"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CANDIDATE_ASSOCIATED_TO__USERS_FULL_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CANDIDATE_ASSOCIATED_TO__USERS_EMAIL"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CANDIDATE_ASSOCIATED_TO__USERS_PHONE_NUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CANDIDATE_TIMEZONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "MEDIUM_ID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CAMPAIGN_ID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "TERM_ID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CONTENT_ID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "REFERRALS__PROFILE_ID_MATCH"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RECORDED_VIDEO_INTERVIEW"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RECORDED_VIDEO_RESPONSE_COUNT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RECORDED_VIDEO_QUESTIONS_SENT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ALL_RECORDED_VIDEO_ANSWERS_WITHIN_24_HOURS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ASSISTANT_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ENGAGED_RECRUITER_TA_USERS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TOTAL_PARADOX_VIDEO_MEETINGS"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "TOTAL_PARADOX_VIDEO_DURATION_IN_MINUTES"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CURRENT_CANDIDATE_JOURNEY_STATUS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SHORTCODE_PHONE_NUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PROFILE_ID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "MULTIPLE_RECORDS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PRIMARY_IDENTIFIER"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "REAPPLY_IN_CAPTURE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REAPPLY_IN_JOB_SEARCH"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REAPPLY_IN_CAMPAIGN"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAY_RATE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "STREET_ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "STREET_ADDRESS_LINE_2"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "ZIP_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COMPANY_BRAND"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "EDUCATION_1_CURRENT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EDUCATION_2_CURRENT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EDUCATION_3_CURRENT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EDUCATION_1_DEGREE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EDUCATION_2_DEGREE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EDUCATION_3_DEGREE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EDUCATION_1_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EDUCATION_2_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EDUCATION_3_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EDUCATION_1_MAJOR"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EXPERIENCE_3_JOB_TYPE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EDUCATION_2_MAJOR"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EDUCATION_3_MAJOR"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EDUCATION_1_INSTITUTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EDUCATION_2_INSTITUTION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EDUCATION_3_INSTITUTION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EDUCATION_1_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EDUCATION_2_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EDUCATION_3_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EEO_DISABILITY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "EEO_ETHNICITY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "EEO_GENDER"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "EEO_RACE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "EEO_VETERAN"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EXPERIENCE_1_COMPANY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EXPERIENCE_2_COMPANY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EXPERIENCE_3_COMPANY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EXPERIENCE_1_CURRENT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EXPERIENCE_2_CURRENT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EXPERIENCE_3_CURRENT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EXPERIENCE_1_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXPERIENCE_2_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXPERIENCE_3_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXPERIENCE_1_LOCATION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EXPERIENCE_2_LOCATION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EXPERIENCE_3_LOCATION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EXPERIENCE_1_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXPERIENCE_2_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXPERIENCE_3_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXPERIENCE_1_TITLE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EXPERIENCE_2_TITLE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EXPERIENCE_3_TITLE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EXPERIENCE_1_JOB_TYPE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EXPERIENCE_2_JOB_TYPE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "INTERNAL_CANDIDATE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "INTERNAL_JOB"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "OFFER_ACCEPTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFFER_CREATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ONBOARDING_ASSIGNMENT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PHONE_NUMBER"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "__APPLICATION_ID"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "__EX_ID_1"
	type = "VARCHAR(200)"
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
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

