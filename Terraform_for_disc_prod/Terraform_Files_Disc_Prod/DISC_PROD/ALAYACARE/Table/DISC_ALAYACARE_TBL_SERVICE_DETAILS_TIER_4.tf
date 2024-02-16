resource "snowflake_table" "DISC_ALAYACARE_TBL_SERVICE_DETAILS_TIER_4" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "TBL_SERVICE_DETAILS_TIER_4"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.TBL_SERVICE_DETAILS_TIER_4

    -- Purpose : Discovery Data Population

    -- Project : ALAYACARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_DETAILS"
	type = "VARIANT"
	nullable = true
}

}

