resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_PROFILE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "PROFILE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.PROFILE

    -- Purpose : Discovery Data Population

    -- Project : HEALTH_NAVIGATOR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "PERMISSIONSMODIFYALLDATA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PERMISSIONSVIEWALLDATA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PERMISSIONSVIEWSETUP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PERMISSIONSCUSTOMIZEAPPLICATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PERMISSIONSMANAGEUSERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(255)"
	nullable = true
}

}

