resource "snowflake_table" "DW_STAGE_SANDATAIMPORT_FACT_REVENUE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "SANDATAIMPORT_FACT_REVENUE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.SANDATAIMPORT_FACT_REVENUE

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
	name = "REVENUE_KEY"
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
	name = "EMPLOYEE_KEY"
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
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "REVENUE_DATE"
	type = "DATE"
	nullable = false
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
	name = "EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "INVOICE_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOICE_TYPE"
	type = "VARCHAR(20)"
	nullable = true
	comment = "Regular or Lump Sum"
}


column {
	name = "BILL_UNIT_TYPE"
	type = "VARCHAR(50)"
	nullable = true
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
	name = "SUPERVISOR_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILL_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOICE_HOURS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "INVOICE_RATE"
	type = "NUMBER(38,3)"
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

