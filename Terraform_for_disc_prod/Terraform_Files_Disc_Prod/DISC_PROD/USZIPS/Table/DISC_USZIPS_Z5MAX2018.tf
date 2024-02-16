resource "snowflake_table" "DISC_USZIPS_Z5MAX2018" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "USZIPS"
	name = "Z5MAX2018"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.USZIPS.Z5MAX2018

    -- Purpose : Discovery Data Population

    -- Project : USZIPS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CITY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ST"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "ZIP"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "AC"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIPS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PREF"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TZ"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DST"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LAT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "LONG"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "MSA"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PMSA"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ABBREVIATION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MA"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CBSA"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DIV"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POPULATION"
	type = "NUMBER(28,0)"
	nullable = true
}

}

