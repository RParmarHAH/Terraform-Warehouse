resource "snowflake_table" "DISC_PUBLIC_BUSINESS_SITE_REGION_STATE_CODE_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "BUSINESS_SITE_REGION_STATE_CODE_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.BUSINESS_SITE_REGION_STATE_CODE_MAPPING

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
	name = "BUSINESS_SITE_REGION"
	type = "VARCHAR(14)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}

}

