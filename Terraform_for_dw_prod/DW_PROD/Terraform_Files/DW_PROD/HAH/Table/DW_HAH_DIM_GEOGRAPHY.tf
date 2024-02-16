resource "snowflake_table" "DW_HAH_DIM_GEOGRAPHY" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_GEOGRAPHY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_GEOGRAPHY

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
	name = "ZIP_IS_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ZIP_TYPE_CODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ZIP_TYPE_DESCRIPTION"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CITY_PRIMARY_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CITY_TYPE_CODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CITY_TYPE_DESCRIPTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CITY_ACCEPTABLE_NAMES"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CITY_ACCEPTABLE_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "CITY_ACCEPTABLE_DESCRIPTION"
	type = "VARCHAR(75)"
	nullable = true
}


column {
	name = "CITY_UNACCEPTABLE_NAMES"
	type = "VARCHAR(2500)"
	nullable = true
}


column {
	name = "COUNTY_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COUNTY_ANSI_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "COUNTY_FIPS"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "IS_PRIMARY_COUNTY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MULTI_COUNTY_FLAG"
	type = "BOOLEAN"
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


column {
	name = "WORLD_REGION_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "WORLD_REGION_NAME"
	type = "VARCHAR(20)"
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
	name = "TIMEZONE_COMMON_NAME"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "TIMEZONE_IANA_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TIMEZONE_UTC_OFFSET"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DAYLIGHT_SAVINGS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POPULATION"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ELEVATION"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AREA_CODES"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CBSA_CODE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CBSA_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CBSA_TYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CBSA_DIVISION_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CBSA_DIVISION_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CSA_CODE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CSA_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MSA_CODE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MSA_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PMSA_CODE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PMSA_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "US_CENSUS_REGION"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "US_CENSUS_DIVISION"
	type = "VARCHAR(50)"
	nullable = true
}

}

