resource "snowflake_table" "DW_HAH_DIM_ZIP_CODE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_ZIP_CODE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_ZIP_CODE

    -- Purpose : Business Data Population

    -- Project : HAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ZIP_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "LATITUDE"
	type = "NUMBER(10,7)"
	nullable = true
}


column {
	name = "LONGITUDE"
	type = "NUMBER(10,7)"
	nullable = true
}


column {
	name = "CITY_PRIMARY_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COUNTY_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE_NAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "STATE_ISO_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "STATE_ANSI_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "STATE_FIPS"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "COUNTRY_ISO_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "COUNTRY_COMMON_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COUNTRY_OFFICIAL_NAME"
	type = "VARCHAR(50)"
	nullable = true
}

}

