resource "snowflake_table" "DISC_GPSYNCDATA_GPSYNC_EMPLOYEES_EMAIL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "GPSYNC_EMPLOYEES_EMAIL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.GPSYNC_EMPLOYEES_EMAIL

    -- Purpose : Discovery Data Population

    -- Project : GPSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Employee Number"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "First Name"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Last Name"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Home Telephone"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Office Telephone"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Company Email"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Home Email"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Original Hire Date"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Latest Hire Date"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Other Date"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Last Termination Date"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Termination Reason"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Status"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Executive Status"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Employment Status"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

