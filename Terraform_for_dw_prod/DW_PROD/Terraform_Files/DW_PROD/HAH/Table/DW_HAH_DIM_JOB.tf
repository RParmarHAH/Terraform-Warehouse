resource "snowflake_table" "DW_HAH_DIM_JOB" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_JOB"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_JOB

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
	name = "JOB_KEY"
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
	nullable = true
}


column {
	name = "JOB_ID"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "STATE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "JOB_POSTING_DATE"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "JOB_CLOSING_DATE"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "JOB_CREATED_DATE"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "JOB_TITLE_CODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "JOB_FAMILY"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "JOB_FAMILY_CODE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "JOB_OWNER"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "JOB_OWNER_ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "JOB_STATUS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "LOCATION_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXTERNAL_JOB_REFERENCE_NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ARCHIVED"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "REQ_AGE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "REQ_AGE_GROUP"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "JOB_POSTING_LINK"
	type = "VARCHAR(16777216)"
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


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}

}

