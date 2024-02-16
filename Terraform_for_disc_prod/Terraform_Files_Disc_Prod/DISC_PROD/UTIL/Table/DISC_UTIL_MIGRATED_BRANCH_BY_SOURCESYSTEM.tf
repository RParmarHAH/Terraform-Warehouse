resource "snowflake_table" "DISC_UTIL_MIGRATED_BRANCH_BY_SOURCESYSTEM" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "UTIL"
	name = "MIGRATED_BRANCH_BY_SOURCESYSTEM"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.UTIL.MIGRATED_BRANCH_BY_SOURCESYSTEM

    -- Purpose : Discovery Data Population

    -- Project : UTIL

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "OFFICE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OFFICE_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CUTTOFF_DATE"
	type = "DATE"
	nullable = true
}

}

