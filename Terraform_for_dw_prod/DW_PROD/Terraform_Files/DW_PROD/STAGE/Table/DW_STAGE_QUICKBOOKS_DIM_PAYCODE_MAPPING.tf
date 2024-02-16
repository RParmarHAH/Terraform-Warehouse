resource "snowflake_table" "DW_STAGE_QUICKBOOKS_DIM_PAYCODE_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "QUICKBOOKS_DIM_PAYCODE_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.QUICKBOOKS_DIM_PAYCODE_MAPPING

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
	name = "PAYCODE_MAPPING_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(2,0)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_CODE_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_CODE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_CODE_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FINANCE_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REVENUE_SUBCATEGORY_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REVENUE_SUBCATEGORY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_USED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "MOST_RECENT_USED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "NUMBER_EMPLOYEES_USED"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "ACTIVE_FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMIN_PAY_RATE_FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIELD_PAY_RATE_FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INCLUDE_SALARY_PAYRATE_CALC_FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INCLUDE_FULL_TIME_HOURS_CALC_FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

