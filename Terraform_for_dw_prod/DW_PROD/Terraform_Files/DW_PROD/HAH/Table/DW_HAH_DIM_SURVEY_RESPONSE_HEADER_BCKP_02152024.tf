resource "snowflake_table" "DW_HAH_DIM_SURVEY_RESPONSE_HEADER_BCKP_02152024" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_SURVEY_RESPONSE_HEADER_BCKP_02152024"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_SURVEY_RESPONSE_HEADER_BCKP_02152024

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
	name = "SURVEY_RESPONSE_HEADER_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SURVEY_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SURVEY_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RECORD_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "WH_CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "WH_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PARTNER_KEY"
	type = "VARCHAR(32)"
	nullable = true
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
	name = "STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROGRESS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COMPLETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RECORDED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DURATION_IN_SECONDS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LANGUAGE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "LATITUDE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LONGITUDE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IP_ADDRESS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EXTERNAL_REFERENCE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DISTRIBUTION_CHANNEL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BATCH_NUMBER"
	type = "VARCHAR(20)"
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

