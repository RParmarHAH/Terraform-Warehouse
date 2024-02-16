resource "snowflake_table" "DW_STAGE_HM_FACT_SURVEY_RESPONSE_DETAIL" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "HM_FACT_SURVEY_RESPONSE_DETAIL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.HM_FACT_SURVEY_RESPONSE_DETAIL

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
	name = "SURVEY_RESPONSE_DETAIL_KEY"
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
	name = "SURVEY_RESPONSE_HEADER_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "SURVEY_QUESTION_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "QUESTION_ID"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "ANSWER"
	type = "VARCHAR(16777216)"
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

