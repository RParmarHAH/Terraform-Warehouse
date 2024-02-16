resource "snowflake_table" "DW_STAGE_QUALTRICS_FACT_SURVEY_OPTOUT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "QUALTRICS_FACT_SURVEY_OPTOUT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.QUALTRICS_FACT_SURVEY_OPTOUT

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
	name = "QUALTRICS_FACT_SURVEY_OPTOUT_KEY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONTACTID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WH_EMPLOYEE_KEY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WH_CLIENT_KEY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UNSUBSCRIBE_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UNSUBSCRIBE_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "DATE"
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

