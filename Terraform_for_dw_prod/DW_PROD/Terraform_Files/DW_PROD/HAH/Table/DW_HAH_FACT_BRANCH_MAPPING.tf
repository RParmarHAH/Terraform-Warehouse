resource "snowflake_table" "DW_HAH_FACT_BRANCH_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_BRANCH_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_BRANCH_MAPPING

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
	name = "OLD_SYSTEM_BRANCH_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OLD_BRANCH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OLD_SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OLD_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NEW_SYSTEM_BRANCH_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NEW_BRANCH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NEW_SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NEW_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAYER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CONSOLIDATE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "IS_HISTORY"
	type = "BOOLEAN"
	nullable = true
}

}

