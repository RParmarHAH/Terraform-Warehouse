resource "snowflake_table" "DISC_ADI_AREA_DEPRIVATION_INDEX" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADI"
	name = "AREA_DEPRIVATION_INDEX"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ADI.AREA_DEPRIVATION_INDEX

    -- Purpose : Discovery Data Population

    -- Project : ADI

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ZIP_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "GISJOIN"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FIPS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADI_NATRANK"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ADI_STATERANK"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ZIP_TYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "LOAD_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LOAD_USER"
	type = "VARCHAR(100)"
	nullable = true
}

}

