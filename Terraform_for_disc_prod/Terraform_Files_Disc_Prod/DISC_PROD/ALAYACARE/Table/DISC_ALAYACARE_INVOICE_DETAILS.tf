resource "snowflake_table" "DISC_ALAYACARE_INVOICE_DETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "INVOICE_DETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.INVOICE_DETAILS

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
	name = "INVOICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYOR_PROGRAM_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_FUNDER_ID"
	type = "NUMBER(38,0)"
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
	name = "INVOICE_TYPE_TMP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_TRANS_MODEL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_DATEDIFF"
	type = "NUMBER(9,0)"
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
	name = "PAYOR_BTP_REFERENCE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PAYOR_CRN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_BALANCE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_BILL_TO"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_BILL_TO_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_BILLED_BY_HOUR"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_BILLED_BY_VISIT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_CLIENT_PREMIUMS_SUBTOTAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_FUNDER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_GUID_TO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_ID_BILLING_PERIOD"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_IDTERM"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_INCOME_ITEMS_SUBTOTAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_INVOICE_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_INVOICE_NUMBER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_INVOICE_VERSION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_INVOICING_MODEL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_IS_AD_HOC"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_MASTER_INVOICE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_MEMO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_PAYOR_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_SEND_TO"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_SEND_TO_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_SERVICE_PROVIDED_TO"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_SERVICE_PROVIDED_TO_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_SUBTOTAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_SUPPLIES_SUBTOTAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_TOTAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_TOTAL_CLIENT_PREMIUMS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_TOTAL_INCOME_ITEMS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_TOTAL_PREMIUMS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_TOTAL_SUPPLIES"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_TOTAL_VISITS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICE_VISITS_AND_PREMIUMS_SUBTOTAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "IS_DELETED"
	type = "NUMBER(1,0)"
	nullable = true
}

}

