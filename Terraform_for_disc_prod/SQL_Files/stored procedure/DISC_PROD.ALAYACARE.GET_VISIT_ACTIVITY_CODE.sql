CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_VISIT_ACTIVITY_CODE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_VISIT_ACTIVITY_CODE 
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
	
    INSERT OVERWRITE INTO ALAYACARE.VISIT_ACTIVITY_CODE (
        VISIT_ACTIVITY_CODE_ID, VISIT_ACTIVITY_CODE_PROPERTIES, ACTIVITY_CODE_PROPERTIES)
        SELECT VISIT_ACTIVITY_CODE_ID AS VISIT_ACTIVITY_CODE_ID, VISIT_ACTIVITY_CODE_PROPERTIES AS VISIT_ACTIVITY_CODE_PROPERTIES, ACTIVITY_CODE_PROPERTIES AS ACTIVITY_CODE_PROPERTIES
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_VISIT_ACTIVITY_CODE;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';