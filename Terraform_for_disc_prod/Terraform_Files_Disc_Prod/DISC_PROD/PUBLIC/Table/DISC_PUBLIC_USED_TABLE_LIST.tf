resource "snowflake_table" "DISC_PUBLIC_USED_TABLE_LIST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "USED_TABLE_LIST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.USED_TABLE_LIST

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
	name = "TABLE_NAME"
	type = "VARCHAR(10000)"
	nullable = true
}

}

