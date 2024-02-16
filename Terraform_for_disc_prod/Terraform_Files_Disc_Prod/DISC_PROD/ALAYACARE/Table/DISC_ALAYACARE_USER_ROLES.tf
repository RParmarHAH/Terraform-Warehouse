resource "snowflake_table" "DISC_ALAYACARE_USER_ROLES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "USER_ROLES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.USER_ROLES

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
	name = "ROLE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PERMISSION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ROLE_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ROLE_DETAILS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ROLE_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ROLE_PORTAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ROLE_ASSIGN_ACCOUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ROLE_ASSIGN_EMPLOYEE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ROLE_PERMISSIONS"
	type = "VARCHAR(250)"
	nullable = true
}

}

