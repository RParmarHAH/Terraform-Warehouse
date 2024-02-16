resource "snowflake_table" "DISC_ALAYACARE_SHARED_GROUP" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "SHARED_GROUP"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.SHARED_GROUP

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
	name = "GROUP_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROFILE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "GUID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROFILE_COMPANY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROFILE_REMARKS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_OP"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PROPERTIES_CREATE_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROPERTIES_DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_DISPLAY_ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PROPERTIES_GEOFENCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PROPERTIES_GUID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_IDACCOUNTGYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_IDMASTERACCOUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_IDPROFILE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_IDSTATUS"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PROPERTIES_PHONE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PROPERTIES_UPDATE_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "NUMBER(38,0)"
	nullable = true
}

}

