resource "snowflake_table" "DISC_ZENDESK_TICKET_METRICS_EVENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ZENDESK"
	name = "TICKET_METRICS_EVENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ZENDESK.TICKET_METRICS_EVENT

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
	name = "TICKET_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "METRIC"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INSTANCE_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SLA_TARGET"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SLA_BUSINESS_HOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SLA_POLICY_ID"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "SLA_POLICY_TITLE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SLA_POLICY_DESCRIPTION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STATUS_BUSINESS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STATUS_CALENDAR"
	type = "NUMBER(10,0)"
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

