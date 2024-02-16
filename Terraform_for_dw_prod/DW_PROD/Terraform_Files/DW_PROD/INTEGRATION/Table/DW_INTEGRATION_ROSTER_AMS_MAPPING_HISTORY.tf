resource "snowflake_table" "DW_INTEGRATION_ROSTER_AMS_MAPPING_HISTORY" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "ROSTER_AMS_MAPPING_HISTORY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY

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
	name = "AMS_CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PARTNER_CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ROSTER_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MATCHED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "UNMATCHED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "IS_LATEST"
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

