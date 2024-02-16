resource "snowflake_table" "DW_INTEGRATION_DATAFLEX_MATRIXCARE_CLIENT_MAPPING_IN_MI" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "DATAFLEX_MATRIXCARE_CLIENT_MAPPING_IN_MI"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.DATAFLEX_MATRIXCARE_CLIENT_MAPPING_IN_MI

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
	name = "MASTER_CLIENT_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}

}

