resource "snowflake_table" "DISC_ZENDESK_TICKET_CUSTOM_FIELDS_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ZENDESK"
	name = "TICKET_CUSTOM_FIELDS_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ZENDESK.TICKET_CUSTOM_FIELDS_MAPPING

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
	name = "TYPE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "RAW_TITLE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "RAW_DESCRIPTION"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "POSITION"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COLLAPSED_FOR_AGENTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REGEXP_FOR_VALIDATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TITLE_IN_PORTAL"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "RAW_TITLE_IN_PORTAL"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "VISIBLE_IN_PORTAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EDITABLE_IN_PORTAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REQUIRED_IN_PORTAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TAG"
	type = "VARCHAR(16777216)"
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
	name = "REMOVABLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "KEY"
	type = "VARIANT"
	nullable = true
}


column {
	name = "AGENT_DESCRIPTION"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "CUSTOM_FIELD_OPTIONS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "SYSTEM_FIELD_OPTIONS"
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

