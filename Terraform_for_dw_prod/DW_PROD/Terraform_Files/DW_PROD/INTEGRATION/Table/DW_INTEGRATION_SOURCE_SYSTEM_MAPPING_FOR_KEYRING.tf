resource "snowflake_table" "DW_INTEGRATION_SOURCE_SYSTEM_MAPPING_FOR_KEYRING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "SOURCE_SYSTEM_MAPPING_FOR_KEYRING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.SOURCE_SYSTEM_MAPPING_FOR_KEYRING

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
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AMS_COST_CENTER_HIERARCHY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATION_HIERARCHY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEM_NAME"
	type = "VARCHAR(51)"
	nullable = true
}

}

