resource "snowflake_table" "DW_HAH_CONTRACT_MAPPING_BKCP_11032023" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "CONTRACT_MAPPING_BKCP_11032023"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.CONTRACT_MAPPING_BKCP_11032023

    -- Purpose : Business Data Population

    -- Project : HAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ORIGINAL_PARTNER_CONTRACT_SERVICE_KEY"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ORIGINAL_SYSTEM_CODE"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "ORIGINAL_CONTRACT_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORIGINAL_SERVICE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PARTNER_CONTRACT_SERVICE_KEY"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CONTRACT_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INSETED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSERTED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "KEY1"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "KEY2"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ORIGINAL_CONTRACT_KEY"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CONTRACT_KEY_1"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CONTRACT_KEY_2"
	type = "VARCHAR(1000)"
	nullable = true
}

}

