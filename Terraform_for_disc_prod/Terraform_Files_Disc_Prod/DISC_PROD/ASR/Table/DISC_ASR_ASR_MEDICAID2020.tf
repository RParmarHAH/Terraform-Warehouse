resource "snowflake_table" "DISC_ASR_ASR_MEDICAID2020" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "ASR_MEDICAID2020"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.ASR_MEDICAID2020

    -- Purpose : Discovery Data Population

    -- Project : ASR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLIENT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_BILLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS/UNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLED_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAID_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RA_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_MIDDLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_BILLED_CLEAN"
	type = "DATE"
	nullable = true
}


column {
	name = "HOURS/UNITS_CLEAN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICE_CLEAN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLED_AMOUNT_CLEAN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAID_AMOUNT_CLEAN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RA_DATE_CLEAN"
	type = "DATE"
	nullable = true
}


column {
	name = "SHEET_NAME"
	type = "VARCHAR(19)"
	nullable = true
}

}

