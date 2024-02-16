resource "snowflake_table" "DISC_PUBLIC_PIPELINE_DEDUPE_CONFIG_NEW_BACKUP_HN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "PIPELINE_DEDUPE_CONFIG_NEW_BACKUP_HN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.PIPELINE_DEDUPE_CONFIG_NEW_BACKUP_HN

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
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

