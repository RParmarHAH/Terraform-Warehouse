resource "snowflake_table" "DW_HAH_DIM_DISTRIBUTION" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_DISTRIBUTION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_DISTRIBUTION

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
	name = "DIM_DISTRIBUTION_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PARENT_DISTRIBUTION_ID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SURVEY_SOURCE_TYPE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DISTRIBUTION_STATUS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "DISTRIBUTION_TYPE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SURVEY_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SURVEY_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "DISTRIBUTION_NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SEND_DATE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "MODIFIED_DATE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "FAILED"
	type = "VARIANT"
	nullable = true
}


column {
	name = "FINISHED"
	type = "VARIANT"
	nullable = true
}


column {
	name = "SENT"
	type = "VARIANT"
	nullable = true
}


column {
	name = "STARTED"
	type = "VARIANT"
	nullable = true
}


column {
	name = "CREDITS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "SEGMENTS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "BLOCKED"
	type = "VARIANT"
	nullable = true
}


column {
	name = "BOUNCED"
	type = "VARIANT"
	nullable = true
}


column {
	name = "COMPLAINTS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "OPENED"
	type = "VARIANT"
	nullable = true
}


column {
	name = "SKIPPED"
	type = "VARIANT"
	nullable = true
}


column {
	name = "SURVEY_LINK_EXPIRATION_DATE"
	type = "VARCHAR(1000)"
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

