resource "snowflake_table" "DW_STAGE_DATAFLEXSYNCDATA_FACT_INVOICE_CREDITS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "DATAFLEXSYNCDATA_FACT_INVOICE_CREDITS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.DATAFLEXSYNCDATA_FACT_INVOICE_CREDITS

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
	name = "CREDIT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "REPORT_DATE"
	type = "DATE"
	nullable = false
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "INVOICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "PERIOD"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "PERIOD_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAYMENT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICE_AREA"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVOICE_TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "NUMBER_OF_INVOICES"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INVOICE_NUMBER"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "CREDIT_TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CREDIT_AMOUNT"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "PAYMENT_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYMENT_NOTES"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CHECK_NUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "AUDIT_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "WRITEOFF_REASON_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WRITEOFF_REASON_DESCRIPTION"
	type = "VARCHAR(100)"
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

