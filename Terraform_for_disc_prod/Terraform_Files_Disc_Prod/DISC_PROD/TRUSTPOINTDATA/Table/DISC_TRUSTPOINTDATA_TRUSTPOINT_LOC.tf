resource "snowflake_table" "DISC_TRUSTPOINTDATA_TRUSTPOINT_LOC" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "TRUSTPOINTDATA"
	name = "TRUSTPOINT_LOC"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.TRUSTPOINTDATA.TRUSTPOINT_LOC

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
	name = "COST_FULL_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LEVEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COST_ABBR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHILDREN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESCENDENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FULL_ABBR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTERNAL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COST_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NAME_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NAME_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ABBREV_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ABBREV_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTERNAL_ID_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTERNAL_ID_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESCRIPTION_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_FULL_PATH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_EXTERNAL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_ADDRESS_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_ADDRESS_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

