resource "snowflake_table" "DISC_PARADOX_CANDIDATE_JOURNEY_FULLLOAD_20231003" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "CANDIDATE_JOURNEY_FULLLOAD_20231003"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.CANDIDATE_JOURNEY_FULLLOAD_20231003

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
	name = "REQ_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STORE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORGANIZATIONAL_ALIGNMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
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
	name = "PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_ENGAGED_CLICKED_APPLY_NOW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_CAPTURE_COMPLETE_SCREENING_COMPLETE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REJECTED_DID_NOT_MEET_AGE_REQUIREMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INTERVIEW_REQUEST_SENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INTERVIEW_ACCEPTED_BY_CANDIDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INTERVIEW_REQUEST_CANCELED_USER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INTERVIEW_REQUEST_CANCELED_CANDIDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INTERVIEW_SCHEDULED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INTERVIEW_NO_SHOW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REJECTED_NOT_ELIGIBLE_FOR_WORK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIRE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_CAPTURE_COMPLETE_TO_INTERVIEW_ACCEPTANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_CAPTURE_COMPLETE_TO_INTERVIEW_SCHEDULED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_INTERVIEW_REQUEST_SENT_TO_INTERVIEW_SCHEDULED_"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_INTERVIEW_SCHEDULED_TO_HIRE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_CAPTURE_COMPLETE_TO_HIRE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_SOURCED_FROM_NAME"
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
	name = "SEND_FULL_APPLICATION_FORM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FULL_APPLICATION_FORM_COMPLETE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_SENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONBOARDING_COMPLETE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_INTERVIEW_SCHEDULED_TO_ONBOARDING_COMPLETE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFER_SENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFER_ACCEPTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFER_DECLINED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_INTERVIEW_SCHEDULED_TO_OFFER_SENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_INTERVIEW_SCHEDULED_TO_OFFER_ACCEPTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ANTICIPATED_START_DATE_HIRE_DETAILS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_INTERVIEW_SCHEDULED_TO_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_TITLE_CODE"
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
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
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

