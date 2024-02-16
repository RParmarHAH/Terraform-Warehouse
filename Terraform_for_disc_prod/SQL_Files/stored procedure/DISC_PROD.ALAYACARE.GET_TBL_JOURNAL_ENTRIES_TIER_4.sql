CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_TBL_JOURNAL_ENTRIES_TIER_4()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_TBL_JOURNAL_ENTRIES_TIER_4 
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
	
INSERT OVERWRITE INTO ALAYACARE.TBL_JOURNAL_ENTRIES_TIER_4
SELECT
ID ,GUID_TO,BRANCH_ID ,NOTE_TYPE ,CREATE_TIME ,UPDATE_TIME ,PROPERTIES ,
PROPERTIES[''Op'']::VARCHAR(500) AS PROPERTIES_OP,
PROPERTIES[''content'']::VARCHAR(16777216) AS PROPERTIES_CONTENT,
PROPERTIES[''create_user_id'']::VARCHAR(100) AS PROPERTIES_CREATE_USER_ID,
PROPERTIES[''created_at'']::VARCHAR(100) AS PROPERTIES_CREATED_AT ,
PROPERTIES[''is_client_coordinator_note'']::VARCHAR(100) AS PROPERTIES_IS_CLIENT_COORDINATOR_NOTE ,
PROPERTIES[''status''] ::VARCHAR(100) AS PROPERTIES_STATUS,
PROPERTIES[''type''] ::VARCHAR(100) AS PROPERTIES_TYPE,
PROPERTIES[''update_user_id'']::VARCHAR(100) AS PROPERTIES_UPDATE_USER_ID,
PROPERTIES[''updated_at'']::VARCHAR(100) AS PROPERTIES_UPDATED_AT
FROM
ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_TBL_JOURNAL_ENTRIES_TIER_4;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';