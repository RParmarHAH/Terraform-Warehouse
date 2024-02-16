resource "snowflake_table" "DISC_ALAYACARE_INVOICE_ITEM_TRANSACTION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "INVOICE_ITEM_TRANSACTION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.INVOICE_ITEM_TRANSACTION

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
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_TOTAL_CREDIT_AMOUNT"
	type = "NUMBER(25,2)"
	nullable = true
}


column {
	name = "INVOICE_LAST_CREDIT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVOICE_CREDIT_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_TOTAL_PAYMENT_AMOUNT"
	type = "NUMBER(25,2)"
	nullable = true
}


column {
	name = "INVOICE_LAST_PAYMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVOICE_LAST_CREATION_PAYMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVOICE_PAYMENT_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_ITEM_CREDIT_AMOUNT"
	type = "NUMBER(25,2)"
	nullable = true
}


column {
	name = "INVOICE_ITEM_LAST_CREDIT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVOICE_ITEM_CREDIT_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_ITEM_PAYMENT_AMOUNT"
	type = "NUMBER(25,2)"
	nullable = true
}


column {
	name = "INVOICE_ITEM_LAST_PAYMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVOICE_ITEM_LAST_CREATION_PAYMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVOICE_ITEM_PAYMENT_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}

}

