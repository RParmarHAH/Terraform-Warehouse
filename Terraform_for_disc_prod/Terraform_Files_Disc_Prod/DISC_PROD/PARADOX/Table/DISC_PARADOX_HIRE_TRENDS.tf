resource "snowflake_table" "DISC_PARADOX_HIRE_TRENDS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "HIRE_TRENDS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.HIRE_TRENDS

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
	name = "STORE_"
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
	name = "TOTAL_CANDIDATES_ENGAGED_APPLY_NOW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_CANDIDATES_CAPTURE_COMPLETE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_INTERVIEW_REQUESTS_SENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_INTERVIEWS_ACCEPTED_BY_CANDIDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_INTERVIEWS_CANCELED_BY_CANDIDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_INTERVIEWS_CANCELED_BY_USER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_INTERVIEWS_SCHEDULED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AVG_TIME_FROM_CAPTURE_COMPLETE_TO_INTERVIEWS_ACCEPTED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDIAN_TIME_FROM_CAPTURE_COMPLETE_TO_INTERVIEWS_ACCEPTED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAX_TIME_FROM_CAPTURE_COMPLETE_TO_INTERVIEWS_ACCEPTED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIN_TIME_FROM_CAPTURE_COMPLETE_TO_INTERVIEWS_ACCEPTED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AVG_TIME_FROM_CAPTURE_COMPLETE_TO_INTERVIEWS_SCHEDULED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDIAN_TIME_FROM_CAPTURE_COMPLETE_TO_INTERVIEWS_SCHEDULED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAX_TIME_FROM_CAPTURE_COMPLETE_TO_INTERVIEWS_SCHEDULED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIN_TIME_FROM_CAPTURE_COMPLETE_TO_INTERVIEWS_SCHEDULED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_OFFERS_SENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AVG_TIME_FROM_INTERVIEWS_SCHEDULED_TO_OFFERS_SENT_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDIAN_TIME_FROM_INTERVIEWS_SCHEDULED_TO_OFFERS_SENT_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAX_TIME_FROM_INTERVIEWS_SCHEDULED_TO_OFFERS_SENT_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIN_TIME_FROM_INTERVIEWS_SCHEDULED_TO_OFFERS_SENT_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_OFFERS_ACCEPTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AVG_TIME_FROM_CAPTURE_COMPLETE_TO_OFFERS_ACCEPTED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDIAN_TIME_FROM_CAPTURE_COMPLETE_TO_OFFERS_ACCEPTED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAX_TIME_FROM_CAPTURE_COMPLETE_TO_OFFERS_ACCEPTED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIN_TIME_FROM_CAPTURE_COMPLETE_TO_OFFERS_ACCEPTED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_ONBOARDING_SENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AVG_TIME_FROM_OFFERS_ACCEPTED_TO_ONBOARDING_SENT_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDIAN_TIME_FROM_OFFERS_ACCEPTED_TO_ONBOARDING_SENT_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAX_TIME_FROM_OFFERS_ACCEPTED_TO_ONBOARDING_SENT_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIN_TIME_FROM_OFFERS_ACCEPTED_TO_ONBOARDING_SENT_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_ONBOARDING_COMPLETE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AVG_TIME_FROM_CAPTURE_COMPLETE_TO_ONBOARDING_COMPLETE_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDIAN_TIME_FROM_CAPTURE_COMPLETE_TO_ONBOARDING_COMPLETE_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAX_TIME_FROM_CAPTURE_COMPLETE_TO_ONBOARDING_COMPLETE_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIN_TIME_FROM_CAPTURE_COMPLETE_TO_ONBOARDING_COMPLETE_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_HIRED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AVG_TIME_FROM_CAPTURE_COMPLETE_TO_HIRED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDIAN_TIME_FROM_CAPTURE_COMPLETE_TO_HIRED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAX_TIME_FROM_CAPTURE_COMPLETE_TO_HIRED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIN_TIME_FROM_CAPTURE_COMPLETE_TO_HIRED_HHMMSS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_RECORDED_INTERVIEWS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_COUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_LEVEL_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_LEVEL_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_LEVEL_3"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

