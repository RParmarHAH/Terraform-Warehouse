resource "snowflake_table" "DW_HAH_FACT_REVENUE_SUBCATEGORY_USAGE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_REVENUE_SUBCATEGORY_USAGE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_REVENUE_SUBCATEGORY_USAGE

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
	name = "REVENUE_SUBCATEGORY_USAGE_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(50)"
	nullable = true
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
	name = "DASHBOARD_REPORT_NAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "METRIC_NAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "INCLUDE_FLAG"
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
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

