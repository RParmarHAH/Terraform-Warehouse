resource "snowflake_table" "DISC_GENERATIONSALLIANCE_LOCATION_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "LOCATION_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.LOCATION_MAPPING

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "LOCATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOLLFREEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_BRANCH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_BRANCH_CODE"
	type = "VARCHAR(255)"
	nullable = true
}

}

