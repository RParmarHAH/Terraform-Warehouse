resource "snowflake_table" "DW_HAH_DIM_COMPANY_STATE_NEW" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_COMPANY_STATE_NEW"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_COMPANY_STATE_NEW

    -- Purpose : Business Data Population

    -- Project : HAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "COMPANY_STATE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "COMPANY_STATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "COMPANY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "COMPANY_LEGAL_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COMPANY_COMMON_NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ACQUISITION_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PURCHASE_AGREEMENT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "TRANSACTION_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PRE_SALE_CLIENT_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TARGET_CLIENT_ACQUISITION_PCT"
	type = "NUMBER(5,2)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "FEIN"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "STATE_ISO_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PRE_SALE_EMP_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PARENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "LEGAL_STATE"
	type = "VARCHAR(100)"
	nullable = true
}

}

