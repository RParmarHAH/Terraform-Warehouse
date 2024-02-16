resource "snowflake_table" "DISC_JAZZHR_HIST_APPLICANTS_DETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "JAZZHR"
	name = "HIST_APPLICANTS_DETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.JAZZHR.HIST_APPLICANTS_DETAILS

    -- Purpose : Discovery Data Population

    -- Project : JAZZHR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LINKEDIN_URL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EEO_GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EEO_RACE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EEO_DISABILITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEBSITE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESIRED_SALARY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESIRED_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LANGUAGES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WMYU"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HAS_DRIVER_LICENSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WILLING_TO_RELOCATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITIZENSHIP_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EDUCATION_LEVEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HAS_CDL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVER_18"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAN_WORK_WEEKENDS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAN_WORK_EVENINGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAN_WORK_OVERTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HAS_FELONY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FELONY_EXPLANATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TWITTER_USERNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COLLEGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLY_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMMENTS_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECRUITER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EEOC_VETERAN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EEOC_DISABILITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EEOC_DISABILITY_SIGNATURE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EEOC_DISABILITY_DATE"
	type = "VARCHAR(16777216)"
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

