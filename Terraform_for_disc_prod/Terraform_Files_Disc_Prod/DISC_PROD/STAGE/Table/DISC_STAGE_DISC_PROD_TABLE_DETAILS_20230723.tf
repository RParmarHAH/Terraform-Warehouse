resource "snowflake_table" "DISC_STAGE_DISC_PROD_TABLE_DETAILS_20230723" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "DISC_PROD_TABLE_DETAILS_20230723"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.STAGE.DISC_PROD_TABLE_DETAILS_20230723

    -- Purpose : Discovery Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "TABLE_CATALOG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TABLE_SCHEMA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TABLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TABLE_OWNER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TABLE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_TRANSIENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLUSTERING_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ROW_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BYTES"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RETENTION_TIME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SELF_REFERENCING_COLUMN_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCE_GENERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_DEFINED_TYPE_CATALOG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_DEFINED_TYPE_SCHEMA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USER_DEFINED_TYPE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_INSERTABLE_INTO"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "IS_TYPED"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "COMMIT_ACTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP"
	nullable = true
}


column {
	name = "LAST_ALTERED"
	type = "TIMESTAMP"
	nullable = true
}


column {
	name = "LAST_DDL"
	type = "TIMESTAMP"
	nullable = true
}


column {
	name = "LAST_DDL_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTO_CLUSTERING_ON"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "COMMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

