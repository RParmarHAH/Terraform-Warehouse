resource "snowflake_table" "DW_STAGE_ZENDESK_FACT_SLA" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "ZENDESK_FACT_SLA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.ZENDESK_FACT_SLA

    -- Purpose : Business Data Population

    -- Project : STAGE

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
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "TICKET_SLA_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(2,0)"
	nullable = true
}


column {
	name = "TICKET_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "TICKET_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "WH_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PRIORITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "METRIC"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SLA_TARGET"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "SLA_POLICY_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "SLA_POLICY_TITLE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SLA_POLICY_DESCRIPTION"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "REPLY_TIME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FULL_RESOLUTION_TIME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REQUESTER_WAIT_TIME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGENT_WAIT_TIME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGENT_WORK_TIME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SLA_TARGET_ACHIEVED"
	type = "BOOLEAN"
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


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

