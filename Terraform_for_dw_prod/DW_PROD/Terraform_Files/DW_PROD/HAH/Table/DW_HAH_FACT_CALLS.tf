resource "snowflake_table" "DW_HAH_FACT_CALLS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_CALLS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_CALLS

    -- Purpose : Business Data Population

    -- Project : HAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "CALL_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CALL_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(2,0)"
	nullable = true
}


column {
	name = "AGENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CALLER_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "TICKET_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "TICKET_ID"
	type = "NUMBER(15,0)"
	nullable = true
}


column {
	name = "AGENT_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "CALLER_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "CALL_GROUP_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "GROUP_TITLE"
	type = "VARCHAR(70)"
	nullable = true
}


column {
	name = "GROUP_DESCRIPTION"
	type = "VARCHAR(700)"
	nullable = true
}


column {
	name = "ORGANIZATION_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "OFFICE_STATE_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CALL_CHARGE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COMPLETION_STATUS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DIRECTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DURATION"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "EXCEEDED_QUEUE_WAIT_TIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOLD_TIME"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "MINUTES_BILLED"
	type = "NUMBER(12,0)"
	nullable = true
}


column {
	name = "PHONE_NUMBER_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "PHONE_NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TIME_TO_ANSWER"
	type = "NUMBER(12,0)"
	nullable = true
}


column {
	name = "VOICEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WAIT_TIME"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "WRAP_UP_TIME"
	type = "NUMBER(12,0)"
	nullable = true
}


column {
	name = "TALK_TIME"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "CONSULTATION_TIME"
	type = "NUMBER(12,0)"
	nullable = true
}


column {
	name = "OUTSIDE_BUSINESS_HOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALLBACK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEFAULT_GROUP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LINE_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "LINE_TYPE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CALL_CHANNEL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "QUALITY_ISSUES"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIME_BRACKET"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DNIS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AA_DESTINATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALL_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CALL_START_TIME"
	type = "TIME(9)"
	nullable = true
}


column {
	name = "CALL_DISCONNECTED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CALL_DISCONNECTED_TIME"
	type = "TIME(9)"
	nullable = true
}


column {
	name = "CALLEE_DISCONNECT_ON_HOLD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALLER_DISCONNECT_ON_HOLD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALL_ANSWERED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CALL_ANSWERED_TIME"
	type = "TIME(9)"
	nullable = true
}


column {
	name = "CALL_LEG_COUNT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "RING_DURATION"
	type = "TIME(9)"
	nullable = true
}


column {
	name = "ABANDONED_TIME"
	type = "TIME(9)"
	nullable = true
}


column {
	name = "DEPARTMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCHES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALLER_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALLEE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WH_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
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

