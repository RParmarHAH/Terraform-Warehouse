resource "snowflake_table" "DISC_ALAYACARE_CLAIMS_TRANSACTION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "CLAIMS_TRANSACTION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.CLAIMS_TRANSACTION

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
	name = "MAIN_TRANSACTION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_POSTING_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAYMENT_METHOD_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_AMOUNT"
	type = "NUMBER(20,4)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_MEMO"
	type = "VARCHAR(2500)"
	nullable = true
}

}

