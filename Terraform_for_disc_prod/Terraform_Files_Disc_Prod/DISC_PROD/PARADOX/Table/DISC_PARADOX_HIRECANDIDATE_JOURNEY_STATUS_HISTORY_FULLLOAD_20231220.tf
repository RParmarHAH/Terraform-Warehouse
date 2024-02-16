resource "snowflake_table" "DISC_PARADOX_HIRECANDIDATE_JOURNEY_STATUS_HISTORY_FULLLOAD_20231220" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "HIRECANDIDATE_JOURNEY_STATUS_HISTORY_FULLLOAD_20231220"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.HIRECANDIDATE_JOURNEY_STATUS_HISTORY_FULLLOAD_20231220

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
	name = "CANDIDATE_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_CREATE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQUISITION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_JOURNEY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOURNEY_STAGE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOURNEY_STAGE_ORDER_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOURNEY_STATUS_ORDER_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS_CHANGE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS_CHANGED_BY_USER"
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

