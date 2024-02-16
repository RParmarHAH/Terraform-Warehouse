resource "snowflake_table" "DISC_TRUSTPOINTDATA_TRUSTPOINT_LOC_2" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "TRUSTPOINTDATA"
	name = "TRUSTPOINT_LOC_2"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.TRUSTPOINTDATA.TRUSTPOINT_LOC_2

    -- Purpose : Discovery Data Population

    -- Project : TRUSTPOINTDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "COMPANY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GP_1_COMPANY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALTERNATE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS2"
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
	name = "SETUP_IN_GP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SETUP_IN_COUPA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQUESTOR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_ASSIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMMENT_INITIALS"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

