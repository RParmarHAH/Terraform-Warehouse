resource "snowflake_table" "DISC_PUBLIC_EMPLOYEE_STANDARDIZED_ADDRESSES_MITUL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "EMPLOYEE_STANDARDIZED_ADDRESSES_MITUL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.EMPLOYEE_STANDARDIZED_ADDRESSES_MITUL

    -- Purpose : Discovery Data Population

    -- Project : PUBLIC

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
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS"
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
	name = "ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POINTS"
	type = "VARCHAR(16777216)"
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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STREET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MUNICIPALITY"
	type = "VARCHAR(16777216)"
	nullable = true
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
}


column {
	name = "COUNTRY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PLUS_FOUR_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RELEVANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSERTED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

