resource "snowflake_table" "DISC_FINANCE_MCO_MANUAL_ADJUSTMENTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "FINANCE"
	name = "MCO_MANUAL_ADJUSTMENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.FINANCE.MCO_MANUAL_ADJUSTMENTS

    -- Purpose : Discovery Data Population

    -- Project : FINANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "STATE_NAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "YEAR"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "MONTH"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PAYOR_CATEGORY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "INCLUDE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MONTH_YEAR"
	type = "DATE"
	nullable = true
}


column {
	name = "CONTRACT_NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REVENUE_SUBCATEGORY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DISC_OPS_FLAG"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CARVE_OUT_FLAG"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(100)"
	nullable = true
}

}

