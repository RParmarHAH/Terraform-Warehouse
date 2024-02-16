resource "snowflake_table" "DISC_ALAYACARE_CONFIGURATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "CONFIGURATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.CONFIGURATION

    -- Purpose : Discovery Data Population

    -- Project : ALAYACARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "STATE"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "OFFICE_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "CONFIGURATION_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(100)"
	nullable = true
}

}

