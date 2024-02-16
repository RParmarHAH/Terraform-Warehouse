resource "snowflake_table" "DISC_PARADOX_HIST_CANDIDATE_JOURNEY_STATUS_HISTORY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "HIST_CANDIDATE_JOURNEY_STATUS_HISTORY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.HIST_CANDIDATE_JOURNEY_STATUS_HISTORY

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
	type = "NUMBER(16,0)"
	nullable = true
}


column {
	name = "CANDIDATE_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CANDIDATE_PHONE_NUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CANDIDATE_EMAIL"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CANDIDATE_CREATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REQUISITION_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "JOB_CODE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "LOCATION_NAME"
	type = "VARCHAR(45)"
	nullable = true
}


column {
	name = "CANDIDATE_JOURNEY_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "JOURNEY_STAGE_NAME"
	type = "VARCHAR(42)"
	nullable = true
}


column {
	name = "JOURNEY_STAGE_ORDER_NUMBER"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "JOURNEY_STATUS_ORDER_NUMBER"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "STATUS_CHANGE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(105)"
	nullable = true
}


column {
	name = "STATUS_CHANGED_BY_USER"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CANDIDATE_SOURCE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CANDIDATE_SOURCED_FROM_NAME"
	type = "VARCHAR(2048)"
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

