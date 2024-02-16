resource "snowflake_table" "DISC_AXXESS_AXXESS_INSURANCE_UNIT_TYPE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_INSURANCE_UNIT_TYPE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_INSURANCE_UNIT_TYPE

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
	name = "PRIMARY_INSURANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNIT"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

