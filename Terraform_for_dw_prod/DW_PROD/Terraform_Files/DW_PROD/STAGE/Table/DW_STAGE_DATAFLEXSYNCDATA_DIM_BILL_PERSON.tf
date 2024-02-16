resource "snowflake_table" "DW_STAGE_DATAFLEXSYNCDATA_DIM_BILL_PERSON" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "DATAFLEXSYNCDATA_DIM_BILL_PERSON"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.DATAFLEXSYNCDATA_DIM_BILL_PERSON

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
	name = "BILL_PERSON_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "DATAFLEX_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DATAFLEX_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "GP_SYSTEM_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "GP_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "GP_EMPLOYEE_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "GP_ACTIVE_EMPLOYEE_FLAG"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "BILL_PERSON_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PERSON_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(100)"
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

