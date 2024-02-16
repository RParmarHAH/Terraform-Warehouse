CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_GROUPS()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_GROUPS 
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
	
    INSERT OVERWRITE INTO ALAYACARE.GROUPS (
        GROUP_ID, PROFILE_ID, GUID, BRANCH_ID, CREATED_AT, CREATED_BY, UPDATED_AT, UPDATED_BY, PROFILE_COMPANY, PROFILE_REMARKS, PROPERTIES_ID, PROPERTIES_GUID, PROPERTIES_IDMASTERACCOUNT, PROPERTIES_UPDATE_TIME, PROPERTIES_GEOFENCE, PROPERTIES_IDPROFILE, PROPERTIES_IDSTATUS, PROPERTIES_CREATE_TIME, PROPERTIES_IDACCOUNTTYPE, PROPERTIES_DESCRIPTION, PROPERTIES_DISPLAY_ID, PROPERTIES_PHONE, PROPERTIES_OP)
        SELECT GROUP_ID AS GROUP_ID, PROFILE_ID AS PROFILE_ID, GUID AS GUID, BRANCH_ID AS BRANCH_ID, CREATED_AT AS CREATED_AT, CREATED_BY AS CREATED_BY, UPDATED_AT AS UPDATED_AT, UPDATED_BY AS UPDATED_BY, PROFILE:company::STRING AS PROFILE_COMPANY, PROFILE:remarks::STRING AS PROFILE_REMARKS, PROPERTIES:id::STRING AS PROPERTIES_ID, PROPERTIES:guid::STRING AS PROPERTIES_GUID, PROPERTIES:idmasteraccount::STRING AS PROPERTIES_IDMASTERACCOUNT, PROPERTIES:update_time::STRING AS PROPERTIES_UPDATE_TIME, PROPERTIES:geofence::STRING AS PROPERTIES_GEOFENCE, PROPERTIES:idprofile::STRING AS PROPERTIES_IDPROFILE, PROPERTIES:idstatus::STRING AS PROPERTIES_IDSTATUS, PROPERTIES:create_time::STRING AS PROPERTIES_CREATE_TIME, PROPERTIES:idaccounttype::STRING AS PROPERTIES_IDACCOUNTTYPE, PROPERTIES:description::STRING AS PROPERTIES_DESCRIPTION, PROPERTIES:display_id::STRING AS PROPERTIES_DISPLAY_ID, PROPERTIES:phone::STRING AS PROPERTIES_PHONE, PROPERTIES:Op::STRING AS PROPERTIES_OP 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_GROUP;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';