resource "snowflake_table" "DISC_PAYOR_CONTRACT_UI_SERVICE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PAYOR_CONTRACT_UI"
	name = "SERVICE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PAYOR_CONTRACT_UI.SERVICE

    -- Purpose : Discovery Data Population

    -- Project : PAYOR_CONTRACT_UI

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

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
	name = "ORIGINAL_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ORIGINAL_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_NAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(40)"
	nullable = false
}


column {
	name = "CONTRACT_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONTRACT_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "SERVICE_CODE_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICE_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REVENUE_CATEGORY_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REVENUE_CATEGORY_NAME"
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
	name = "MILEAGE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYABLE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLABLE_FLAG"
	type = "BOOLEAN"
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

}

