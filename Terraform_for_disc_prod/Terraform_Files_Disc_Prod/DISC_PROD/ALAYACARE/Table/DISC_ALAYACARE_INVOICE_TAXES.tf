resource "snowflake_table" "DISC_ALAYACARE_INVOICE_TAXES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "INVOICE_TAXES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.INVOICE_TAXES

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
	name = "INVOICE_ITEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TAX_NAME_1"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TAX_AMOUNT_1"
	type = "NUMBER(13,4)"
	nullable = true
}


column {
	name = "TAX_NAME_2"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TAX_AMOUNT_2"
	type = "NUMBER(13,4)"
	nullable = true
}


column {
	name = "TAX_NAME_3"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TAX_AMOUNT_3"
	type = "NUMBER(13,4)"
	nullable = true
}

}

