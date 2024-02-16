resource "snowflake_table" "DW_HAH_DIM_COMPANY_STATE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_COMPANY_STATE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_COMPANY_STATE

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
	name = "COMPANY_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "COMPANY_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "COMPANY_LEGAL_NAME"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "COMPANY_COMMON_NAME"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "FEIN"
	type = "VARCHAR(15)"
	nullable = false
}


column {
	name = "STATE_ISO_CODE"
	type = "VARCHAR(2)"
	nullable = false
}


column {
	name = "CURRENT_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CURRENT_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAYROLL_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PREVIOUS_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PREVIOUS_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}

}

