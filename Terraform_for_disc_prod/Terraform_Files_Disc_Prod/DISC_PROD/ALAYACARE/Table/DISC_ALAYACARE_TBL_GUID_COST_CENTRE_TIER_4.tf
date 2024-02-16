resource "snowflake_table" "DISC_ALAYACARE_TBL_GUID_COST_CENTRE_TIER_4" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "TBL_GUID_COST_CENTRE_TIER_4"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.TBL_GUID_COST_CENTRE_TIER_4

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
	name = "ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "COST_CENTRE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "GUID_TO"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "PROPERTIES_OP"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PROPERTIES_CREATE_USER_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_CREATED_AT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_UPDATE_USER_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_UPDATED_AT"
	type = "VARCHAR(100)"
	nullable = true
}

}

