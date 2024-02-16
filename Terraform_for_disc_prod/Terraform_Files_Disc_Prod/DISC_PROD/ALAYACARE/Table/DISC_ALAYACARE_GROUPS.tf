resource "snowflake_table" "DISC_ALAYACARE_GROUPS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "GROUPS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.GROUPS

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


column {
	name = "PROFILE_COMPANY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_REMARKS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IDPROFILE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IDACCOUNTTYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PHONE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_GEOFENCE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IDSTATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_DISPLAY_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_OP"
	type = "VARCHAR(250)"
	nullable = true
}

}

