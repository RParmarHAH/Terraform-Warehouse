resource "snowflake_table" "DISC_ALAYACARE_ACCOUNTING_TRANSACTION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "ACCOUNTING_TRANSACTION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.ACCOUNTING_TRANSACTION

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
	name = "ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ALLOCATION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_INVOICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_INVOICE_ITEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_AMOUNT"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_BALANCE"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_FUNDER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_POSTING_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATION_DATE_TRANSACTION"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EMPLOYEE_CREATE_TRANSACTION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "UPDATION_DATE_TRANSACTION"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EMPLOYEE_UPDATE_TRANSACTION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_MEMO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MAIN_TRANSACTION_CONFIG_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MAIN_PAYMENT_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MAIN_PAYMENT_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ALLOC_TRANS_AMOUNT"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "ALLOC_TRANS_INVOICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ALLOC_TRANS_INVOICE_ITEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ALLOC_TRANSACTION_POSTING_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ALLOC_TRANS_CREATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ITEM_TRANS_LATEST_POSTING_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ITEM_TRANS_LATEST_CREATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVOICE_TRANS_LATEST_POSTING_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVOICE_TRANS_LATEST_CREATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ALLOCATED_AMOUNT"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "ALLOCATED_TRANS_BALANCE"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "ALLOCATED_TRANS_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ALLOCATED_TRANS_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PAYMENT_AMOUNT"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "CREDIT_AMOUNT"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "ALLOCATED_TRANS_DESC"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ALLOC_PAYMENT_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ALLOC_PAYMENT_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}

}

