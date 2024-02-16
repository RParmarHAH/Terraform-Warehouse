resource "snowflake_table" "DISC_ALAYACARE_CLAIMS_V1" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "CLAIMS_V1"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.CLAIMS_V1

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
	name = "CLAIM_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILLCODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FUNDER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISIT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INVOICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INTERNAL_CLAIM_NUMBER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INTERNAL_CLAIM_CONTROL_NUMBER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLAIM_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "IS_PREPARING"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IS_OPEN"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IS_MARKED_FOR_SUBMISSION"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "UPDATE_FLOW"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICED_AT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELAY_REASON_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "DENIAL_REASON"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "QUANTITY"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "BALANCE"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "DUE"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "PAID"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "CURRENT_STATUS_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BANKING_BALANCE"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "BANK_USED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BANK_AMOUNT"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "INVOICE_ITEM_QTY"
	type = "NUMBER(13,2)"
	nullable = true
}

}

