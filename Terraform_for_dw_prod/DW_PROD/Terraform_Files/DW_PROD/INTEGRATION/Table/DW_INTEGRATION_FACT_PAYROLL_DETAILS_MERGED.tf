resource "snowflake_table" "DW_INTEGRATION_FACT_PAYROLL_DETAILS_MERGED" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "FACT_PAYROLL_DETAILS_MERGED"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.FACT_PAYROLL_DETAILS_MERGED CLUSTER BY

    -- Purpose : Business Integration Data Population

    -- Project : INTEGRATION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PAYROLL_DETAIL_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "PAYROLL_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "REPORT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ORIGINAL_BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_ID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORIGINAL_BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORIGINAL_SYSTEM_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_PERIOD_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAY_PERIOD_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CHECK_NUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAY_CODE_DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_CODE_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_CODE_TYPE_DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_CODE_CATEGORY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NUMBER_OF_UNITS"
	type = "NUMBER(31,5)"
	nullable = true
}


column {
	name = "UNIT_TYPE_CODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "UNIT_TYPE_DESCRIPTION"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "RATE"
	type = "NUMBER(31,5)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(31,5)"
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
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
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
	nullable = false
}

}

