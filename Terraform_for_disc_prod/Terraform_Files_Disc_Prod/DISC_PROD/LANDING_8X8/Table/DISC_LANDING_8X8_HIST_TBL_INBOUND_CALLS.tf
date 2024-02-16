resource "snowflake_table" "DISC_LANDING_8X8_HIST_TBL_INBOUND_CALLS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "LANDING_8X8"
	name = "HIST_TBL_INBOUND_CALLS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.LANDING_8X8.HIST_TBL_INBOUND_CALLS

    -- Purpose : Discovery Data Population

    -- Project : LANDING_8X8

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

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
	name = "CALL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "START_TIME_UTC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "START_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CONNECT_TIME_UTC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONNECT_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCONNECTED_TIME_UTC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCONNECTED_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TALK_TIME_MS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TALK_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALLER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALLER_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALLEE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALLEE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALLER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MISSED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ABANDONED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ANSWERED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ANSWERED_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CALLEE_DISCONNECT_ON_HOLD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALLER_DISCONNECT_ON_HOLD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PBX_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SIP_CALL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_LEG_DISPOSITION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALL_LEG_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALL_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RING_DURATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ABANDONED_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALLEE_HOLD_DURATION_MS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALLEE_HOLD_DURATION"
	type = "TIME(9)"
	nullable = true
}


column {
	name = "WAIT_TIME_MS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WAIT_TIME"
	type = "VARCHAR(16777216)"
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
	name = "ETL_TASK_KEY"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "VARCHAR(6)"
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

}

