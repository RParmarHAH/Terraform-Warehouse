resource "snowflake_table" "DISC_ADP_QB_EMPLOYEES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADP"
	name = "QB_EMPLOYEES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ADP.QB_EMPLOYEES

    -- Purpose : Discovery Data Population

    -- Project : ADP

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "COMPANY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAIN_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SS_NO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MI"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAIN_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_OF_BIRTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STREET1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STREET2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BANK_ACCOUNT_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ABA_ROUTING_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MARITAL_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPENSATION_EFFECTIVE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIRE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_OF_LAST_CHECK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SALARY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_PERIOD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_SCHEDULE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLASS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKERS_COMP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EARNINGS_RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

