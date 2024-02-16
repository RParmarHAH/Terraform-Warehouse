resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_HAH_PROFILE_LIST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "HAH_PROFILE_LIST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.HAH_PROFILE_LIST

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOSHAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PROFILE_TYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LEGACY_AMS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LEGACY_AMS_IDENTIFIER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NEW_AMS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NEW_AMS_IDENTIFIER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ISEXCLUDE"
	type = "BOOLEAN"
	nullable = true
}

}

