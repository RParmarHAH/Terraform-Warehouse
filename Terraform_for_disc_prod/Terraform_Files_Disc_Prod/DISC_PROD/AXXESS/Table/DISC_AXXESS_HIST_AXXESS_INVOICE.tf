resource "snowflake_table" "DISC_AXXESS_HIST_AXXESS_INVOICE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "HIST_AXXESS_INVOICE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.HIST_AXXESS_INVOICE

    -- Purpose : Discovery Data Population

    -- Project : AXXESS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "MRN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENTS_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_BILLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_UNITS"
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
	name = "BILL_CODE"
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
	name = "SOURCEFILE"
	type = "VARCHAR(25)"
	nullable = true
}

}

