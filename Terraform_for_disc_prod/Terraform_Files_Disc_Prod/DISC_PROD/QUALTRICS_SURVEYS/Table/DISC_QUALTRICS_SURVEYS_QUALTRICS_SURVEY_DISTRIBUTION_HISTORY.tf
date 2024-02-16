resource "snowflake_table" "DISC_QUALTRICS_SURVEYS_QUALTRICS_SURVEY_DISTRIBUTION_HISTORY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS_SURVEYS"
	name = "QUALTRICS_SURVEY_DISTRIBUTION_HISTORY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_DISTRIBUTION_HISTORY

    -- Purpose : Discovery Data Population

    -- Project : QUALTRICS_SURVEYS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CONTACT_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CONTACT_LOOKUP_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "DISTRIBUTION_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SURVEYLINK"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CONTACT_FREQUENCY_RULE_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "RESPONSE_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "RESPONSE_COMPLETED_AT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SENT_AT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "OPENED_AT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "RESPONSE_STARTED_AT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SURVEY_SESSION_ID"
	type = "VARCHAR(1000)"
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
	type = "BOOLEAN"
	nullable = true
}

}

