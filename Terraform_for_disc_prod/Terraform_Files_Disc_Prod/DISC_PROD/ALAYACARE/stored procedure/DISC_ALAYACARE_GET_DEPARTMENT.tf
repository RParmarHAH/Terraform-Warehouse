resource "snowflake_procedure" "DISC_ALAYACARE_GET_DEPARTMENT" {
	name ="GET_DEPARTMENT"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_DEPARTMENT 
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
	
    INSERT OVERWRITE INTO ALAYACARE.DEPARTMENT (
        DEPARTMENT_ID, PROFILE_ID, GUID, BRANCH_ID, CREATED_AT, CREATED_BY, UPDATED_AT, UPDATED_BY,
		PROFILE_COMPANY, PROFILE_PHONE_MAIN, PROFILE_REMARKS, 
		PROPERTIES_CREATE_TIME, PROPERTIES_CREATE_USER_ID, PROPERTIES_DESCRIPTION, PROPERTIES_DISPLAY_ID, PROPERTIES_GEOFENCE, PROPERTIES_GUID, PROPERTIES_ID, PROPERTIES_IDACCOUNTTYPE, PROPERTIES_IDMASTERACCOUNT, PROPERTIES_IDPROFILE, PROPERTIES_PHONE, PROPERTIES_UPDATE_TIME, PROPERTIES_UPDATE_USER_ID)
        SELECT DEPARTMENT_ID AS DEPARTMENT_ID, PROFILE_ID AS PROFILE_ID, GUID AS GUID, BRANCH_ID AS BRANCH_ID, CREATED_AT AS CREATED_AT, CREATED_BY AS CREATED_BY, UPDATED_AT AS UPDATED_AT, UPDATED_BY AS UPDATED_BY,
			PROFILE:company::STRING AS PROFILE_COMPANY, PROFILE:phone_main::STRING AS PROFILE_PHONE_MAIN, PROFILE:remarks::STRING AS PROFILE_REMARKS, 
			PROPERTIES:create_time::STRING AS PROPERTIES_CREATE_TIME, PROPERTIES:create_user_id::STRING AS PROPERTIES_CREATE_USER_ID, PROPERTIES:description::STRING AS PROPERTIES_DESCRIPTION, PROPERTIES:display_id::STRING AS PROPERTIES_DISPLAY_ID, PROPERTIES:geofence::STRING AS PROPERTIES_GEOFENCE, PROPERTIES:guid::STRING AS PROPERTIES_GUID, PROPERTIES:id::STRING AS PROPERTIES_ID, PROPERTIES:idaccounttype::STRING AS PROPERTIES_IDACCOUNTTYPE, PROPERTIES:idmasteraccount::STRING AS PROPERTIES_IDMASTERACCOUNT, PROPERTIES:idprofile::STRING AS PROPERTIES_IDPROFILE, PROPERTIES:phone::STRING AS PROPERTIES_PHONE, PROPERTIES:update_time::STRING AS PROPERTIES_UPDATE_TIME, PROPERTIES:update_user_id::STRING AS PROPERTIES_UPDATE_USER_ID
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_DEPARTMENT;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

