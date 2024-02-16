resource "snowflake_table" "DISC_ALAYACARE_INVOICE_ITEM" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "INVOICE_ITEM"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.INVOICE_ITEM

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
	name = "INVOICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ITEM_GUID_TO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PREMIUM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FACILITY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FUNDER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ITEM_BILLITEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILLITEM_ID_PREMIUM"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_ADJUSTMENT_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_BILLABLE_ITEM_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_GL_ASSET_ACC_ACCOUNT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_GL_REVENUE_ACC_ACCOUNT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_IDDEPTCODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_IDINVOICE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_ITEM_END_AT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_ITEM_START_AT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_ORIGIN_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_QUANTITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_QUANTITY_UNITS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_SUBTOTAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_TAXABLE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_TOTAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_UNITPRICE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_ACC_INVOICE_ITEM_FROZEN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_BILLABLE_ITEMS_FROZEN_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_BILLABLE_ITEMS_FROZEN_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_BILLABLE_ITEMS_FROZEN_SHIFT_ENCODED"
	type = "VARCHAR(16777216)"
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


column {
	name = "PAYOR_PROGRAM_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PAYOR_PROGRAM_FUNDER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYOR_PROGRAM_BILLING_CONTACT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MASTER_INVOICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MASTER_INVOICE_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_NUMBER_VERSION"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVOICE_REGENERATED"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "INVOICE_AGING_RANGE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "DATEDIFF_RANGE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_AMOUNT"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "INVOICE_ITEM_AMOUNT"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "TOTAL_CREDIT_AMOUNT"
	type = "NUMBER(25,2)"
	nullable = true
}


column {
	name = "TOTAL_PAYMENT_AMOUNT"
	type = "NUMBER(25,2)"
	nullable = true
}


column {
	name = "PAYMENT_AMOUNT_TMP"
	type = "NUMBER(25,2)"
	nullable = true
}


column {
	name = "PAYMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYMENT_CREATION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREDIT_AMOUNT_TMP"
	type = "NUMBER(25,2)"
	nullable = true
}


column {
	name = "PAYMENT_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CREDIT_TYPE"
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
	name = "INVOICE_ITEM_BALANCE"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "INVOICE_ITEM_QTY"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "PAYAMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "MARGIN"
	type = "FLOAT"
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

}

