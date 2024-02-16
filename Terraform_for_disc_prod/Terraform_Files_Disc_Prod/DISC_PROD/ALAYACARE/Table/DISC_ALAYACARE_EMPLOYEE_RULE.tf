resource "snowflake_table" "DISC_ALAYACARE_EMPLOYEE_RULE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "EMPLOYEE_RULE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.EMPLOYEE_RULE

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
	name = "RULE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "START_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "END_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "DURATION_PAID"
	type = "FLOAT"
	nullable = true
}


column {
	name = "RRULE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TIMEOFF_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "DAYDIFF"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_EMAIL"
	type = "VARCHAR(250)"
	nullable = true
}

}

