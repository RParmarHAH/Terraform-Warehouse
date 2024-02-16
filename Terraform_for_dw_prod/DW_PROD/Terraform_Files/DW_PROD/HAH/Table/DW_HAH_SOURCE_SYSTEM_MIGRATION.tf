resource "snowflake_table" "DW_HAH_SOURCE_SYSTEM_MIGRATION" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "SOURCE_SYSTEM_MIGRATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.SOURCE_SYSTEM_MIGRATION

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
	name = "SOURCE_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYSTEM_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENT_SOURCE_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENT_SOURCE_SYSTEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENT_SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

