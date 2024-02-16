resource "snowflake_table" "DISC_ALAYACARE_TBL_ACC_INVOICE_TIER_4" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "TBL_ACC_INVOICE_TIER_4"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.TBL_ACC_INVOICE_TIER_4

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
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "PROPERTIES_OP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_BALANCE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_BILL_TO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_BILL_TO_GUID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_BILLED_BY_HOUR"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_BILLED_BY_VISIT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_CLIENT_PREMIUMS_SUBTOTAL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_CREATE_TIME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_CREATE_USER_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDER_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_GUID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_GUID_TO"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_ID_BILLING_PERIOD"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_IDMASTERACCOUNT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_IDTERM"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_INCOME_ITEMS_SUBTOTAL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_NUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_VERSION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICING_MODEL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_IS_AD_HOC"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_MASTER_INVOICE_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_MEMO"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_PAYOR_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_SEND_TO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_SEND_TO_GUID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_SERVICE_PROVIDED_TO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_SERVICE_PROVIDED_TO_GUID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_STATUS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_SUBTOTAL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_SUPPLIES_SUBTOTAL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_TOTAL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_TOTAL_CLIENT_PREMIUMS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_TOTAL_INCOME_ITEMS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_TOTAL_PREMIUMS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_TOTAL_SUPPLIES"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_TOTAL_VISITS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_UPDATE_TIME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_AS_UPDATE_USER_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_VISITS_AND_PREMIUMS_SUBTOTAL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_ENTRY_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_PDF_URL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_DELETED_AT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_DELETED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_IS_DELETED"
	type = "VARCHAR(100)"
	nullable = true
}

}

