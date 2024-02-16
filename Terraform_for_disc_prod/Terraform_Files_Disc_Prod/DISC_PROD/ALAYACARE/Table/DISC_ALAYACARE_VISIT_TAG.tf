resource "snowflake_table" "DISC_ALAYACARE_VISIT_TAG" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "VISIT_TAG"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.VISIT_TAG

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
	name = "VISIT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TAG_LIST"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TAGS"
	type = "VARCHAR(250)"
	nullable = true
}

}

