resource "snowflake_table" "DISC_ALAYACARE_FUNDER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "FUNDER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.FUNDER

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
	name = "FUNDER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROFILE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "GUID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICING_MODEL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "HOLIDAY_MULTIPLIER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TAX_CLASS_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CCAC_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CCAC_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MEDICAID_PAYER_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MEDICAID_PAYER_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MEDICAID_PROVIDER_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MEDICAID_PROVIDER_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MEDICAID_PROVIDER_TAX_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MEDICAID_PROVIDER_TAXONOMY_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MEDICAID_PAYER_ELECTRONIC_TRANSMITTER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MEDICAID_PROVIDER_ELECTRONIC_TRANSMITTER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MEDICAID_USE_BANK"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MEDICAID_CLAIM_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CCAC_CONTRACT_CODE"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROFILE_ADDRESS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_CITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_COUNTRY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PHONE_MAIN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_STATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ZIP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_BILLING_ADJUSTMENT_PERIOD"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CAN_USE_PAYPAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_GL_ASSET_ACC_ACCOUNT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_GL_BANK_ACC_ACCOUNT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_HOLIDAY_MULTIPLIER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IDPROFILE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INVOICING_MODEL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IS_DISABLED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}

}

