resource "snowflake_table" "DW_HAH_FACT_SURVEY_QUESTION" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_SURVEY_QUESTION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_SURVEY_QUESTION

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
	name = "PRIMARY_QUESTION_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "SURVEY_QUESTION_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "SURVEY_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "SURVEY_ID"
	type = "VARCHAR(50)"
	nullable = false
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
	name = "QUESTION_ID"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "QID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "QUESTION_TEXT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "QUESTION_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(10,0)"
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

}

