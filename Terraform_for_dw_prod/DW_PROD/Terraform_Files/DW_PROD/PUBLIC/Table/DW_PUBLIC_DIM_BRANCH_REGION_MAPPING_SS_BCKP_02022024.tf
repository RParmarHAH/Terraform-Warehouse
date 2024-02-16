resource "snowflake_table" "DW_PUBLIC_DIM_BRANCH_REGION_MAPPING_SS_BCKP_02022024" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "DIM_BRANCH_REGION_MAPPING_SS_BCKP_02022024"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.PUBLIC.DIM_BRANCH_REGION_MAPPING_SS_BCKP_02022024

    -- Purpose : 

    -- Project : PUBLIC

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "OFFICE_STATE_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "REGION_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OFFICE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}

}

