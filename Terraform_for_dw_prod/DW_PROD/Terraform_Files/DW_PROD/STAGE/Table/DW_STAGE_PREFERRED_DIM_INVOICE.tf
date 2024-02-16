resource "snowflake_table" "DW_STAGE_PREFERRED_DIM_INVOICE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "PREFERRED_DIM_INVOICE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.PREFERRED_DIM_INVOICE

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
	name = "INVOICE_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "INVOICE_NUMBER"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "ALTERNATE_INVOICE_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PERIOD"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "INVOICE_TYPE"
	type = "VARCHAR(20)"
	nullable = true
	comment = "Regular or Lump Sum"
}


column {
	name = "NUMBER_OF_CLIENTS"
	type = "NUMBER(38,0)"
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
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "PAYOR_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYOR_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INVOICE_OPEN_FLAG"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "FIRST_INVOICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "FINAL_PAYMENT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "FIRST_INVOICE_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILL_ITERATION"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_REPRESENTATIVE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BILL_SUPERVISOR"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BILL_MANAGER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INVOICE_STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WRITEOFF_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WRITEOFF_REASON"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AMOUNT_BILLED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "AMOUNT_COLLECTED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "AMOUNT_OUTSTANDING"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "EFFECTIVE_FROM_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "EFFECTIVE_TO_DATE"
	type = "TIMESTAMP_NTZ(9)"
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


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

