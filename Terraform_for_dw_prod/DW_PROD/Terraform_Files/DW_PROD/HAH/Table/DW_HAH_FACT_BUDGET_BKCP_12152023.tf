resource "snowflake_table" "DW_HAH_FACT_BUDGET_BKCP_12152023" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_BUDGET_BKCP_12152023"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_BUDGET_BKCP_12152023

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
	name = "BUDGET_KEY"
	type = "VARCHAR(32)"
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
	name = "CALENDAR_DATE"
	type = "DATE"
	nullable = false
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OFFICE_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OFFICE_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "SERVICE_LINE_CODE"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "YEAR_MONTH"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "CLIENT_COUNT_BUDGETED_DAILY"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "CLIENT_COUNT_BUDGETED_MONTHLY"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "CLIENT_COUNT_BUDGETED_MONTHLY_ROLLING_TOTAL"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "HOURS_BUDGETED_DAILY"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "HOURS_BUDGETED_MONTHLY"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "HOURS_BUDGETED_MONTHLY_ROLLING_TOTAL"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "REVENUE_BUDGETED_DAILY"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "REVENUE_BUDGETED_MONTHLY"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "REVENUE_BUDGETED_MONTHLY_ROLLING_TOTAL"
	type = "NUMBER(15,3)"
	nullable = true
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
	name = "CAREGIVER_COUNT_BUDGETED_DAILY"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "CAREGIVER_COUNT_BUDGETED_MONTHLY"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "CAREGIVER_COUNT_BUDGETED_MONTHLY_ROLLING_TOTAL"
	type = "NUMBER(15,3)"
	nullable = true
}

}

