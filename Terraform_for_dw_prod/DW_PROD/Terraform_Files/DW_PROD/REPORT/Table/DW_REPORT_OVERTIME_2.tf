resource "snowflake_table" "DW_REPORT_OVERTIME_2" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "OVERTIME_2"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.OVERTIME_2

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
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_KEY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYROLL_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAYROLL_HOURS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "PAYROLL_SERVICE_HOURS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "PAYROLL_OVERTIME_HOURS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "PAYROLL_NON_SERVICE_UNITS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "PAY_RATE"
	type = "NUMBER(38,3)"
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
	name = "SUPERVISOR_KEY"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SERVICE_MONTH"
	type = "DATE"
	nullable = true
}


column {
	name = "HOURS_SERVED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "OVERTIME_RATIO"
	type = "NUMBER(38,9)"
	nullable = true
}


column {
	name = "OVERTIME_HOURS"
	type = "NUMBER(38,12)"
	nullable = true
}


column {
	name = "PAYROLL_OVERTIME_PAY_AMOUNT"
	type = "NUMBER(38,12)"
	nullable = true
}


column {
	name = "OVERTIME_PAY_AMOUNT"
	type = "NUMBER(38,12)"
	nullable = true
}


column {
	name = "OTR_EMPLOYEE_KEY"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(35)"
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

