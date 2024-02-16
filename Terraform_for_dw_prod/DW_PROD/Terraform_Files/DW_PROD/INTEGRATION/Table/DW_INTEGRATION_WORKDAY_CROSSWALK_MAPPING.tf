resource "snowflake_table" "DW_INTEGRATION_WORKDAY_CROSSWALK_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "WORKDAY_CROSSWALK_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.WORKDAY_CROSSWALK_MAPPING

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
	name = "WORKDAY_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WORKDAY_SOURCE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WORKDAY_SYSTEM_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CROSSWALK_EMPLOYEE_ENTERPRISE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CROSS_WALK_SOURCE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AMS_SYSTEM_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CURRENT_RECORDS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ON_HOLD"
	type = "BOOLEAN"
	nullable = true
}

}

