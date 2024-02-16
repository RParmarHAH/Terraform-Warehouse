resource "snowflake_table" "DISC_DEVERO_DEVERO_PHYSICIAN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "DEVERO_PHYSICIAN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DEVERO.DEVERO_PHYSICIAN

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
	name = "PHYSICIAN_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIDDLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_2"
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
	name = "EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPIN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NPI"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PECOS_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_CHECKED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROTOCOL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LICENSE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LICENSE_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LICENSE_EXPIRATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTERNAL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MYUNITY_AGENCY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTIVE"
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

