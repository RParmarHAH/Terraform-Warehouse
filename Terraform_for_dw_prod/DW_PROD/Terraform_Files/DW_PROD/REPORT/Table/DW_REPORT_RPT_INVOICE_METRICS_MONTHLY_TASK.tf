resource "snowflake_table" "DW_REPORT_RPT_INVOICE_METRICS_MONTHLY_TASK" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "RPT_INVOICE_METRICS_MONTHLY_TASK"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.RPT_INVOICE_METRICS_MONTHLY_TASK

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
	name = "INVOICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "REVENUE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "INVOICE_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ALTERNATE_INVOICE_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOICE_TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "BILL_UNIT_TYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "REVENUE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "REPORT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "OFFICE_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CONTRACT_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONTRACT_CODE_AND_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "ORIGINAL_BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "OFFICE_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "OFFICE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORIGINAL_CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLIENT_NAME"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOICE_AMOUNT"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_BILLED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "AMOUNT_PAID"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "PAYMENT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAYMENT_RECEIVED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "PAYOR_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREDITED_AMOUNT"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "AMOUNT_OUTSTANDING"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "OUTSTANDING_DAYS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "UNCOLLECTABLE_REVENUE"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOICE_STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "START_OF_SERVICE"
	type = "DATE"
	nullable = true
}


column {
	name = "END_OF_SERVICE"
	type = "DATE"
	nullable = true
}


column {
	name = "PERIOD"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "TOTAL_PAID_AMOUNT"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "TOTAL_WRITE_OFF_AMOUNT"
	type = "NUMBER(38,3)"
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
	name = "MONTH_DATE"
	type = "DATE"
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

}

