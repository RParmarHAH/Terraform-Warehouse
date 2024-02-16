resource "snowflake_table" "DISC_NAVISION_PAYROLL_LEDGER_ENTRY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "NAVISION"
	name = "PAYROLL_LEDGER_ENTRY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY

    -- Purpose : Discovery Data Population

    -- Project : NAVISION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "TIMESTAMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENTRY_NO_"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_NO_"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "POSTING_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DOCUMENT_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DOCUMENT_NO_"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REGULAR_PAY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TAXABLE_AMOUNT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AMOUNT_ON_PAY_CHECK"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYROLL_POSTING_GROUP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "GLOBAL_DIMENSION_1_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "GLOBAL_DIMENSION_2_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RESOURCE_NO_"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "USER_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SOURCE_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYROLL_CONTROL_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYROLL_CONTROL_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYROLL_CONTROL_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCALITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAY_PERIOD_END_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "G_L_POST_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VENDOR_LEDGER_ENTRY_NO_"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VENDOR_LEDGER_POSTING"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "JOB_NO_"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "JOB_TASK_NO_"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BURDEN_ALLOCATED"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CHARGEABLE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WORK_TYPE_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "JOURNAL_BATCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REASON_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CHECK_NO_"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REPORTING_AUTHORITY_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REPORTING_AUTHORITY_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ENTRY_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DATE_WORKED"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_CYCLE_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_CYCLE_TERM"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_CYCLE_PERIOD"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_PERIOD_START_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EARNED_PAY_CYCLE_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EARNED_PAY_CYCLE_TERM"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EARNED_PAY_CYCLE_PERIOD"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EARNED_PERIOD_START_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EARNED_PERIOD_END_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WORK_REPORTING_AUTHORITY_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LEDGER_POSTING_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INSURABLE_HOURS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TAX_TYPE_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYER_NO_"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_SOCIAL_SECURITY_NO_"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_CLASS_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DIMENSION_SET_ID"
	type = "VARCHAR(50)"
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
	nullable = true
}

}

