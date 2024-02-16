resource "snowflake_table" "DW_STAGE_OPENSYSTEMS_FACT_INVOICE_TRANSACTIONS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "OPENSYSTEMS_FACT_INVOICE_TRANSACTIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.OPENSYSTEMS_FACT_INVOICE_TRANSACTIONS

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
	name = "TRANSACTION_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "TRANSACTION_NUMBER"
	type = "VARCHAR(38)"
	nullable = false
}


column {
	name = "REVENUE_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "VISIT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "TRANSACTION_TYPE_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "AMOUNT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "TRANSACTION_CREATED"
	type = "DATE"
	nullable = true
}


column {
	name = "TRANSACTION_POSTED"
	type = "DATE"
	nullable = true
}


column {
	name = "TRANSACTION_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "FINAL_TRANSACTION_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CHECK_NUMBER"
	type = "VARCHAR(52)"
	nullable = true
}


column {
	name = "CHECK_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DEPOSIT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "POSTED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
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

