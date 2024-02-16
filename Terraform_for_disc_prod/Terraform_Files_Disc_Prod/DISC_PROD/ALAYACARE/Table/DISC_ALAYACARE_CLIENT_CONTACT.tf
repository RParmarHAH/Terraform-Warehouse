resource "snowflake_table" "DISC_ALAYACARE_CLIENT_CONTACT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "CLIENT_CONTACT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.CLIENT_CONTACT

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
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_IS_ACTIVE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_VERSION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LAT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_ADDRESS_VALID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_LIST_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_IDACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_DEPRECATED_GUID_TO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_GEO_CODED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LON"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_FULLTEXT_INDEX"
	type = "VARCHAR(3000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_PROFILE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_IS_ACTIVE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_IS_MAIN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_CONTACT_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_IS_EMERGENCY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_RELATIONSHIP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_IS_BILLING"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_GUID_TO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GUID_PROFILES_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CONTACT_IS_ACTIVE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_IMPORT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_LAST_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PERSONAL_EMAIL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_LEGACY_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PHONE_PERSONAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_DO_NOT_HIRE_"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_MARITAL_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_TYPE_OF_CAREGIVER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_JOB_TITLE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_UID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PHONE_MAIN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_TERMINATION_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ADDRESS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PHONE_OTHER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_GENDER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_JOB_CLASS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ETHNICITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_BIRTHDAY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_FIRST_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_BUSINESS_ENTITY_"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_EMAIL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_SALUTATION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_REMARKS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_SSN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_START_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ADDRESS_SUITE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_COUNTRY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_COUNTY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_STATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_CITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ZIP"
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

