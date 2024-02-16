resource "snowflake_table" "DISC_PARADOX_MISSED_CANDIDATES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "MISSED_CANDIDATES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.MISSED_CANDIDATES

    -- Purpose : Discovery Data Population

    -- Project : PARADOX

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CANDIDATE_ID"
	type = "NUMBER(16,0)"
	nullable = true
}


column {
	name = "First Name"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "Middle Name"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "Last Name"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "Social Security Number"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "Date of Birth"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "Email"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "Time zone"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Address"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "Address Line 2"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "City"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "County"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "State"
	type = "VARCHAR(765)"
	nullable = true
}


column {
	name = "Zip Code"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "Branch (Group)"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "Branch STATE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "Phone"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "Home Phone"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "Gender"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "AlayaCare Group ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AlayaCare Cost Center ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "Position/Job"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AlayaCare Admin Role ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AlayaCare Field Role Portal ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HAH office number"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

