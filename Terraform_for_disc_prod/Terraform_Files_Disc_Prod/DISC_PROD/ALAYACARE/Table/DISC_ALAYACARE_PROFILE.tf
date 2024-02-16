resource "snowflake_table" "DISC_ALAYACARE_PROFILE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "PROFILE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.PROFILE

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
	name = "PROFILE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_GUID"
	type = "VARCHAR(250)"
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
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_VERSION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_FULLTEXT_INDEX"
	type = "VARCHAR(16777216)"
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
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LON"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_ADDRESS_VALID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_LIST_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_IS_ACTIVE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_PROSPECT_CONTACT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_MEDICAID_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_REMARKS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROFILE_BUSINESS_ENTITY_"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_GUARDIAN_OR_PRIMARY_CONTACT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_MEMBER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_GENDER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_COMPANY_"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_BIRTHDAY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_JOB_CLASS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_STATE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_DATAFLEX_CONTRACT_IDS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_FIRST_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PHONE_MAIN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_LEGACY_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_MEDICAID_PRIOR_AUTHORIZATION_NUMBER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_MANAGEMENT_LEVEL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PERSONAL_EMAIL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_COMMUNICATION_METHOD"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_TERMINATION_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_SALUTATION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_TELLUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_REFERRAL_DATE"
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
	name = "PROFILE_START_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_FAX"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PAYMENT_ARRANGEMENT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_JOB_TITLE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ADDRESS_SUITE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_MIDDLE_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_COMPANY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ETHNICITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_START_ON"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_LAST_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_DO_NOT_HIRE_"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PHONE_PERSONAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_TERMINATION_REASON"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_IMPORT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PHONE_OTHER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_PAYER_1"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_GUARDIAN_OR_PRIMARY_CONTACT_PHONE_NUMBER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_SANDATA"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_UID"
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
	name = "PROFILE_ADDRESS"
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
	name = "PROFILE_SSN"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_ZIP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_EMAIL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PREFERRED_LANGUAGE"
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


column {
	name = "PROFILE_REFERRAL_SOURCE"
	type = "VARCHAR(50)"
	nullable = true
}

}

