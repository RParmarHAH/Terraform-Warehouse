resource "snowflake_table" "DISC_AXXESS_AXXESS_BRANCH_OFFICE_MAPPING_BKCP_10032023" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_BRANCH_OFFICE_MAPPING_BKCP_10032023"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_BRANCH_OFFICE_MAPPING_BKCP_10032023

    -- Purpose : Discovery Data Population

    -- Project : AXXESS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "BRANCH_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

