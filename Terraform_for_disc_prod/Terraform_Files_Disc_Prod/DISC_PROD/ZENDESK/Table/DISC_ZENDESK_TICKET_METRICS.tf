resource "snowflake_table" "DISC_ZENDESK_TICKET_METRICS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ZENDESK"
	name = "TICKET_METRICS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ZENDESK.TICKET_METRICS

    -- Purpose : Discovery Data Population

    -- Project : ZENDESK

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SOURCE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "URL"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "TICKET_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "GROUP_STATIONS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ASSIGNEE_STATIONS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REOPENS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REPLIES"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ASSIGNEE_UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REQUESTER_UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS_UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INITIALLY_ASSIGNED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ASSIGNED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SOLVED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LATEST_COMMENT_ADDED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REPLY_TIME_IN_MINUTES_CALENDAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REPLY_TIME_IN_MINUTES_BUSINESS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FIRST_RESOLUTION_TIME_IN_MINUTES_CALENDAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FIRST_RESOLUTION_TIME_IN_MINUTES_BUSINESS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FULL_RESOLUTION_TIME_IN_MINUTES_CALENDAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FULL_RESOLUTION_TIME_IN_MINUTES_BUSINESS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGENT_WAIT_TIME_IN_MINUTES_CALENDAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGENT_WAIT_TIME_IN_MINUTES_BUSINESS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REQUESTER_WAIT_TIME_IN_MINUTES_CALENDAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REQUESTER_WAIT_TIME_IN_MINUTES_BUSINESS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ON_HOLD_TIME_IN_MINUTES_CALENDAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ON_HOLD_TIME_IN_MINUTES_BUSINESS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CUSTOM_STATUS_UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
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
	type = "NUMBER(1,0)"
	nullable = true
}

}

