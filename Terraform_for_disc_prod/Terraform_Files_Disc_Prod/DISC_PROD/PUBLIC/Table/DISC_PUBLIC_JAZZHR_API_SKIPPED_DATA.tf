resource "snowflake_table" "DISC_PUBLIC_JAZZHR_API_SKIPPED_DATA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "JAZZHR_API_SKIPPED_DATA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.JAZZHR_API_SKIPPED_DATA

    -- Purpose : Discovery Data Population

    -- Project : PUBLIC

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "FROM_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "TO_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "API_URL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UTC_INSERTED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RERUN"
	type = "BOOLEAN"
	nullable = true
}

}

