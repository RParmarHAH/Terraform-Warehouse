resource "snowflake_table" "DISC_QUALTRICS_SURVEYS_QUALTRICS_SURVEY_DISTRIBUTION_LIST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS_SURVEYS"
	name = "QUALTRICS_SURVEY_DISTRIBUTION_LIST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_DISTRIBUTION_LIST

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
	name = "ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PARENT_DISTRIBUTION_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "OWNER_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ORGANIZATION_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "REQUEST_STATUS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "REQUEST_TYPE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SURVEY_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SEND_DATE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "MODIFIED_DATE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "HEADERS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "RECIPIENTS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "MESSAGE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "STATS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SURVEY_LINK_EXPIRATION_DATE"
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

