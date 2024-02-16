resource "snowflake_table" "DISC_PUBLIC_PIPELINE_DEDUPE_CONFIG_OBJECT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "PIPELINE_DEDUPE_CONFIG_OBJECT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.PIPELINE_DEDUPE_CONFIG_OBJECT

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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOADTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEDUPE_OUTPUT_FILE"
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
	name = "CODE_FILE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESTINATION_OBJECT_VIEW_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEDUPE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONFIG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RUNTYPEFLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTRUNDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSERTED_DATE"
	type = "DATE"
	nullable = true
}

}

