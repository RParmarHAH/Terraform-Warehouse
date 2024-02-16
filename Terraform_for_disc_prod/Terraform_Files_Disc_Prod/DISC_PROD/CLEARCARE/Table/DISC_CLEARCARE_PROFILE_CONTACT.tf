resource "snowflake_table" "DISC_CLEARCARE_PROFILE_CONTACT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "PROFILE_CONTACT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.PROFILE_CONTACT

    -- Purpose : Discovery Data Population

    -- Project : CLEARCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "PROFILE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CONTACT_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RELATION_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ADDRESS_LINE_2"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PHONE_NUMBER_1"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PHONE_NUMBER_2"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "NOTE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "IS_PRIMARY_CONTACT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_EMERGENCY_CONTACT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_POA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DELETED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAST_UPDATED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ORIGINATOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "UPDATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FRANCHISOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(1)"
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

}

