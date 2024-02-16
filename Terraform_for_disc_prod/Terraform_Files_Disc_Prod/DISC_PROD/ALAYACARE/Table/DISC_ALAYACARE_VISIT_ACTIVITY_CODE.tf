resource "snowflake_table" "DISC_ALAYACARE_VISIT_ACTIVITY_CODE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "VISIT_ACTIVITY_CODE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.VISIT_ACTIVITY_CODE

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
	name = "VISIT_ACTIVITY_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISIT_ACTIVITY_CODE_PROPERTIES"
	type = "VARCHAR(2500)"
	nullable = true
}


column {
	name = "ACTIVITY_CODE_PROPERTIES"
	type = "VARCHAR(2500)"
	nullable = true
}

}

