CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_CONTACT()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_CONTACT 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2021-11-11		UNKNOWN					INITIAL DEVELOPMENT
-- 2023-09-05  		RAVI SUTHAR            	MIGRATED JavaScript to SQL
--*****************************************************************************************************************************
    return_result varchar(1000);
BEGIN
	
    INSERT OVERWRITE INTO ALAYACARE.CONTACT (
        LAKE_ID, CONTACT_ID, CONTACT_GUID_TO, CREATED_AT, PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_USER_ID, PROPERTIES_TBL_PROSPECT_CONTACT_ID, PROPERTIES_TBL_PROSPECT_CONTACT_IDACCOUNT, PROPERTIES_TBL_PROSPECT_CONTACT_IS_ACTIVE, PROPERTIES_TBL_PROSPECT_CONTACT_FULLTEXT_INDEX, PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_TIME, PROPERTIES_TBL_PROSPECT_CONTACT_VERSION, PROPERTIES_TBL_PROSPECT_CONTACT_GEO_CODED, PROPERTIES_TBL_PROSPECT_CONTACT_GUID, PROPERTIES_TBL_PROSPECT_CONTACT_DEPRECATED_GUID_TO, PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LON, PROPERTIES_TBL_PROSPECT_CONTACT_OP, PROPERTIES_TBL_PROSPECT_CONTACT_ADDRESS_VALID, PROPERTIES_TBL_PROSPECT_CONTACT_LIST_ID, PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_USER_ID, PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LAT, PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_TIME, PROPERTIES_TBL_GUID_PROFILES_GUID_TO, PROPERTIES_TBL_GUID_PROFILES_CONTACT_TYPE, PROPERTIES_TBL_GUID_PROFILES_IS_MAIN, PROPERTIES_TBL_GUID_PROFILES_PROFILE_ID, PROPERTIES_TBL_GUID_PROFILES_EB_MEDICAID_NPI, PROPERTIES_TBL_GUID_PROFILES_ORDER, PROPERTIES_TBL_GUID_PROFILES_EB_MEDICAID_PROVIDER_TYPE, PROPERTIES_TBL_GUID_PROFILES_OP, PROPERTIES_TBL_GUID_PROFILES_IS_ACTIVE, PROPERTIES_TBL_GUID_PROFILES_IS_EMERGENCY, PROPERTIES_TBL_GUID_PROFILES_IS_BILLING, PROPERTIES_TBL_GUID_PROFILES_RELATIONSHIP, CONTACT_IS_ACTIVE, BRANCH_ID, PROFILE_LEGACY_ID, PROFILE_GUARDIAN_OR_PRIMARY_CONTACT_PHONE_NUMBER, PROFILE_MARITAL_STATUS, PROFILE_ETHNICITY, PROFILE_DO_NOT_HIRE_, PROFILE_PAYER_1, PROFILE_ADDRESS_SUITE, PROFILE_ZIP, PROFILE_ADDRESS, PROFILE_COMMUNICATION_METHOD, PROFILE_COUNTY, PROFILE_TYPE_OF_CAREGIVER, PROFILE_MEDICAID_ID, PROFILE_SSN, PROFILE_MIDDLE_NAME, PROFILE_JOB_TITLE, PROFILE_FAX, PROFILE_PERSONAL_EMAIL, PROFILE_PHONE_MAIN, PROFILE_TELLUS, PROFILE_STATE, PROFILE_SALUTATION, PROFILE_DATAFLEX_CONTRACT_IDS, PROFILE_PHONE_OTHER, PROFILE_LAST_NAME, PROFILE_GUARDIAN_OR_PRIMARY_CONTACT, PROFILE_COUNTRY, PROFILE_COMPANY, PROFILE_BIRTHDAY, PROFILE_MEMBER_ID, PROFILE_TERMINATION_REASON, PROFILE_BUSINESS_ENTITY_, PROFILE_UID, PROFILE_TERMINATION_DATE, PROFILE_MEDICAID_PRIOR_AUTHORIZATION_NUMBER, PROFILE_CITY, PROFILE_START_DATE, PROFILE_GENDER, PROFILE_MANAGEMENT_LEVEL, PROFILE_FIRST_NAME, PROFILE_SANDATA, PROFILE_START_ON, PROFILE_NAME, PROFILE_EMAIL, PROFILE_IMPORT_ID, PROFILE_REFERRAL_DATE, PROFILE_PAYMENT_ARRANGEMENT, PROFILE_PHONE_PERSONAL, PROFILE_JOB_CLASS, PROFILE_REMARKS, PROFILE_COMPANY_, PROFILE_STATE_ID, AGE, AGE_RANGE)
        SELECT LAKE_ID AS LAKE_ID, CONTACT_ID AS CONTACT_ID, CONTACT_GUID_TO AS CONTACT_GUID_TO, CREATED_AT AS CREATED_AT, PROPERTIES_TBL_PROSPECT_CONTACT:create_user_id::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_USER_ID, PROPERTIES_TBL_PROSPECT_CONTACT:id::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_ID, PROPERTIES_TBL_PROSPECT_CONTACT:idaccount::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_IDACCOUNT, PROPERTIES_TBL_PROSPECT_CONTACT:is_active::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_IS_ACTIVE, PROPERTIES_TBL_PROSPECT_CONTACT:fulltext_index::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_FULLTEXT_INDEX, PROPERTIES_TBL_PROSPECT_CONTACT:update_time::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_TIME, PROPERTIES_TBL_PROSPECT_CONTACT:version::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_VERSION, PROPERTIES_TBL_PROSPECT_CONTACT:geo_coded::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_GEO_CODED, PROPERTIES_TBL_PROSPECT_CONTACT:guid::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_GUID, PROPERTIES_TBL_PROSPECT_CONTACT:deprecated_guid_to::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_DEPRECATED_GUID_TO, PROPERTIES_TBL_PROSPECT_CONTACT:geo_lon::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LON, PROPERTIES_TBL_PROSPECT_CONTACT:Op::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_OP, PROPERTIES_TBL_PROSPECT_CONTACT:address_valid::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_ADDRESS_VALID, PROPERTIES_TBL_PROSPECT_CONTACT:list_id::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_LIST_ID, PROPERTIES_TBL_PROSPECT_CONTACT:update_user_id::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_USER_ID, PROPERTIES_TBL_PROSPECT_CONTACT:geo_lat::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LAT, PROPERTIES_TBL_PROSPECT_CONTACT:create_time::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_TIME, PROPERTIES_TBL_GUID_PROFILES:guid_to::STRING AS PROPERTIES_TBL_GUID_PROFILES_GUID_TO, PROPERTIES_TBL_GUID_PROFILES:contact_type::STRING AS PROPERTIES_TBL_GUID_PROFILES_CONTACT_TYPE, PROPERTIES_TBL_GUID_PROFILES:is_main::STRING AS PROPERTIES_TBL_GUID_PROFILES_IS_MAIN, PROPERTIES_TBL_GUID_PROFILES:profile_id::STRING AS PROPERTIES_TBL_GUID_PROFILES_PROFILE_ID, PROPERTIES_TBL_GUID_PROFILES:eb_medicaid_npi::STRING AS PROPERTIES_TBL_GUID_PROFILES_EB_MEDICAID_NPI, PROPERTIES_TBL_GUID_PROFILES:order::STRING AS PROPERTIES_TBL_GUID_PROFILES_ORDER, PROPERTIES_TBL_GUID_PROFILES:eb_medicaid_provider_type::STRING AS PROPERTIES_TBL_GUID_PROFILES_EB_MEDICAID_PROVIDER_TYPE, PROPERTIES_TBL_GUID_PROFILES:Op::STRING AS PROPERTIES_TBL_GUID_PROFILES_OP, PROPERTIES_TBL_GUID_PROFILES:is_active::STRING AS PROPERTIES_TBL_GUID_PROFILES_IS_ACTIVE, PROPERTIES_TBL_GUID_PROFILES:is_emergency::STRING AS PROPERTIES_TBL_GUID_PROFILES_IS_EMERGENCY, PROPERTIES_TBL_GUID_PROFILES:is_billing::STRING AS PROPERTIES_TBL_GUID_PROFILES_IS_BILLING, PROPERTIES_TBL_GUID_PROFILES:relationship::STRING AS PROPERTIES_TBL_GUID_PROFILES_RELATIONSHIP, CONTACT_IS_ACTIVE AS CONTACT_IS_ACTIVE, BRANCH_ID AS BRANCH_ID, PROFILE:legacy_id::STRING AS PROFILE_LEGACY_ID, PROFILE:guardian_or_primary_contact_phone_number::STRING AS PROFILE_GUARDIAN_OR_PRIMARY_CONTACT_PHONE_NUMBER, PROFILE:marital_status::STRING AS PROFILE_MARITAL_STATUS, PROFILE:ethnicity::STRING AS PROFILE_ETHNICITY, PROFILE:do_not_hire_::STRING AS PROFILE_DO_NOT_HIRE_, PROFILE:payer_1::STRING AS PROFILE_PAYER_1, PROFILE:address_suite::STRING AS PROFILE_ADDRESS_SUITE, PROFILE:zip::STRING AS PROFILE_ZIP, PROFILE:address::STRING AS PROFILE_ADDRESS, PROFILE:communication_method::STRING AS PROFILE_COMMUNICATION_METHOD, PROFILE:county::STRING AS PROFILE_COUNTY, PROFILE:type_of_caregiver::STRING AS PROFILE_TYPE_OF_CAREGIVER, PROFILE:medicaid_id::STRING AS PROFILE_MEDICAID_ID, PROFILE:ssn::STRING AS PROFILE_SSN, PROFILE:middle_name::STRING AS PROFILE_MIDDLE_NAME, PROFILE:job_title::STRING AS PROFILE_JOB_TITLE, PROFILE:fax::STRING AS PROFILE_FAX, PROFILE:personal_email::STRING AS PROFILE_PERSONAL_EMAIL, PROFILE:phone_main::STRING AS PROFILE_PHONE_MAIN, PROFILE:tellus::STRING AS PROFILE_TELLUS, PROFILE:state::STRING AS PROFILE_STATE, PROFILE:salutation::STRING AS PROFILE_SALUTATION, PROFILE:dataflex_contract_ids::STRING AS PROFILE_DATAFLEX_CONTRACT_IDS, PROFILE:phone_other::STRING AS PROFILE_PHONE_OTHER, PROFILE:last_name::STRING AS PROFILE_LAST_NAME, PROFILE:guardian_or_primary_contact::STRING AS PROFILE_GUARDIAN_OR_PRIMARY_CONTACT, PROFILE:country::STRING AS PROFILE_COUNTRY, PROFILE:company::STRING AS PROFILE_COMPANY, PROFILE:birthday::STRING AS PROFILE_BIRTHDAY, PROFILE:member_id::STRING AS PROFILE_MEMBER_ID, PROFILE:termination_reason::STRING AS PROFILE_TERMINATION_REASON, PROFILE:business_entity_::STRING AS PROFILE_BUSINESS_ENTITY_, PROFILE:uid::STRING AS PROFILE_UID, PROFILE:termination_date::STRING AS PROFILE_TERMINATION_DATE, PROFILE:medicaid_prior_authorization_number::STRING AS PROFILE_MEDICAID_PRIOR_AUTHORIZATION_NUMBER, PROFILE:city::STRING AS PROFILE_CITY, PROFILE:start_date::STRING AS PROFILE_START_DATE, PROFILE:gender::STRING AS PROFILE_GENDER, PROFILE:management_level::STRING AS PROFILE_MANAGEMENT_LEVEL, PROFILE:first_name::STRING AS PROFILE_FIRST_NAME, PROFILE:sandata::STRING AS PROFILE_SANDATA, PROFILE:start_on::STRING AS PROFILE_START_ON, PROFILE:name::STRING AS PROFILE_NAME, PROFILE:email::STRING AS PROFILE_EMAIL, PROFILE:import_id::STRING AS PROFILE_IMPORT_ID, PROFILE:referral_date::STRING AS PROFILE_REFERRAL_DATE, PROFILE:payment_arrangement::STRING AS PROFILE_PAYMENT_ARRANGEMENT, PROFILE:phone_personal::STRING AS PROFILE_PHONE_PERSONAL, PROFILE:job_class::STRING AS PROFILE_JOB_CLASS, PROFILE:remarks::STRING AS PROFILE_REMARKS, PROFILE:company_::STRING AS PROFILE_COMPANY_, PROFILE:state_id::STRING AS PROFILE_STATE_ID, AGE AS AGE, AGE_RANGE AS AGE_RANGE 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_CONTACT;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';