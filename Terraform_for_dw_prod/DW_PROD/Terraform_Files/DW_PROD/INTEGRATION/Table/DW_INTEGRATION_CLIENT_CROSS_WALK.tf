resource "snowflake_table" "DW_INTEGRATION_CLIENT_CROSS_WALK" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "CLIENT_CROSS_WALK"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.CLIENT_CROSS_WALK

    -- Purpose : Business Integration Data Population

    -- Project : INTEGRATION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AMS_CLIENT"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PAHW_CLIENT"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CENTENE_CLIENT"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "OSH_CLIENT"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "MOLINA_CLIENT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AMERIHEALTH_CLIENT"
	type = "VARCHAR(50)"
	nullable = true
}

}

