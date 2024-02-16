resource "snowflake_table" "DISC_APTITIVE_DEV_MATCHING_OR_DISTINCT_RECORDS_NEW" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "APTITIVE_DEV"
	name = "MATCHING_OR_DISTINCT_RECORDS_NEW"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.APTITIVE_DEV.MATCHING_OR_DISTINCT_RECORDS_NEW

    -- Purpose : Discovery Data Population

    -- Project : APTITIVE_DEV

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "A_MATCH_OR_DISTINCT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "A_MATCH_SET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "A_RECORD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "A_FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "A_LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "A_ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "A_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "A_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "A_ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "A_PHONENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "A_SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "B_MATCH_OR_DISTINCT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "B_MATCH_SET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "B_RECORD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "B_FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "B_LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "B_ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "B_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "B_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "B_ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "B_PHONENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "B_SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

