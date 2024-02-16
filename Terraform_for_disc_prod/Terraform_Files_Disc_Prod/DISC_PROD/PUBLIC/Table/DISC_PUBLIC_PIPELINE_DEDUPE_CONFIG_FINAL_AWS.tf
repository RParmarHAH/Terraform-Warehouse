resource "snowflake_table" "DISC_PUBLIC_PIPELINE_DEDUPE_CONFIG_FINAL_AWS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "PIPELINE_DEDUPE_CONFIG_FINAL_AWS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.PIPELINE_DEDUPE_CONFIG_FINAL_AWS

    -- Purpose : Discovery Data Population

    -- Project : PUBLIC

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SOURCESYSTEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TASK_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TASK_GROUP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CODE_FILE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEDUPE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEDUPE_OUTPUT_FILE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OUTPUT_TABLE_QUERY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONFIG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_SOURCE_DATABASE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_SOURCE_SCHEMA_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_SOURCE_TABLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESTINATION_DATABASE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESTINATION_SCHEMA_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESTINATION_TABLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTAINER_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECTORY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOADTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "RUNTYPEFLAG"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "LASTRUNDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INSERTED_BY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TEMP_STATUES_CHECK"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

