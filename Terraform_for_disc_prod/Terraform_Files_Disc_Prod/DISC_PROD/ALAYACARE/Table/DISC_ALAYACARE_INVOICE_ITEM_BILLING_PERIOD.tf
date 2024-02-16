resource "snowflake_table" "DISC_ALAYACARE_INVOICE_ITEM_BILLING_PERIOD" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "INVOICE_ITEM_BILLING_PERIOD"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.INVOICE_ITEM_BILLING_PERIOD

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
	name = "INVOICE_ITEM_GUID_TO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_POSTING_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BILLINGPERIOD_ID"
	type = "NUMBER(38,0)"
	nullable = true
}

}

