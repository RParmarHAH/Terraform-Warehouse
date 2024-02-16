CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_CLIENT_CARE_PLAN()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_CLIENT_CARE_PLAN 
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
	
    INSERT OVERWRITE INTO ALAYACARE.CLIENT_CARE_PLAN (
        CLIENT_ID, NAME, COMPLETED, CREATION_DATE, CREATION_USER, COMPLETION_DATE, COMPLETION_USER, TYPE)
        SELECT CLIENT_ID AS CLIENT_ID, NAME AS NAME, COMPLETED AS COMPLETED, CREATION_DATE AS CREATION_DATE, CREATION_USER AS CREATION_USER, COMPLETION_DATE AS COMPLETION_DATE, COMPLETION_USER AS COMPLETION_USER, TYPE AS TYPE 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_CLIENT_CARE_PLAN;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';