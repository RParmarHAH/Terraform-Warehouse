resource "snowflake_table" "DISC_PUBLIC_TEST25" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "TEST25"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.TEST25

    -- Purpose : Discovery Data Population

    -- Project : PUBLIC

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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(16777216)"
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
	type = "VARCHAR(16777216)"
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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USE_CLOCKED_TIME"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "SPLIT_AT_MIDNIGHT"
	type = "NUMBER(1,0)"
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
	name = "PROPERTIES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "GL_ASSET_ACC_ACCOUNT_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GL_ASSET_ACC_ACCOUNT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GL_REVENUE_ACC_ACCOUNT_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GL_REVENUE_ACC_ACCOUNT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCLUDE_BILLING"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "LOCATION_INDICATOR"
	type = "VARCHAR(69)"
	nullable = true
}


column {
	name = "BILLITEM_TAX_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLITEM_TAX_PERCENT"
	type = "VARCHAR(16777216)"
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

