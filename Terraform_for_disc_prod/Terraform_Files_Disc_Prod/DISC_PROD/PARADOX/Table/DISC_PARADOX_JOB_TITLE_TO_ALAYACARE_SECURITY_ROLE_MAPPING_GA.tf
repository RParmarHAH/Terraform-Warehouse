resource "snowflake_table" "DISC_PARADOX_JOB_TITLE_TO_ALAYACARE_SECURITY_ROLE_MAPPING_GA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "JOB_TITLE_TO_ALAYACARE_SECURITY_ROLE_MAPPING_GA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.JOB_TITLE_TO_ALAYACARE_SECURITY_ROLE_MAPPING_GA

    -- Purpose : Discovery Data Population

    -- Project : PARADOX

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PDX_JOB_FAMILY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALAYACARE_ADMIN_PORTAL_ROLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALAYACARE_FIELD_PORTAL_ROLE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

