resource "snowflake_table" "DISC_DATA_CLEANSING_BRANCH_STANDARDIZED_ADDRESSES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	name = "BRANCH_STANDARDIZED_ADDRESSES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATA_CLEANSING.BRANCH_STANDARDIZED_ADDRESSES

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
	name = "OFFICE_NUMBER"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "OFFICE_CODE"
	type = "VARCHAR(100)"
	nullable = true
	comment = "First name of employee"
}


column {
	name = "OFFICE_NAME"
	type = "VARCHAR(100)"
	nullable = true
	comment = "Last name of employee"
}


column {
	name = "ADDRESS"
	type = "VARCHAR(1000)"
	nullable = true
	comment = "Address"
}


column {
	name = "CITY"
	type = "VARCHAR(500)"
	nullable = true
	comment = "City"
}


column {
	name = "STATE"
	type = "VARCHAR(100)"
	nullable = true
	comment = "State"
}


column {
	name = "ZIP"
	type = "VARCHAR(20)"
	nullable = true
	comment = "Zip (5 digits)"
}


column {
	name = "POINTS"
	type = "VARCHAR(256)"
	nullable = true
	comment = "[lat,long] format of the coordinates"
}


column {
	name = "LATITUDE"
	type = "FLOAT"
	nullable = true
	comment = "Latitude"
}


column {
	name = "LONGITUDE"
	type = "FLOAT"
	nullable = true
	comment = "Longitude"
}


column {
	name = "LABEL"
	type = "VARCHAR(256)"
	nullable = true
	comment = "Address label which does not include the secondary unit designator"
}


column {
	name = "ADDRESS_NUMBER"
	type = "VARCHAR(10)"
	nullable = true
	comment = "The street address number"
}


column {
	name = "STREET"
	type = "VARCHAR(256)"
	nullable = true
	comment = "Street address which includes the secondary unit designator"
}


column {
	name = "MUNICIPALITY"
	type = "VARCHAR(256)"
	nullable = true
	comment = "Municipality - several counties or geographies can make up a municipality"
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
	comment = "County designation in 48 states except Alaska - boroughs or Louisiana - parishes or District of Columbia"
}


column {
	name = "COUNTRY_CODE"
	type = "VARCHAR(256)"
	nullable = true
	comment = "Country code - USA"
}


column {
	name = "ZIP_CODE"
	type = "VARCHAR(20)"
	nullable = true
	comment = "5 digits ZIP code"
}


column {
	name = "ZIP_PLUS_FOUR"
	type = "VARCHAR(10)"
	nullable = true
	comment = "4 digits ZIP code extension"
}

}

