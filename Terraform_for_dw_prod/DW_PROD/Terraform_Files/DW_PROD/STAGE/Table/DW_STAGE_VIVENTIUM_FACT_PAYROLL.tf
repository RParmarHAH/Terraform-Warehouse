resource "snowflake_table" "DW_STAGE_VIVENTIUM_FACT_PAYROLL" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VIVENTIUM_FACT_PAYROLL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.VIVENTIUM_FACT_PAYROLL

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
	name = "PAYROLL_KEY"
	type = "VARCHAR(16777216)"
	nullable = false
}


column {
	name = "REPORT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(16777216)"
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
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_HOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "SERVICE_HOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "OVERTIME_HOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "NON_SERVICE_UNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SICK_HOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "VACATION_HOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAY_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "OVERTIME_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "GROSS_PAY_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "SERVICE_PAY_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "OVERTIME_PAY_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "NON_SERVICE_PAY_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAX_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "NET_PAY_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "OTHER_DEDUCTIONS_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "UNION_DUES_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REINBURSMENT_AMOUNT"
	type = "FLOAT"
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


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}

}

