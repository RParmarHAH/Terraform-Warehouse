resource "snowflake_table" "DW_HAH_DIM_BILLCODE_TO_PAYCODE_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_BILLCODE_TO_PAYCODE_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_BILLCODE_TO_PAYCODE_MAPPING

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
	name = "SYSTEM_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BILL_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAY_CODE"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "PRIORTOJULY_PAYCODE"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "BILL_CODE_SOURCE_SYSTEM_ID"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "PAY_CODE_SOURCE_SYSTEM_ID"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "CLIENT_IN_COOK"
	type = "NUMBER(11,0)"
	nullable = true
}


column {
	name = "CLIENT_IN_CHICAGO"
	type = "NUMBER(10,0)"
	nullable = true
}

}

