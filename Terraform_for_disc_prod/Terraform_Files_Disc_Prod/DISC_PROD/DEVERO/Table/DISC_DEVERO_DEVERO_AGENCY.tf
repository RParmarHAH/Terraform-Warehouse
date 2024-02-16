resource "snowflake_table" "DISC_DEVERO_DEVERO_AGENCY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "DEVERO_AGENCY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DEVERO.DEVERO_AGENCY

    -- Purpose : Discovery Data Population

    -- Project : DEVERO

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AGENCY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLING_SYSTEM_AGENCY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INTERNAL_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISPLAY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_AGENCY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARE_PROVIDER_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAID_PROVIDER_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HHA_AGENCY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_HOSPICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMEZONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_MODIFIED"
	type = "VARCHAR(16777216)"
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
	type = "BOOLEAN"
	nullable = true
}

}

