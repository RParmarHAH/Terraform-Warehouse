resource "snowflake_table" "DISC_AMERIHEALTH_AMERIHEALTH_SOURCE_DATA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AMERIHEALTH"
	name = "AMERIHEALTH_SOURCE_DATA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AMERIHEALTH.AMERIHEALTH_SOURCE_DATA

    -- Purpose : Discovery Data Population

    -- Project : AMERIHEALTH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PARTNER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTERNAL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIDDLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_OF_BIRTH"
	type = "DATE"
	nullable = true
}


column {
	name = "STREET_ADDRESS"
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
	name = "ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIP_CODE_EXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAID_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL_ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARTNER_FILENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOADDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FILENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

