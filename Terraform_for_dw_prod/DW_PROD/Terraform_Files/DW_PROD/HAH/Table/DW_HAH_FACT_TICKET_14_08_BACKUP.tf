resource "snowflake_table" "DW_HAH_FACT_TICKET_14_08_BACKUP" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_TICKET_14_08_BACKUP"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_TICKET_14_08_BACKUP

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
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "TICKET_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(2,0)"
	nullable = true
}


column {
	name = "VIA"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PRIORITY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "REQUESTER_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "SUBMITTER_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "WH_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SUBMITTER_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ASSIGNEE_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "ASSIGNEE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RECIPIENT"
	type = "VARCHAR(70)"
	nullable = true
}


column {
	name = "SATISFACTION_RATING"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "IS_PUBLIC"
	type = "VARIANT"
	nullable = true
}


column {
	name = "SUBJECT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORGANIZATION_ID"
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
	name = "GROUP_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "GROUP_TITLE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "GROUP_DESCRIPTION"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SHARING_AGREEMENT_IDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TICKET_FORM_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "URL"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_AT"
	type = "VARCHAR(100)"
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

