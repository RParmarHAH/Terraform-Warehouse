resource "snowflake_table" "DISC_VIVENTIUM_BRANCHES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "VIVENTIUM"
	name = "BRANCHES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.VIVENTIUM.BRANCHES

    -- Purpose : Discovery Data Population

    -- Project : VIVENTIUM

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "COMPANYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIVISIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPANYLEGALNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

