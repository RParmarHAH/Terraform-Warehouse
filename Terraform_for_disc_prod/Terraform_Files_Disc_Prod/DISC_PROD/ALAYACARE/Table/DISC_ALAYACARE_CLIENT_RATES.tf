resource "snowflake_table" "DISC_ALAYACARE_CLIENT_RATES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "CLIENT_RATES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.CLIENT_RATES

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
	name = "RATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BILL_CODE_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FUNDER_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BILLITEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_CODE_SPECIAL_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "IS_DISABLED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_CODE_ACTUAL_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_CODE_ACTUAL_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BILL_CODE_SPECIAL_RATE_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

