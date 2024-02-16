resource "snowflake_table" "DISC_PARADOX_FILLED_JOBS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "FILLED_JOBS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.FILLED_JOBS

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
	name = "HIRING_MANAGER_NAME"
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
	name = "JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_FAMILY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_POSTING_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_CLOSING_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_AND_TIME_OFFER_ACCEPTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_TO_SCHEDULE"
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
	name = "CANDIDATE_ACCEPTED_OFFER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_REJECTED"
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
	name = "SALARY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLICATION_SOURCE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_APPLY_TO_INTERVIEW_HH_MM_SS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_INTERVIEW_TO_OFFER_HH_MM_SS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_OFFER_TO_HIRE_HH_MM_SS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_HIRED_TO_STARTDATE_HH_MM_SS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_APPLY_TO_HIRE_HH_MM_SS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_APPLY_TO_START_DATE_HH_MM_SS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_FULL_APPLICATION_COMPLETE_TO_HIRE_HH_MM_SS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_FULL_APPLICATION_COMPLETE_TO_START_DATE_HH_MM_SS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_ONBOARDING_SENT_TO_HIRED_HH_MM_SS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_FROM_ONBOARDING_SENT_TO_START_DATE_HH_MM_SS"
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
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "VARCHAR(2)"
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

