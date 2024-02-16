resource "snowflake_table" "DISC_ZENDESK_TICKETS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ZENDESK"
	name = "TICKETS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ZENDESK.TICKETS

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
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "ALLOW_ATTACHMENTS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "ALLOW_CHANNELBACK"
	type = "VARIANT"
	nullable = true
}


column {
	name = "ASSIGNEE_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "BRAND_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "COLLABORATOR_IDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOM_FIELDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DUE"
	type = "VARIANT"
	nullable = true
}


column {
	name = "EMAIL_CC_IDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "EXTERNAL_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "FIELDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "FOLLOWER_IDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "FOLLOWUP_IDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "FORUM_TOPIC_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "GROUP_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "HAS_INCIDENTS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "IS_PUBLIC"
	type = "VARIANT"
	nullable = true
}


column {
	name = "ORGANIZATION_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "PRIORITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROBLEM_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "RAW_SUBJECT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECIPIENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQUESTER_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "SATISFACTION_RATING"
	type = "VARIANT"
	nullable = true
}


column {
	name = "SHARING_AGREEMENT_IDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUBJECT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUBMITTER_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TAGS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_FORM_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATED_AT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "URL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VIA"
	type = "VARIANT"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(9,0)"
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

