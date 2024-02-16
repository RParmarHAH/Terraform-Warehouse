resource "snowflake_table" "DW_HAH_FACT_COMPANY_STATE_SYSTEM" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_COMPANY_STATE_SYSTEM"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_COMPANY_STATE_SYSTEM

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
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BUSINESS_KEY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COMPANY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "COMPANY_LEGAL_NAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "COMPANY_COMMON_NAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "FEIN"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "SYSTEM_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CURRENT_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LEGAL_STATE"
	type = "VARCHAR(100)"
	nullable = true
}

}

