resource "snowflake_table" "DW_REPORT_PAYROLL_EMPLOYEE_DERIVED_WEEKLY_METRICS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "PAYROLL_EMPLOYEE_DERIVED_WEEKLY_METRICS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.PAYROLL_EMPLOYEE_DERIVED_WEEKLY_METRICS

    -- Purpose : Business Report Data Population

    -- Project : REPORT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PAYROLL_WEEK"
	type = "DATE"
	nullable = true
}


column {
	name = "PAYROLL_WEEK_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
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
	name = "EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_PID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYROLL_ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMPLOYEE_CATEGORY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_CATEGORY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "EMPLOYEE_ETHNICITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BRANCH_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "FIRST_PAYROLL_WEEK"
	type = "DATE"
	nullable = true
}


column {
	name = "FIRST_PAYROLL_WEEK_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LAST_PAYROLL_WEEK"
	type = "DATE"
	nullable = true
}


column {
	name = "LAST_PAYROLL_WEEK_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "TENURE_IN_WEEKS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_WEEKS_WITH_PAYROLL"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_WEEKS_WITHOUT_PAYROLL"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_GAPS_IN_PAYROLL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SMALLEST_GAP_IN_PAYROLL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LARGEST_GAP_IN_PAYROLL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PREVIOUS_PAYROLL_WEEK"
	type = "DATE"
	nullable = true
}


column {
	name = "NEXT_PAYROLL_WEEK"
	type = "DATE"
	nullable = true
}


column {
	name = "TOTAL_HOURS_PAID"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "PREVIOUS_WEEK_TOTAL_HOURS_PAID"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "PREVIOUS_2_WEEK_TOTAL_HOURS_PAID"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "NEXT_WEEK_TOTAL_HOURS_PAID"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "NEXT_2_WEEK_TOTAL_HOURS_PAID"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "BILLABLE_HOURS"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "TRAINING_HOURS_UNITS"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "ACTIVE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OT"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "UNION_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXEMPT_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ACQUIRED_SYSTEM_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
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
	type = "NUMBER(1,0)"
	nullable = true
}

}

