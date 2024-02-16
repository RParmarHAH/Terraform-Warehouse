resource "snowflake_table" "DISC_ALAYACARE_EMPLOYEE_CONTACT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "EMPLOYEE_CONTACT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.EMPLOYEE_CONTACT

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
	name = "LAKE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CONTACT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CONTACT_GUID_TO"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_DEPRECATED_GUID_TO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_FULLTEXT_INDEX"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_IDACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_IS_ACTIVE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_LIST_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_CONTACT_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_EB_MEDICAID_NPI"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_EB_MEDICAID_PROVIDER_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_GUID_TO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_IS_ACTIVE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_IS_BILLING"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_IS_EMERGENCY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_IS_MAIN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_PROFILE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_RELATIONSHIP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CONTACT_IS_ACTIVE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROFILE_COUNTRY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_FIRST_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_LAST_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PHONE_MAIN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "AGE"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "AGE_RANGE"
	type = "VARCHAR(250)"
	nullable = true
}

}

