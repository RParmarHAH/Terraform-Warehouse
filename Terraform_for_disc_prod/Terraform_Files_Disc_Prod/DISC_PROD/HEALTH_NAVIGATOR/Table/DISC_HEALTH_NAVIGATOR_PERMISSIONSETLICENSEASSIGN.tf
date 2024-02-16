resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_PERMISSIONSETLICENSEASSIGN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "PERMISSIONSETLICENSEASSIGN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.PERMISSIONSETLICENSEASSIGN

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
	name = "ASSIGNEEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "PERMISSIONSETLICENSEID"
	type = "VARCHAR(18)"
	nullable = true
}

}

