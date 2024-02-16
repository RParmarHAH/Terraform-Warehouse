resource "snowflake_table" "DISC_PUBLIC_AUDIT_SOURCE_QUERY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "AUDIT_SOURCE_QUERY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.AUDIT_SOURCE_QUERY

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
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "QUERY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_UPDATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

