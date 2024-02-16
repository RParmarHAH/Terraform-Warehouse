CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_PAYCODE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_PAYCODE 
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
	
    INSERT OVERWRITE INTO ALAYACARE.PAYCODE (
        PAYCODE_ID, CODE, DESCRIPTION, EXTERNAL_ID, TYPE, UNITS, IS_DISABLED, CREATE_TIME, UPDATE_TIME, DISABLED_TIME, PROPERTIES_TYPE, PROPERTIES_DESCRIPTION, PROPERTIES_GUID, PROPERTIES_OP, PROPERTIES_UNITS, PROPERTIES_IS_DISABLED, PROPERTIES_IDMASTERACCOUNT, PROPERTIES_UPDATE_TIME, PROPERTIES_UPDATE_USER_ID, PROPERTIES_ID, PROPERTIES_CREATE_TIME, PROPERTIES_CODE, PROPERTIES_CREATE_USER_ID, PROPERTIES_EXTERNAL_ID)
        SELECT PAYCODE_ID AS PAYCODE_ID, CODE AS CODE, DESCRIPTION AS DESCRIPTION, EXTERNAL_ID AS EXTERNAL_ID, TYPE AS TYPE, UNITS AS UNITS, IS_DISABLED AS IS_DISABLED, CREATE_TIME AS CREATE_TIME, UPDATE_TIME AS UPDATE_TIME, DISABLED_TIME AS DISABLED_TIME, PROPERTIES:type::STRING AS PROPERTIES_TYPE, PROPERTIES:description::STRING AS PROPERTIES_DESCRIPTION, PROPERTIES:guid::STRING AS PROPERTIES_GUID, PROPERTIES:Op::STRING AS PROPERTIES_OP, PROPERTIES:units::STRING AS PROPERTIES_UNITS, PROPERTIES:is_disabled::STRING AS PROPERTIES_IS_DISABLED, PROPERTIES:idmasteraccount::STRING AS PROPERTIES_IDMASTERACCOUNT, PROPERTIES:update_time::STRING AS PROPERTIES_UPDATE_TIME, PROPERTIES:update_user_id::STRING AS PROPERTIES_UPDATE_USER_ID, PROPERTIES:id::STRING AS PROPERTIES_ID, PROPERTIES:create_time::STRING AS PROPERTIES_CREATE_TIME, PROPERTIES:code::STRING AS PROPERTIES_CODE, PROPERTIES:create_user_id::STRING AS PROPERTIES_CREATE_USER_ID, PROPERTIES:external_id::STRING AS PROPERTIES_EXTERNAL_ID 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_PAYCODE;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';