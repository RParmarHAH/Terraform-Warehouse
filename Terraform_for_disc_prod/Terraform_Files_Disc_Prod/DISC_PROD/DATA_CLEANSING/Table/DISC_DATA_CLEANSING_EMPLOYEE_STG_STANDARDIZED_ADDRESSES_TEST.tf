resource "snowflake_table" "DISC_DATA_CLEANSING_EMPLOYEE_STG_STANDARDIZED_ADDRESSES_TEST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	name = "EMPLOYEE_STG_STANDARDIZED_ADDRESSES_TEST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATA_CLEANSING.EMPLOYEE_STG_STANDARDIZED_ADDRESSES_TEST

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
	type = "VARCHAR(16777216)"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = false
}


column {
	name = "EMPLOYEE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = false
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
	comment = "First name of employee"
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
	comment = "Last name of employee"
}


column {
	name = "ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
	comment = "Address"
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
	comment = "City"
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
	comment = "State"
}


column {
	name = "ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
	comment = "Zip (5 digits)"
}


column {
	name = "POINTS"
	type = "VARCHAR(16777216)"
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
	type = "VARCHAR(16777216)"
	nullable = true
	comment = "Address label which does not include the secondary unit designator"
}


column {
	name = "ADDRESS_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
	comment = "The street address number"
}


column {
	name = "STREET"
	type = "VARCHAR(16777216)"
	nullable = true
	comment = "Street address which includes the secondary unit designator"
}


column {
	name = "MUNICIPALITY"
	type = "VARCHAR(16777216)"
	nullable = true
	comment = "Municipality - several counties or geographies can make up a municipality"
}


column {
	name = "REGION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUB_REGION"
	type = "VARCHAR(16777216)"
	nullable = true
	comment = "County designation in 48 states except Alaska - boroughs or Louisiana - parishes or District of Columbia"
}


column {
	name = "COUNTRY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
	comment = "Country code - USA"
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
	comment = "5 digits ZIP code"
}


column {
	name = "PLUS_FOUR_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
	comment = "4 digits ZIP code extension"
}

}

