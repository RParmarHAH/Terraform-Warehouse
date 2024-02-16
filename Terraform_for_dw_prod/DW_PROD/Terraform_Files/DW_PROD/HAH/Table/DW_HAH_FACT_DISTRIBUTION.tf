resource "snowflake_table" "DW_HAH_FACT_DISTRIBUTION" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_DISTRIBUTION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_DISTRIBUTION

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
	name = "FACT_DISTRIBUTION_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "QUALTRICS_DIM_DISTRIBUTION_KEY"
	type = "VARCHAR(32)"
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
	name = "STATUS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SURVEY_LINK"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SURVEY_RESPONSE_HEADER_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "RECORD_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "RESPONSE_COMPLETED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SENT_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OPENED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RESPONSE_STARTED_AT"
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
	name = "ETL_INSERTED_TASK_KEY"
	type = "VARCHAR(16777216)"
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
	name = "ETL_UPDATED_DATE"
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
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}

}

