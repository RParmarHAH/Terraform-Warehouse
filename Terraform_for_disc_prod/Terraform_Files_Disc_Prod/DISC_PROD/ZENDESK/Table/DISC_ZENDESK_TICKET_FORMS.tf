resource "snowflake_table" "DISC_ZENDESK_TICKET_FORMS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ZENDESK"
	name = "TICKET_FORMS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ZENDESK.TICKET_FORMS

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
	name = "URL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FORM_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DISPLAY_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "RAW_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "RAW_DISPLAY_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "END_USER_VISIBLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POSITION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "TICKET_FIELD_IDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEFAULT"
	type = "BOOLEAN"
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
	name = "IN_ALL_BRANDS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RESTRICTED_BRAND_IDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "END_USER_CONDITIONS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "AGENT_CONDITIONS"
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

