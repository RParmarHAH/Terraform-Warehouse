resource "snowflake_table" "DISC_PUBLIC_BILL_RATE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "BILL_RATE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.BILL_RATE

    -- Purpose : Discovery Data Population

    -- Project : PUBLIC

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "BILL_RATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_RATE_GUID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RATE"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "UNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DEFAULT_RATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EXTERNAL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TO_DATE_TMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TO_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

