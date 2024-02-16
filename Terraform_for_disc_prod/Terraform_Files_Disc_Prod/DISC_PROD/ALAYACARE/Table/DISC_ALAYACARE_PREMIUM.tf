resource "snowflake_table" "DISC_ALAYACARE_PREMIUM" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "PREMIUM"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.PREMIUM

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
	name = "PREMIUM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PREMIUM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREMIUM_CREATION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PREMIUM_REVISION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "GUID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PREMIUMS_OP"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PREMIUMS_CODE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PREMIUMS_CREATE_TIME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PREMIUMS_CREATE_USER_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PREMIUMS_GUID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PREMIUMS_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PREMIUMS_IDMASTERACCOUNT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PREMIUMS_PAY_CODE_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PREMIUMS_RULE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PREMIUMS_RULE_DATA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PREMIUMS_UPDATE_TIME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PREMIUMS_UPDATE_USER_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PREMIUM_PAY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREMIUM_PAY_CODE_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREMIUM_PAY_CODE_RATE"
	type = "FLOAT"
	nullable = true
}

}

