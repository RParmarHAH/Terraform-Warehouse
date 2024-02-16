resource "snowflake_table" "DISC_DATA_CLEANSING_CLIENT_STANDARDIZED_ADDRESSES_CLONE_20231003" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	name = "CLIENT_STANDARDIZED_ADDRESSES_CLONE_20231003"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATA_CLEANSING.CLIENT_STANDARDIZED_ADDRESSES_CLONE_20231003

    -- Purpose : Discovery Data Population

    -- Project : DATA_CLEANSING

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "CLIENT_FIRST_NAME"
	type = "VARCHAR(100)"
	nullable = true
	comment = "First name of client"
}


column {
	name = "CLIENT_LAST_NAME"
	type = "VARCHAR(100)"
	nullable = true
	comment = "Last name of client"
}


column {
	name = "ADDRESS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "POINTS"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "LATITUDE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "LONGITUDE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "LABEL"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "ADDRESS_NUMBER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STREET"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "MUNICIPALITY"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "REGION"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "SUB_REGION"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "COUNTRY_CODE"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "ZIP_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ZIP_PLUS_FOUR"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RELEVANCE"
	type = "FLOAT"
	nullable = true
}

}

