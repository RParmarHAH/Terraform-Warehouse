resource "snowflake_table" "DISC_PUBLIC_PIPELINE_DEDUPE_CONFIG_20221215" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "PIPELINE_DEDUPE_CONFIG_20221215"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.PIPELINE_DEDUPE_CONFIG_20221215

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
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SOURCETYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CODE_FILE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DEDUPE_OUTPUT_FILE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "MATCH_OUTPUT_FILE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SCHEMA_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DEDUPE_TABLE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MATCH_TABLE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FLAG"
	type = "NUMBER(38,0)"
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
	name = "JSON_FILENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOADTYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

