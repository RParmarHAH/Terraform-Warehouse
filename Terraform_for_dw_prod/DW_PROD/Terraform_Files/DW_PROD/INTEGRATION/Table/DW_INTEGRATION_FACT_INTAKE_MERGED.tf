resource "snowflake_table" "DW_INTEGRATION_FACT_INTAKE_MERGED" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "FACT_INTAKE_MERGED"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.FACT_INTAKE_MERGED

    -- Purpose : Business Integration Data Population

    -- Project : INTEGRATION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "INTAKE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


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
	name = "ORIGINAL_BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ORIGINAL_CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
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
	name = "REAUTHORIZED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PRE_AUTH_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BEGIN_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "END_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LATEST_AUTH_BEGIN_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LATEST_AUTH_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORIGINAL_BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ORIGINAL_CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "BILL_RATE"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ORIGINAL_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CASE_MANAGER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED_NON_ADJUSTED"
	type = "NUMBER(38,3)"
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

