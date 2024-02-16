resource "snowflake_table" "DW_HAH_DIM_SOURCE_SYSTEM" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_SOURCE_SYSTEM"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_SOURCE_SYSTEM

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
	name = "SOURCE_SYSTEM_NAME"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "SYSTEM_DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "SERVER_NAME"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_TYPE"
	type = "VARCHAR(50)"
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

