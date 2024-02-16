resource "snowflake_table" "DW_STAGE_DOCEBO_MISSING_WD_EMPLOYEES" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "DOCEBO_MISSING_WD_EMPLOYEES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.DOCEBO_MISSING_WD_EMPLOYEES

    -- Purpose : Business Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PAY_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PAY_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAY_SS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "USERNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PASSWORD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LANGUAGE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "BUSINESS_UNIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOBTITLE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FIELD_OR_ADMIN"
	type = "VARCHAR(45)"
	nullable = true
}


column {
	name = "CAREGIVER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "LEVEL"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "HOURLY"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "FORCE_PASSWORD_CHANGE"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "TIMEZONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_PAYROLL_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BRANCH_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIRED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_SERVICE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INACTIVE_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "WORKDAY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}

}

