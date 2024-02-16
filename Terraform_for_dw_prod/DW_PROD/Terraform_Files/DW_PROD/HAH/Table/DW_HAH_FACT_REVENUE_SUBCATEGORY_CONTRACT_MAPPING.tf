resource "snowflake_table" "DW_HAH_FACT_REVENUE_SUBCATEGORY_CONTRACT_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_REVENUE_SUBCATEGORY_CONTRACT_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_REVENUE_SUBCATEGORY_CONTRACT_MAPPING

    -- Purpose : Business Data Population

    -- Project : HAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "REVENUE_SUBCATEGORY_CONTRACT_MAPPING_KEY"
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
	name = "CONTRACT_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "CONTRACT_NAME"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "SERVICE_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SERVICE_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "REVENUE_SUBCATEGORY_CODE"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "REVENUE_SUBCATEGORY_NAME"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "BILLABLE_FLAG"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "PAYABLE_FLAG"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "MILEAGE_FLAG"
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
	type = "TIMESTAMP_TZ(9)"
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
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "TIMESTAMP_TZ(9)"
	nullable = false
}

}

