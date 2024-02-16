resource "snowflake_table" "DISC_HHAEXCHANGEEDISON_SOURCE_AUDIT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	name = "SOURCE_AUDIT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEEDISON.SOURCE_AUDIT

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEEDISON

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "LOAD_IND"
	type = "VARCHAR(16777216)"
	nullable = true
}


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
	name = "COLUMN_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDINAL_POSITION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COLUMN_DEFAULT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_NULLABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATA_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHARACTER_MAXIMUM_LENGTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHARACTER_OCTET_LENGTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NUMERIC_PRECISION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NUMERIC_PRECISION_RADIX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NUMERIC_SCALE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATETIME_PRECISION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHARACTER_SET_CATALOG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHARACTER_SET_SCHEMA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHARACTER_SET_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COLLATION_CATALOG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COLLATION_SCHEMA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COLLATION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DOMAIN_CATALOG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DOMAIN_SCHEMA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DOMAIN_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PK_IND"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

