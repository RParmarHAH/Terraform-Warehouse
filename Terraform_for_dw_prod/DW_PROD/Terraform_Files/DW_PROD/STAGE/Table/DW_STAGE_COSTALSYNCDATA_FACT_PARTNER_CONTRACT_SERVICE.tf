resource "snowflake_table" "DW_STAGE_COSTALSYNCDATA_FACT_PARTNER_CONTRACT_SERVICE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "COSTALSYNCDATA_FACT_PARTNER_CONTRACT_SERVICE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.COSTALSYNCDATA_FACT_PARTNER_CONTRACT_SERVICE

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
	name = "PARTNER_CONTRACT_SERVICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARTNER_CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PARTNER_CODE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PARTNER_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CONTRACT_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SERVICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SERVICE_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BILLING_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BILL_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BILL_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BILLABLE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILL_TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "BILL_UOM"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SCHEDULE_TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SCHEDULE_UOM"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "AUTHORIZATION_REQUIRED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYABLE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXPENSE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MILEAGE_FLAG"
	type = "BOOLEAN"
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
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

