resource "snowflake_table" "DISC_ALAYACARE_TBL_GUID_RELATION_TIER_4" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "TBL_GUID_RELATION_TIER_4"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.TBL_GUID_RELATION_TIER_4

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
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "GUID_ONE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "GUID_TWO"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "IDMETHOD"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "IDRELATION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RATING"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_GUID_ONE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_GUID_TWO"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_OP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_IDMETHOD"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_IDRELATION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_RATING"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

