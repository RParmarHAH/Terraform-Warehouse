resource "snowflake_table" "DW_REPORT_CALL_TICKET" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CALL_TICKET"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CALL_TICKET

    -- Purpose : Business Report Data Population

    -- Project : REPORT

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
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "TICKET_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "TICKET_ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(2,0)"
	nullable = true
}


column {
	name = "CALL_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CALL_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "CALL_AGENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CALLER_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CALL_AGENT_ID"
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
	name = "TICKET_GROUP_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "CALL_GROUP_TITLE"
	type = "VARCHAR(70)"
	nullable = true
}


column {
	name = "TICKET_GROUP_TITLE"
	type = "VARCHAR(70)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "OFFICE_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "CALL_CHARGE"
	type = "VARCHAR(70)"
	nullable = true
}


column {
	name = "CALL_COMPLETION_STATUS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CALL_DIRECTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CALL_DURATION"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "CALL_EXCEEDED_QUEUE_WAIT_TIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALL_HOLD_TIME"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "CALL_MINUTES_BILLED"
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
	name = "CALL_TIME_TO_ANSWER"
	type = "NUMBER(12,0)"
	nullable = true
}


column {
	name = "VOICEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALL_WAIT_TIME"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "CALL_WRAP_UP_TIME"
	type = "NUMBER(12,0)"
	nullable = true
}


column {
	name = "CALL_TALK_TIME"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "CALL_CONSULTATION_TIME"
	type = "NUMBER(12,0)"
	nullable = true
}


column {
	name = "CALL_OUTSIDE_BUSINESS_HOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALLBACK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALL_DEFAULT_GROUP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALL_LINE_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "CALL_LINE_TYPE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CALL_CHANNEL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CALL_QUALITY_ISSUES"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CALL_CREATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CALL_TIME_BRACKET"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CALL_UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ORGANIZATION_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TICKET_PRIORITY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "TICKET_STATUS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CALLER_TYPE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TICKET_PROBLEM_TYPE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TICKET_CASE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TICKET_VIA"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "TICKET_TYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TICKET_REQUESTER_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_SUBMITTER_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_WH_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CALL_WH_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "TICKET_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "TICKET_SUBMITTER_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "TICKET_ASSIGNEE_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_ASSIGNEE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TICKET_RECIPIENT"
	type = "VARCHAR(70)"
	nullable = true
}


column {
	name = "TICKET_SATISFACTION_RATING"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TICKET_IS_PUBLIC"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_SUBJECT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "TICKET_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TICKET_BRAND_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_COLLABORATOR_IDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_EMAIL_CC_IDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_EXTERNAL_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_FOLLOWER_IDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_FOLLOWUP_IDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_SHARING_AGREEMENT_IDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_FORM_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_FORM_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TICKET_URL"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "TICKET_CREATED_AT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TICKET_UPDATED_AT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TKT_METRICS_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "TICKET_FIRST_RESOLUTION_TIME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TICKET_REPLY_TIME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TICKET_FULL_RESOLUTION_TIME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TICKET_REQUESTER_WAIT_TIME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TICKET_ON_HOLD_TIME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TICKET_AGENT_WAIT_TIME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TICKET_REOPENS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TICKET_REPLIES"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TICKET_GROUP_STATIONS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TICKET_ASSIGNEE_STATIONS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TICKET_ASSIGNEE_UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TICKET_REQUESTER_UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TICKET_STATUS_UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TICKET_INITIALLY_ASSIGNED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TICKET_ASSIGNED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TICKET_SOLVED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TICKET_LATEST_COMMENT_ADDED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TICKET_CUSTOM_STATUS_UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "URL_TKT_METRICS"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "TICKET_EMPLOYEE_TYPE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TICKET_REQUESTER_NAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "TICKET_REQUESTER_PHONE_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TICKET_REQUESTER_PHONE_NUMBER_CALLMAX"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TICKET_REQUESTER_EMAIL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TICKET_CAREGIVER_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TICKET_CLIENT_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CALL_MAX_CALL_NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TICKET_RESOLUTION_COMMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TICKET_TOTAL_TIME_SPENT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TICKET_TIME_SPENT_LAST_UPDATE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SYSTEM"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MARKET"
	type = "VARCHAR(100)"
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
	name = "TICKET_ONLY"
	type = "BOOLEAN"
	nullable = true
}

}

