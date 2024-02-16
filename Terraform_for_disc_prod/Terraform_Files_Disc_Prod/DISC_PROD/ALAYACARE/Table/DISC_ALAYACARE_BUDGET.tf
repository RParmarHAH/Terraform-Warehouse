resource "snowflake_table" "DISC_ALAYACARE_BUDGET" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "BUDGET"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.BUDGET

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
	name = "BUDGET_ITEM_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BUDGET_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BUDGET_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BUDGET_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BUDGET_IS_DISABLE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BUDGET_ITEM_START_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BUDGET_ITEM_END_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BUDGET_START_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BUDGET_END_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BUDGET_CREATION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BUDGET_REVISION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CONTACT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_CREATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_UPDATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILLITEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FUNDER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PREMIUM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CATALOGUEITEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BUDGET_ITEM_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BUDGET_ITEM_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BUDGET_ITEM_CATEGORY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INCOME_CODE_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BUDGET_ITEM_CONTIGENCY"
	type = "NUMBER(11,2)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "CONTIGENCY_AMOUNT"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "BUDGET_CONTIGENCY_AMOUNT"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "CUSTOM_BUDGET_ITEM_RATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BUDGET_ITEM_RATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BUDGET_ITEM_UNIT"
	type = "VARCHAR(250)"
	nullable = true
}

}

