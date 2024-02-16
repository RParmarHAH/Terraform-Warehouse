resource "snowflake_table" "DISC_NAVISION_PAYROLL_CHECK_LEDGER_DETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "NAVISION"
	name = "PAYROLL_CHECK_LEDGER_DETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.NAVISION.PAYROLL_CHECK_LEDGER_DETAILS

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
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_CHECK_LEDGER_ENTRY_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LINE_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EMPLOYEE_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_CONTROL_TYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_CONTROL_NAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "G_L_POST_TYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CHECK_STUB_SECTION"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CHECK_STUB_SEQUENCE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "WHAT_TO_PRINT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "YTD_AMOUNT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "BALANCE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "HOURS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "FILING_STATUS_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ALLOWANCES"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EXTRA_WITHHOLDING"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CREDITS_OTHER_DEPS_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "INCOME_TAX_EXEMPT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "DISTRIBUTION_TYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "DISTRIBUTION_BANK_ACCOUNT_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TOTAL_CREDITS_CLAIMED"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ANNUAL_DEDUCTION"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "OTHER_ANNUAL_CREDITS"
	type = "VARCHAR(30)"
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

