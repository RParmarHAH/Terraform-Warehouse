resource "snowflake_table" "DW_STAGE_OPENSYSTEMS_DIM_BILLING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "OPENSYSTEMS_DIM_BILLING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.OPENSYSTEMS_DIM_BILLING

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
	name = "BILLING_KEY"
	type = "VARCHAR(32)"
	nullable = false
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
	name = "BILL_CODE"
	type = "VARCHAR(16777216)"
	nullable = false
}


column {
	name = "BILL_NAME"
	type = "VARCHAR(16777216)"
	nullable = false
}


column {
	name = "BILL_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILL_TYPE"
	type = "VARCHAR(16777216)"
	nullable = false
}


column {
	name = "BILL_UOM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILL_RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE_EFFECTIVE_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = false
}


column {
	name = "REVENUE_SUBCATEGORY_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REVENUE_SUBCATEGORY_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GL_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GL_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GL_DESCRIPTION"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "ACTIVE_FLAG"
	type = "BOOLEAN"
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
	name = "RATE_EFFECTIVE_END_DATE"
	type = "DATE"
	nullable = true
}

}

