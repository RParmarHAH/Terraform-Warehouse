resource "snowflake_table" "DISC_PUBLIC_PIPELINE_ADHOC_PROCESSING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "PIPELINE_ADHOC_PROCESSING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.PIPELINE_ADHOC_PROCESSING

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
	name = "QUERY"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "FLAG"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LAST_RUNDATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SOURCE_CONTAINER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SOURCE_DIRECTORY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ARCHIVE_CONTAINER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ARCHIVE_DIRECTORY"
	type = "VARCHAR(100)"
	nullable = true
}

}

