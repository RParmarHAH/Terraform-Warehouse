CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_GEOMAP()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_GEOMAP 
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
	
    INSERT OVERWRITE INTO ALAYACARE.GEOMAP (
        ID, EMPLOYEE_ID, CLIENT_ID, SERVICE_ID, ENTITY_TYPE, ENTITY_ADDRESS, ENTITY_STATUS, BRANCH_ID)
        SELECT ID AS ID, EMPLOYEE_ID AS EMPLOYEE_ID, CLIENT_ID AS CLIENT_ID, SERVICE_ID AS SERVICE_ID, ENTITY_TYPE AS ENTITY_TYPE, ENTITY_ADDRESS AS ENTITY_ADDRESS, ENTITY_STATUS AS ENTITY_STATUS, BRANCH_ID AS BRANCH_ID 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_GEOMAP;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';