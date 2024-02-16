resource "snowflake_table" "DISC_ALAYACARE_USER_RATES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "USER_RATES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.USER_RATES

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
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CUSTOM_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAY_CODE_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "RATE_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAY_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "RATE_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_USER_RATES_PAYROLL_ITEM_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_USER_RATES_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_USER_RATES_START_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_USER_RATES_RATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_USER_RATES_OVERRIDE_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_USER_RATES_EMPLOYEE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_USER_RATES_OP"
	type = "VARCHAR(250)"
	nullable = true
}

}

