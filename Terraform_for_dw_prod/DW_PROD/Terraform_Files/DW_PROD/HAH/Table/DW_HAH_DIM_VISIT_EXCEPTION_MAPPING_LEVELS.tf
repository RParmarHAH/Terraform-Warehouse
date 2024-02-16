resource "snowflake_table" "DW_HAH_DIM_VISIT_EXCEPTION_MAPPING_LEVELS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_VISIT_EXCEPTION_MAPPING_LEVELS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_VISIT_EXCEPTION_MAPPING_LEVELS

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
	name = "CATEGORY_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCEPTION_DESC_UPPER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LEVEL 1"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

