CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_VITAL()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_VITAL 
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
	
    INSERT OVERWRITE INTO ALAYACARE.VITAL (
        VITAL_ID, CLIENT_ID, EMPLOYEE_GUID, EMPLOYEE_ID, VITAL_NAME, VITAL_GROUP_NAME, VITAL_SOURCE, VITAL_OPTIONS, VITAL_UNIT, VITAL_COMMENTS, VITAL_MEASUREMENT, VITAL_CREATED_AT)
        SELECT VITAL_ID AS VITAL_ID, CLIENT_ID AS CLIENT_ID, EMPLOYEE_GUID AS EMPLOYEE_GUID, EMPLOYEE_ID AS EMPLOYEE_ID, VITAL_NAME AS VITAL_NAME, VITAL_GROUP_NAME AS VITAL_GROUP_NAME, VITAL_SOURCE AS VITAL_SOURCE, VITAL_OPTIONS AS VITAL_OPTIONS, VITAL_UNIT AS VITAL_UNIT, VITAL_COMMENTS AS VITAL_COMMENTS, VITAL_MEASUREMENT AS VITAL_MEASUREMENT, VITAL_CREATED_AT AS VITAL_CREATED_AT 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_VITAL;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';