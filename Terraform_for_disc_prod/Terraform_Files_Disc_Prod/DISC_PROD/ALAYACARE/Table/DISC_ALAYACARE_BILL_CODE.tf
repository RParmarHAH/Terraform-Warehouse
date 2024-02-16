resource "snowflake_table" "DISC_ALAYACARE_BILL_CODE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "BILL_CODE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.BILL_CODE

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
	name = "BILL_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "UNITPRICE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "UNITS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TAXABLE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FUNDER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IS_INTERNAL"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_USING"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "IS_DISABLED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DISABLED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISABLED_BY"
	type = "NUMBER(38,0)"
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
	name = "PROPERTIES_BILLING_INCREMENT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_GL_ASSET_ACC_ACCOUNT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IDFUNDER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_EXTERNAL_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_REVENUE_CODE_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IS_SERVICE_CODE_DEFAULT_FOR_FUNDER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ACTIVE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TAXABLE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_GL_REVENUE_ACC_ACCOUNT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_INCOMEACCOUNTREF"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_REVENUE_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IS_INTERNAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IS_DISABLED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_LOCATION_INDICATOR"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UNITPRICE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UNITS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_BILL_USING"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "GL_ASSET_ACC_ACCOUNT_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "GL_ASSET_ACC_ACCOUNT_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "GL_REVENUE_ACC_ACCOUNT_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "GL_REVENUE_ACC_ACCOUNT_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EXCLUDE_BILLING"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "LOCATION_INDICATOR"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BILLITEM_TAX_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BILLITEM_TAX_PERCENT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TOTAL_TAX"
	type = "NUMBER(17,4)"
	nullable = true
}


column {
	name = "BILLITEM_TAXABLE"
	type = "NUMBER(1,0)"
	nullable = true
}

}

