resource "snowflake_table" "DISC_PUBLIC_DISC_PROD_USED_TABLE_LIST_20231016" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "DISC_PROD_USED_TABLE_LIST_20231016"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.DISC_PROD_USED_TABLE_LIST_20231016

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
	name = "DESTINATION_TABLE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "USED"
	type = "BOOLEAN"
	nullable = true
}

}

