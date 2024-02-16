resource "snowflake_table" "DISC_STAGE_WORKDAY_LOCATION_LIST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "WORKDAY_LOCATION_LIST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.STAGE.WORKDAY_LOCATION_LIST

    -- Purpose : Discovery Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "OFFICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNKNOWN"
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
	name = "POSTAL_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

