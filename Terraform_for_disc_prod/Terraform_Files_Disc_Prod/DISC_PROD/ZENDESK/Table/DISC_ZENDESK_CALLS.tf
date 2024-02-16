resource "snowflake_table" "DISC_ZENDESK_CALLS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ZENDESK"
	name = "CALLS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ZENDESK.CALLS

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
	name = "AGENT_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "CALL_CHARGE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONSULTATION_TIME"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "COMPLETION_STATUS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CUSTOMER_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "CUSTOMER_REQUESTED_VOICEMAIL"
	type = "BOOLEAN"
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
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "OUTSIDE_BUSINESS_HOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PHONE_NUMBER_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "PHONE_NUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TICKET_ID"
	type = "NUMBER(15,0)"
	nullable = true
}


column {
	name = "TIME_TO_ANSWER"
	type = "NUMBER(9,0)"
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
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "IVR_TIME_SPENT"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "IVR_HOPS"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "IVR_DESTINATION_GROUP_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TALK_TIME"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "IVR_ROUTED_TO"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CALLBACK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALLBACK_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEFAULT_GROUP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IVR_ACTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LINE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LINE_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "LINE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVERFLOWED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OVERFLOWED_TO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDING_CONTROL_INTERACTIONS"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "RECORDING_TIME"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "NOT_RECORDING_TIME"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "CALL_RECORDING_CONSENT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CALL_RECORDING_CONSENT_ACTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALL_RECORDING_CONSENT_KEYPRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALL_GROUP_ID"
	type = "NUMBER(15,0)"
	nullable = true
}


column {
	name = "CALL_CHANNEL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "QUALITY_ISSUES"
	type = "VARIANT"
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

