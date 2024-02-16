resource "snowflake_table" "DW_HAH_DIM_VISIT_EXCEPTION" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_VISIT_EXCEPTION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_VISIT_EXCEPTION

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
	name = "EXCEPTION_KEY"
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
	name = "EXCEPTION_CODE"
	type = "VARCHAR(100)"
	nullable = false
	comment = "Code of the Error raised during the verification of visit"
}


column {
	name = "EXCEPTION_DESC"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EXCEPTION_CATEGORY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CATEGORY_KEY"
	type = "VARCHAR(50)"
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

}

