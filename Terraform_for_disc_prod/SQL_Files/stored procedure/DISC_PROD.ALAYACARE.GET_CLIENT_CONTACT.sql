CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_CLIENT_CONTACT()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_CLIENT_CONTACT 
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
	
    INSERT OVERWRITE INTO ALAYACARE.CLIENT_CONTACT (
        LAKE_ID, CONTACT_ID, CONTACT_GUID_TO, CREATED_AT, PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_USER_ID, PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LAT, PROPERTIES_TBL_PROSPECT_CONTACT_OP, PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_TIME, PROPERTIES_TBL_PROSPECT_CONTACT_VERSION, PROPERTIES_TBL_PROSPECT_CONTACT_LIST_ID, PROPERTIES_TBL_PROSPECT_CONTACT_ADDRESS_VALID, PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_USER_ID, PROPERTIES_TBL_PROSPECT_CONTACT_GUID, PROPERTIES_TBL_PROSPECT_CONTACT_GEO_CODED, PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_TIME, PROPERTIES_TBL_PROSPECT_CONTACT_ID, PROPERTIES_TBL_PROSPECT_CONTACT_FULLTEXT_INDEX, PROPERTIES_TBL_PROSPECT_CONTACT_IDACCOUNT, PROPERTIES_TBL_PROSPECT_CONTACT_IS_ACTIVE, PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LON, PROPERTIES_TBL_PROSPECT_CONTACT_DEPRECATED_GUID_TO, PROPERTIES_TBL_GUID_PROFILES_OP, PROPERTIES_TBL_GUID_PROFILES_PROFILE_ID, PROPERTIES_TBL_GUID_PROFILES_CONTACT_TYPE, PROPERTIES_TBL_GUID_PROFILES_IS_EMERGENCY, PROPERTIES_TBL_GUID_PROFILES_IS_BILLING, PROPERTIES_TBL_GUID_PROFILES_GUID_TO, PROPERTIES_TBL_GUID_PROFILES_RELATIONSHIP, PROPERTIES_TBL_GUID_PROFILES_IS_ACTIVE, PROPERTIES_TBL_GUID_PROFILES_IS_MAIN, CONTACT_IS_ACTIVE, BRANCH_ID, PROFILE_PHONE_OTHER, PROFILE_CITY, PROFILE_SALUTATION, PROFILE_LEGACY_ID, PROFILE_COUNTY, PROFILE_MARITAL_STATUS, PROFILE_SSN, PROFILE_PHONE_PERSONAL, PROFILE_FIRST_NAME, PROFILE_COUNTRY, PROFILE_TERMINATION_DATE, PROFILE_PERSONAL_EMAIL, PROFILE_ADDRESS, PROFILE_DO_NOT_HIRE_, PROFILE_ADDRESS_SUITE, PROFILE_STATE, PROFILE_IMPORT_ID, PROFILE_ZIP, PROFILE_BIRTHDAY, PROFILE_LAST_NAME, PROFILE_REMARKS, PROFILE_START_DATE, PROFILE_BUSINESS_ENTITY_, PROFILE_JOB_TITLE, PROFILE_TYPE_OF_CAREGIVER, PROFILE_UID, PROFILE_JOB_CLASS, PROFILE_PHONE_MAIN, PROFILE_EMAIL, PROFILE_ETHNICITY, PROFILE_GENDER, AGE, AGE_RANGE)
        SELECT LAKE_ID AS LAKE_ID, CONTACT_ID AS CONTACT_ID, CONTACT_GUID_TO AS CONTACT_GUID_TO, CREATED_AT AS CREATED_AT, PROPERTIES_TBL_PROSPECT_CONTACT:create_user_id::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_USER_ID, PROPERTIES_TBL_PROSPECT_CONTACT:geo_lat::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LAT, PROPERTIES_TBL_PROSPECT_CONTACT:Op::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_OP, PROPERTIES_TBL_PROSPECT_CONTACT:update_time::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_TIME, PROPERTIES_TBL_PROSPECT_CONTACT:version::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_VERSION, PROPERTIES_TBL_PROSPECT_CONTACT:list_id::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_LIST_ID, PROPERTIES_TBL_PROSPECT_CONTACT:address_valid::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_ADDRESS_VALID, PROPERTIES_TBL_PROSPECT_CONTACT:update_user_id::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_UPDATE_USER_ID, PROPERTIES_TBL_PROSPECT_CONTACT:guid::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_GUID, PROPERTIES_TBL_PROSPECT_CONTACT:geo_coded::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_GEO_CODED, PROPERTIES_TBL_PROSPECT_CONTACT:create_time::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_CREATE_TIME, PROPERTIES_TBL_PROSPECT_CONTACT:id::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_ID, PROPERTIES_TBL_PROSPECT_CONTACT:fulltext_index::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_FULLTEXT_INDEX, PROPERTIES_TBL_PROSPECT_CONTACT:idaccount::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_IDACCOUNT, PROPERTIES_TBL_PROSPECT_CONTACT:is_active::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_IS_ACTIVE, PROPERTIES_TBL_PROSPECT_CONTACT:geo_lon::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_GEO_LON, PROPERTIES_TBL_PROSPECT_CONTACT:deprecated_guid_to::STRING AS PROPERTIES_TBL_PROSPECT_CONTACT_DEPRECATED_GUID_TO, PROPERTIES_TBL_GUID_PROFILES:Op::STRING AS PROPERTIES_TBL_GUID_PROFILES_OP, PROPERTIES_TBL_GUID_PROFILES:profile_id::STRING AS PROPERTIES_TBL_GUID_PROFILES_PROFILE_ID, PROPERTIES_TBL_GUID_PROFILES:contact_type::STRING AS PROPERTIES_TBL_GUID_PROFILES_CONTACT_TYPE, PROPERTIES_TBL_GUID_PROFILES:is_emergency::STRING AS PROPERTIES_TBL_GUID_PROFILES_IS_EMERGENCY, PROPERTIES_TBL_GUID_PROFILES:is_billing::STRING AS PROPERTIES_TBL_GUID_PROFILES_IS_BILLING, PROPERTIES_TBL_GUID_PROFILES:guid_to::STRING AS PROPERTIES_TBL_GUID_PROFILES_GUID_TO, PROPERTIES_TBL_GUID_PROFILES:relationship::STRING AS PROPERTIES_TBL_GUID_PROFILES_RELATIONSHIP, PROPERTIES_TBL_GUID_PROFILES:is_active::STRING AS PROPERTIES_TBL_GUID_PROFILES_IS_ACTIVE, PROPERTIES_TBL_GUID_PROFILES:is_main::STRING AS PROPERTIES_TBL_GUID_PROFILES_IS_MAIN, CONTACT_IS_ACTIVE AS CONTACT_IS_ACTIVE, BRANCH_ID AS BRANCH_ID, PROFILE:phone_other::STRING AS PROFILE_PHONE_OTHER, PROFILE:city::STRING AS PROFILE_CITY, PROFILE:salutation::STRING AS PROFILE_SALUTATION, PROFILE:legacy_id::STRING AS PROFILE_LEGACY_ID, PROFILE:county::STRING AS PROFILE_COUNTY, PROFILE:marital_status::STRING AS PROFILE_MARITAL_STATUS, PROFILE:ssn::STRING AS PROFILE_SSN, PROFILE:phone_personal::STRING AS PROFILE_PHONE_PERSONAL, PROFILE:first_name::STRING AS PROFILE_FIRST_NAME, PROFILE:country::STRING AS PROFILE_COUNTRY, PROFILE:termination_date::STRING AS PROFILE_TERMINATION_DATE, PROFILE:personal_email::STRING AS PROFILE_PERSONAL_EMAIL, PROFILE:address::STRING AS PROFILE_ADDRESS, PROFILE:do_not_hire_::STRING AS PROFILE_DO_NOT_HIRE_, PROFILE:address_suite::STRING AS PROFILE_ADDRESS_SUITE, PROFILE:state::STRING AS PROFILE_STATE, PROFILE:import_id::STRING AS PROFILE_IMPORT_ID, PROFILE:zip::STRING AS PROFILE_ZIP, PROFILE:birthday::STRING AS PROFILE_BIRTHDAY, PROFILE:last_name::STRING AS PROFILE_LAST_NAME, PROFILE:remarks::STRING AS PROFILE_REMARKS, PROFILE:start_date::STRING AS PROFILE_START_DATE, PROFILE:business_entity_::STRING AS PROFILE_BUSINESS_ENTITY_, PROFILE:job_title::STRING AS PROFILE_JOB_TITLE, PROFILE:type_of_caregiver::STRING AS PROFILE_TYPE_OF_CAREGIVER, PROFILE:uid::STRING AS PROFILE_UID, PROFILE:job_class::STRING AS PROFILE_JOB_CLASS, PROFILE:phone_main::STRING AS PROFILE_PHONE_MAIN, PROFILE:email::STRING AS PROFILE_EMAIL, PROFILE:ethnicity::STRING AS PROFILE_ETHNICITY, PROFILE:gender::STRING AS PROFILE_GENDER, AGE AS AGE, AGE_RANGE AS AGE_RANGE 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_CLIENT_CONTACT;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';