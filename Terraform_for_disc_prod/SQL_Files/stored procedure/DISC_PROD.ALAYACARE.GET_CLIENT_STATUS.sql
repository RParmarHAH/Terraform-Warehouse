CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_CLIENT_STATUS()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_CLIENT_STATUS 
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
	
    INSERT OVERWRITE INTO ALAYACARE.CLIENT_STATUS (
        ID, CLIENT_ID, CLIENT_STATUS, EFFECTIVE_DATE, EFFECTIVE_DATE_TO, REASON_CODE, CREATION_DATE, REVISION_DATE, EMPLOYEE_CREATE_ID, EMPLOYEE_UPDATE_ID, SEQ, BRANCH_ID)
        SELECT ID AS ID, CLIENT_ID AS CLIENT_ID, CLIENT_STATUS AS CLIENT_STATUS, EFFECTIVE_DATE AS EFFECTIVE_DATE, EFFECTIVE_DATE_TO AS EFFECTIVE_DATE_TO, REASON_CODE AS REASON_CODE, CREATION_DATE AS CREATION_DATE, REVISION_DATE AS REVISION_DATE, EMPLOYEE_CREATE_ID AS EMPLOYEE_CREATE_ID, EMPLOYEE_UPDATE_ID AS EMPLOYEE_UPDATE_ID, SEQ AS SEQ, BRANCH_ID AS BRANCH_ID 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_CLIENT_STATUS;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';