resource "snowflake_table" "DW_HAH_AMS_PARADOX_BRANCH_MAPPING_TEST_1" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "AMS_PARADOX_BRANCH_MAPPING_TEST_1"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.AMS_PARADOX_BRANCH_MAPPING_TEST_1

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
	name = "BRANCH_KEY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AMS_PARENT_SYSTEM_CODE"
	type = "VARCHAR(52)"
	nullable = true
}


column {
	name = "AMS_SYSTEM_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION__LEVEL_1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION__LEVEL_2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CANDIDATE_LOCATION__LEVEL_3"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORIGINAL_BRANCH_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OFFICE_STATE_CODE"
	type = "VARCHAR(50)"
	nullable = true
}

}

