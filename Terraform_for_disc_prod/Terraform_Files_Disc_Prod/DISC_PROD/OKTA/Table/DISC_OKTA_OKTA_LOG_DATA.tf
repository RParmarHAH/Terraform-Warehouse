resource "snowflake_table" "DISC_OKTA_OKTA_LOG_DATA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "OKTA"
	name = "OKTA_LOG_DATA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.OKTA.OKTA_LOG_DATA

    -- Purpose : Discovery Data Population

    -- Project : OKTA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "LOG_EVENT_UUID"
	type = "VARCHAR(100)"
	nullable = false
	comment = "Unquie ID for this log event"
}


column {
	name = "PUBLISHED_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
	comment = "Okta Event Timestamp"
}


column {
	name = "EVENT_TYPE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "LOG_VERSION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SEVERITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DISPLAY_MESSAGE"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "ACTOR_NAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OUTCOME_RESULT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OUTCOME_REASON"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "TARGET_NAMES"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "TRANSACTION_ID"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TRANSACTION_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "IP_CHAIN"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "EXTERNAL_SESSION_ID"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "IMPORT_BATCH_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RAW_JSON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}

}

