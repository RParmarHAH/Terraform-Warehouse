resource "snowflake_table" "DISC_ALAYACARE_GUID_PREMIUM" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "GUID_PREMIUM"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.GUID_PREMIUM

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
	type = "VARIANT"
	nullable = true
}


column {
	name = "PREMIUM_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "PREMIUM_CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "GUID_TO"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GUID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FUNDING_METHODOLOGY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEFAULT_RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_READ_ONLY"
	type = "VARIANT"
	nullable = true
}


column {
	name = "START_AT"
	type = "DATE"
	nullable = true
}


column {
	name = "END_AT"
	type = "DATE"
	nullable = true
}


column {
	name = "OVERRIDE_QUANTITY"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "OVERRIDE_RATE"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "FREQUENCY_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FREQUENCY_REPEAT_EVERY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FREQUENCY_DAY_OF_MONTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATION_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "BILLABLE_WHEN_CLIENT_ON_HOLD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BUDGET_PREMIUM_ITEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BUDGET_ITEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BUDGET_ITEM_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_PREMIUM_BUDGET"
	type = "VARIANT"
	nullable = true
}


column {
	name = "OP"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "APPLY_DATE"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "CREATE_TIME"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "CREATE_USER_ID"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "DESCRIPTION_GUID_PREMIUM"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "GUID_GUID_PREMIUM"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "GUID_TO_GUID_PREMIUM"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "IDMASTERACCOUNT"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "PREMIUM_ID_GUID_PREMIUM"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "QUINTITY"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "RATE"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "UPDATE_TIME"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "UPDATE_USER_ID"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "OP_PREMIUM_RULE"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "CREATION_DATE_PREMIUM_RULE"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "DESCRIPTION_PREMIUM_RULE"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "DISABLED_PREMIUM_RULE"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "DURATION_PREMIUM_RULE"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "END_AT_PREMIUM_RULE"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "GUID_PREMIUM_RULE"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "GUID_TO_PREMIUM_RULE"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "ID_PREMIUM_RULE"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "IDMASTERACCOUNT_PREMIUM_RULE"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "RRULE_PREMIUM_RULE"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "START_AT_PREMIUM_RULE"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "TYPE_PREMIUM_RULE"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "UPDATE_TIME_PREMIUM_RULE"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "BILLITEM_ID_PREMIUM"
	type = "VARIANT"
	nullable = true
}


column {
	name = "BILLITEM_ID_FUNDER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}

}

