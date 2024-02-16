resource "snowflake_table" "DISC_NAVISION_CHECK_LEDGER_ENTRY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "NAVISION"
	name = "CHECK_LEDGER_ENTRY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.NAVISION.CHECK_LEDGER_ENTRY

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
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ENTRY_NO_"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BANK_ACCOUNT_NO_"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BANK_ACCOUNT_LEDGER_ENTRY_NO_"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POSTING_DATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DOCUMENT_TYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DOCUMENT_NO_"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CHECK_DATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CHECK_NO_"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CHECK_TYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BANK_PAYMENT_TYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ENTRY_STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ORIGINAL_ENTRY_STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BAL__ACCOUNT_TYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BAL__ACCOUNT_NO_"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OPEN"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATEMENT_STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATEMENT_NO_"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATEMENT_LINE_NO_"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USER_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXTERNAL_DOCUMENT_NO_"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TRACE_NO_"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TRANSMISSION_FILE_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLEARED"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USPY_PAYROLL_EMPLOYEE_NO_"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USPY_BANK_ACC__LEDG__ENTRY_NO_"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USPY_PAYROLL_DOCUMENT_NO_"
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

