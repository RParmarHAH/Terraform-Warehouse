resource "snowflake_table" "DW_STAGE_MATRIXCARE_FACT_CLIENT_SERVICE_BKCP1310" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "MATRIXCARE_FACT_CLIENT_SERVICE_BKCP1310"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.MATRIXCARE_FACT_CLIENT_SERVICE_BKCP1310

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
	name = "CLIENT_SERVICE_KEY"
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
	name = "PARTNER_CONTRACT_SERVICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLIENT_ADMISSION_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SERVICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BILL_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILL_TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "BILL_UOM"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SCHEDULE_TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SCHEDULE_UOM"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "AUTHORIZATION_DISCIPLINE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AUTHORIZATION_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "AUTHORIZATION_PERIOD_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "AUTHORIZATION_PERIOD_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EFFECTIVE_DAYS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AUTHORIZATION_TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "AUTHORIZATION_UOM"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "AUTH_INFO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATION_MAX_UNITS_BY_UOM"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "AUTHORIZATION_MAX_UNITS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "AUTHORIZATION_MAX_UNITS_ADJUSTED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ACTIVE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVALID_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CANCELLED_FLAG"
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

