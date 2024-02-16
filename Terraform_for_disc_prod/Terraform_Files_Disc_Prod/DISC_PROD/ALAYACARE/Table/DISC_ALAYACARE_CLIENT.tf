resource "snowflake_table" "DISC_ALAYACARE_CLIENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "CLIENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.CLIENT

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
	name = "CLIENT_ID"
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
	name = "REVISION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROFILE_ADDRESS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_CITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_COUNTY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_COMPANY"
	type = "VARCHAR(250)"
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
	name = "PROFILE_PHONE_MAIN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_START_ON"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_STATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ZIP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_BIRTHDAY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_SSN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_GENDER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ETHNICITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_MARITAL_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_SALUTATION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ADDRESS_SUITE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PHONE_PERSONAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_FAX"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_EMAIL"
	type = "VARCHAR(50000)"
	nullable = true
}


column {
	name = "PROFILE_REFERRAL_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_DISPLAY_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_GEOFENCE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_IDACCOUNTTYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_IDPROFILE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_IDSTATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_PHONE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_GT_ACCOUNT_UPDATE_USER_ID"
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
	type = "VARCHAR(50000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_GEO_CODED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LAT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LON"
	type = "VARCHAR(250)"
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
	name = "AGE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGE_RANGE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADMISSION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISCHARGE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIENT_BRN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PREFERRED_LANGUAGE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LENGTH_OF_STAY"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "HAS_ADLS"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "PROFILE_ACQUIRED_BUSINESS_"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ACQUISITION_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_SCHEDULING_PRIORITY"
	type = "VARCHAR(250)"
	nullable = true
}

}

