CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_EMPLOYEE_PORTAL()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_EMPLOYEE_PORTAL 
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
	
    INSERT OVERWRITE INTO ALAYACARE.EMPLOYEE_PORTAL (
        ID, CLIENT_ID, EMPLOYEE_ID, EMPLOYEE_ACCESS, LAST_LOGIN)
        SELECT ID AS ID, CLIENT_ID AS CLIENT_ID, EMPLOYEE_ID AS EMPLOYEE_ID, EMPLOYEE_ACCESS AS EMPLOYEE_ACCESS, LAST_LOGIN AS LAST_LOGIN 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_EMPLOYEE_PORTAL;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';