resource "snowflake_table" "DW_STAGE_PREFERRED_DIM_CONTRACT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "PREFERRED_DIM_CONTRACT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.PREFERRED_DIM_CONTRACT

    -- Purpose : Business Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "CONTRACT_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICE_CODE_ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "DEFAULT_BILL_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYROLL_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REVENUE_SUBCATEGORY_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REVENUE_SUBCATEGORY_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYOR_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYOR_DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICE_LINE_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICE_LINE_DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONTRACT_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "TIME_TRANSLATION_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TIME_TRANSLATION_DIVIDER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_TRAVELS_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MILEAGE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYABLE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLABLE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLED_BY_QUARTER_HOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLED_BY_HALF_HOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILL_UNIT_TYPE"
	type = "VARCHAR(20)"
	nullable = true
	comment = "Time Based Visit Identifier - Possible Values are V, D, H"
}


column {
	name = "EFFECTIVE_FROM_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "EFFECTIVE_TO_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

