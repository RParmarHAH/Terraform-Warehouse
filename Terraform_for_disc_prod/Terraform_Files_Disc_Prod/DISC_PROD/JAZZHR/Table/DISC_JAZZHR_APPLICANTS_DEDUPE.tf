resource "snowflake_table" "DISC_JAZZHR_APPLICANTS_DEDUPE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "JAZZHR"
	name = "APPLICANTS_DEDUPE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.JAZZHR.APPLICANTS_DEDUPE

    -- Purpose : Discovery Data Population

    -- Project : JAZZHR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

