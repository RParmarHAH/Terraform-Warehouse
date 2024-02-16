CREATE OR REPLACE TABLE DISC_PROD.ALAYACARE.CONTACT (
	LAKE_ID NUMBER(38,0),
	CONTACT_ID NUMBER(38,0),
	CONTACT_GUID_TO NUMBER(38,0),
	CREATED_AT TIMESTAMP_NTZ(9),
	PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_USER_ID VARCHAR(250),
	PROPERTIES_TBL_PROSPECT_CONTACT_GUID VARCHAR(250),
	PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_TIME VARCHAR(250),
	PROPERTIES_TBL_PROSPECT_CONTACT_DEPRECATED_GUID_TO VARCHAR(250),
	PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LON VARCHAR(250),
	PROPERTIES_TBL_PROSPECT_CONTACT_IS_ACTIVE VARCHAR(250),
	PROPERTIES_TBL_PROSPECT_CONTACT_GEO_CODED VARCHAR(250),
	PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_TIME VARCHAR(250),
	PROPERTIES_TBL_PROSPECT_CONTACT_VERSION VARCHAR(250),
	PROPERTIES_TBL_PROSPECT_CONTACT_LIST_ID VARCHAR(250),
	PROPERTIES_TBL_PROSPECT_CONTACT_IDACCOUNT VARCHAR(250),
	PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_USER_ID VARCHAR(250),
	PROPERTIES_TBL_PROSPECT_CONTACT_ADDRESS_VALID VARCHAR(250),
	PROPERTIES_TBL_PROSPECT_CONTACT_FULLTEXT_INDEX VARCHAR(16777216),
	PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LAT VARCHAR(250),
	PROPERTIES_TBL_GUID_PROFILES_IS_ACTIVE VARCHAR(250),
	PROPERTIES_TBL_GUID_PROFILES_IS_EMERGENCY VARCHAR(250),
	PROPERTIES_TBL_GUID_PROFILES_PROFILE_ID VARCHAR(250),
	PROPERTIES_TBL_GUID_PROFILES_ORDER VARCHAR(250),
	PROPERTIES_TBL_GUID_PROFILES_EB_MEDICAID_NPI VARCHAR(250),
	PROPERTIES_TBL_GUID_PROFILES_CONTACT_TYPE VARCHAR(250),
	PROPERTIES_TBL_GUID_PROFILES_RELATIONSHIP VARCHAR(250),
	PROPERTIES_TBL_GUID_PROFILES_IS_MAIN VARCHAR(250),
	PROPERTIES_TBL_GUID_PROFILES_OP VARCHAR(250),
	PROPERTIES_TBL_GUID_PROFILES_IS_BILLING VARCHAR(250),
	PROPERTIES_TBL_GUID_PROFILES_GUID_TO VARCHAR(250),
	PROPERTIES_TBL_GUID_PROFILES_EB_MEDICAID_PROVIDER_TYPE VARCHAR(250),
	CONTACT_IS_ACTIVE NUMBER(38,0),
	PROPERTIES_TBL_PROSPECT_CONTACT_OP VARCHAR(250),
	BRANCH_ID NUMBER(38,0),
	PROPERTIES_TBL_PROSPECT_CONTACT_ID VARCHAR(250),
	PROFILE_REMARKS VARCHAR(16777216),
	PROFILE_TERMINATION_DATE VARCHAR(250),
	PROFILE_START_DATE VARCHAR(250),
	PROFILE_ADDRESS_SUITE VARCHAR(250),
	PROFILE_JOB_TITLE VARCHAR(250),
	PROFILE_PHONE_OTHER VARCHAR(250),
	PROFILE_MEMBER_ID VARCHAR(250),
	PROFILE_GUARDIAN_OR_PRIMARY_CONTACT VARCHAR(250),
	PROFILE_PERSONAL_EMAIL VARCHAR(250),
	PROFILE_MARITAL_STATUS VARCHAR(250),
	PROFILE_DATAFLEX_CONTRACT_IDS VARCHAR(250),
	PROFILE_COMPANY VARCHAR(250),
	PROFILE_LAST_NAME VARCHAR(250),
	PROFILE_GENDER VARCHAR(250),
	PROFILE_LEGACY_ID VARCHAR(250),
	PROFILE_ETHNICITY VARCHAR(250),
	PROFILE_PAYMENT_ARRANGEMENT VARCHAR(250),
	PROFILE_IMPORT_ID VARCHAR(250),
	PROFILE_MEDICAID_PRIOR_AUTHORIZATION_NUMBER VARCHAR(250),
	PROFILE_BIRTHDAY VARCHAR(250),
	PROFILE_REFERRAL_DATE VARCHAR(250),
	PROFILE_TELLUS VARCHAR(250),
	PROFILE_GUARDIAN_OR_PRIMARY_CONTACT_PHONE_NUMBER VARCHAR(250),
	PROFILE_TERMINATION_REASON VARCHAR(250),
	PROFILE_TYPE_OF_CAREGIVER VARCHAR(250),
	PROFILE_COMPANY_ VARCHAR(250),
	PROFILE_DO_NOT_HIRE_ VARCHAR(250),
	PROFILE_PHONE_PERSONAL VARCHAR(250),
	PROFILE_FIRST_NAME VARCHAR(250),
	PROFILE_SALUTATION VARCHAR(250),
	PROFILE_COMMUNICATION_METHOD VARCHAR(250),
	PROFILE_MIDDLE_NAME VARCHAR(250),
	PROFILE_STATE_ID VARCHAR(250),
	PROFILE_SANDATA VARCHAR(250),
	PROFILE_MEDICAID_ID VARCHAR(250),
	PROFILE_BUSINESS_ENTITY_ VARCHAR(250),
	PROFILE_PHONE_MAIN VARCHAR(250),
	PROFILE_PAYER_1 VARCHAR(250),
	PROFILE_FAX VARCHAR(250),
	PROFILE_MANAGEMENT_LEVEL VARCHAR(250),
	PROFILE_START_ON VARCHAR(250),
	PROFILE_NAME VARCHAR(250),
	PROFILE_JOB_CLASS VARCHAR(250),
	PROFILE_UID VARCHAR(250),
	PROFILE_COUNTRY VARCHAR(250),
	PROFILE_COUNTY VARCHAR(250),
	PROFILE_ADDRESS VARCHAR(250),
	PROFILE_STATE VARCHAR(250),
	PROFILE_CITY VARCHAR(250),
	PROFILE_SSN VARCHAR(250),
	PROFILE_ZIP VARCHAR(250),
	PROFILE_EMAIL VARCHAR(250),
	AGE NUMBER(9,0),
	AGE_RANGE VARCHAR(250)
);