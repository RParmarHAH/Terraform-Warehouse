resource "snowflake_table" "DISC_PARADOX_OPEN_JOBS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "OPEN_JOBS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.OPEN_JOBS

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
	name = "STORE_"
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
	name = "JOB_CREATED_DATE"
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
	name = "JOB_OWNER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_OWNER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQ_AGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQ_AGE_GROUP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATES_APPLIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATES_PASSED_SCREENING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATES_FULL_APPLICATION_COMPLETE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INTERVIEWS_SENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULING_REQUESTS_ACCEPTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATES_INTERVIEW_SCHEDULED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INTERVIEWS_RESCHEDULED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INTERVIEWS_CANCELED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFER_EXTENDED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATES_OFFER_ACCEPTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_POSTING_LINK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_TITLE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_CANDIDATES_ADDED_MANUALLY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_JOURNEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORMS_USED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTERNAL_JOB_REFERENCE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEFAULT_INTERVIEW_ATTENDEES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ARCHIVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_LOCATION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AREA__LEVEL_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AREA__LEVEL_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AREA__LEVEL_3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_ATTR__ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_ATTR__ADDRESS_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_ATTR__CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_ATTR__COUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_ATTR__LOCATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_ATTR__LOCATION_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_ATTR__LOCATION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_ATTR__LOCATION_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_ATTR__PROVINCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_ATTR__STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_ATTR__ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIRING_TEAM__RECRUITER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIRING_TEAM__HIRING_MANAGER"
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

