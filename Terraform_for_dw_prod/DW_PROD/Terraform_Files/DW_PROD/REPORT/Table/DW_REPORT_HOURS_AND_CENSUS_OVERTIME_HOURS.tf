resource "snowflake_table" "DW_REPORT_HOURS_AND_CENSUS_OVERTIME_HOURS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "HOURS_AND_CENSUS_OVERTIME_HOURS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.HOURS_AND_CENSUS_OVERTIME_HOURS

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
	name = "PAYROLL_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "MONTH_BEGIN_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "MONTH_DISPLAY_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OFFICE_NUMBER"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SERVICE_HOURS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "OVERTIME_HOURS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "OVERTIME_PAY_AMOUNT"
	type = "NUMBER(38,3)"
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

}

