resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_AGENCY_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "AGENCY_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.AGENCY_MAPPING

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEPREFERRED

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AGENCYID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "INCLUDE_ALL_CONTRACTS"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "CONTRACTS_TO_INCLUDE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTRACTS_TO_EXCLUDE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INCLUDE_ALL_OFFICES"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "OFFICES_TO_INCLUDE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICES_TO_EXCLUDE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISACTIVE"
	type = "BOOLEAN"
	nullable = false
}

}

