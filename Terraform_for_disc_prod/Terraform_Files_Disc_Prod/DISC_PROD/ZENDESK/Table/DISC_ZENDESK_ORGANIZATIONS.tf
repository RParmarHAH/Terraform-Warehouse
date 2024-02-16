resource "snowflake_table" "DISC_ZENDESK_ORGANIZATIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ZENDESK"
	name = "ORGANIZATIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ZENDESK.ORGANIZATIONS

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
	name = "ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DETAILS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DOMAIN_NAMES"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXTERNAL_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "GROUP_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORGANIZATION_FIELDS_CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORGANIZATION_FIELDS_EMAIL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORGANIZATION_FIELDS_FAX"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORGANIZATION_FIELDS_LOCATION_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORGANIZATION_FIELDS_MANGER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORGANIZATION_FIELDS_OFFICE_ADDRESS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORGANIZATION_FIELDS_OFFICE_NUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORGANIZATION_FIELDS_PHONE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORGANIZATION_FIELDS_STATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORGANIZATION_FIELDS_TERRITORY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORGANIZATION_FIELDS_ZIP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SHARED_COMMENTS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SHARED_TICKETS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "TAGS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "URL"
	type = "VARCHAR(100)"
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
	type = "BOOLEAN"
	nullable = true
}

}

