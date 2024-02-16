resource "snowflake_table" "DW_REPORT_ACCOUNTS_RECEIVABLE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "ACCOUNTS_RECEIVABLE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.ACCOUNTS_RECEIVABLE

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
	name = "REPORT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BILL_REPRESENTATIVE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MONTHLY_AR_DELTA"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "ACCOUNTS_RECEIVABLE"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "MONTHLY_AMOUNT_BILLED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "MONTHLY_AMOUNT_COLLECTED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "CURRENT_ACCOUNT_RECEIVABLE"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "CURRENT_REVENUE_PER_DAY"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "ROW_LEVEL_DSO"
	type = "NUMBER(38,9)"
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
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

