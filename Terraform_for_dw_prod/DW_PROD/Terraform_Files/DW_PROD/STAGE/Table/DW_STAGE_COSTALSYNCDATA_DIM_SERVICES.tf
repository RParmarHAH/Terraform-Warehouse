resource "snowflake_table" "DW_STAGE_COSTALSYNCDATA_DIM_SERVICES" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "COSTALSYNCDATA_DIM_SERVICES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.COSTALSYNCDATA_DIM_SERVICES

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
	name = "SERVICE_KEY"
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
	name = "SERVICE_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICE_DESCRIPTION"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "SERVICE_TYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICE_RATE_TYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REVENUE_SUBCATEGORY_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "REVENUE_SUBCATEGORY_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACTIVE_FLAG"
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

