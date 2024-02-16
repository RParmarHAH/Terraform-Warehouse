resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_PERMISSIONSETLICENSE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "PERMISSIONSETLICENSE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.PERMISSIONSETLICENSE

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
	name = "STATUS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MASTERLABEL"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "DEVELOPERNAME"
	type = "VARCHAR(80)"
	nullable = true
}

}

