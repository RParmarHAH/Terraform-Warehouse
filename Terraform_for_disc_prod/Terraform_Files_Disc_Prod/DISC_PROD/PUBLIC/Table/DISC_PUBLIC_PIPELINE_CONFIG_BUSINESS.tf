resource "snowflake_table" "DISC_PUBLIC_PIPELINE_CONFIG_BUSINESS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "PIPELINE_CONFIG_BUSINESS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.PIPELINE_CONFIG_BUSINESS

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
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SOURCETYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TASKNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TASKGROUP"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PRIMARY_SOURCE_DATABASE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PRIMARY_SOURCE_SCHEMA_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PRIMARY_SOURCE_TABLE_NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PRIMARY_SOURCE_JOIN_KEYS"
	type = "VARCHAR(400)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION_START"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DESTINATION_DATABASE_NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "DESTINATION_SCHEMA_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DESTINATION_TABLE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DESTINATION_VIEW_NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CDCTYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BLOBCONTAINER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SQLCONTAINER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SQLDIRECTORY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SQLINSERTFILENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FLAG"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DAILY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "WEEKLY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BLOBDIRECTORY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ARCHIVE_DIRECTORY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOADTYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "JSON_FILENAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PIPELINETYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ARCHIVE_CONTAINER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RUNTYPEFLAG"
	type = "NUMBER(38,0)"
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
	name = "REMARK"
	type = "VARCHAR(1000)"
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


column {
	name = "TOLD_BY"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SPLIT_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}

}

