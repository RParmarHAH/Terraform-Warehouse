resource "snowflake_table" "DISC_ALAYACARE_ROLES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "ROLES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.ROLES

    -- Purpose : Discovery Data Population

    -- Project : ALAYACARE

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
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ASIGN_EMPLOYEE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ASSIGN_ACCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DETAILS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IDACCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PORTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SORT_ORDER"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

