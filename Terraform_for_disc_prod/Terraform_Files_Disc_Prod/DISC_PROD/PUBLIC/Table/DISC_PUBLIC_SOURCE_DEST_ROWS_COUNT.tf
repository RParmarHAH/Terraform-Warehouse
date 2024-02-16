resource "snowflake_table" "DISC_PUBLIC_SOURCE_DEST_ROWS_COUNT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "SOURCE_DEST_ROWS_COUNT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.SOURCE_DEST_ROWS_COUNT

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
	name = "SOURCESYSTEM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TABLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ROW_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SOURCE_COUNT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "TIMEUPDATED"
	type = "TIMESTAMP"
	nullable = true
}

}

