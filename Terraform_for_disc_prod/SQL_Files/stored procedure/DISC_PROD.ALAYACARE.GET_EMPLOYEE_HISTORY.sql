CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_EMPLOYEE_HISTORY()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_EMPLOYEE_HISTORY 
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
	
    INSERT OVERWRITE INTO ALAYACARE.EMPLOYEE_HISTORY (
        EMPLOYEE_ID, STATUS_HISTORICAL, CREATE_DATE, REVISION_ID, REVISION_FROM, REVISION_UNTIL, STATUS_DAYS, BRANCH_ID)
        SELECT EMPLOYEE_ID AS EMPLOYEE_ID, STATUS_HISTORICAL AS STATUS_HISTORICAL, CREATE_DATE AS CREATE_DATE, REVISION_ID AS REVISION_ID, REVISION_FROM AS REVISION_FROM, REVISION_UNTIL AS REVISION_UNTIL, STATUS_DAYS AS STATUS_DAYS, BRANCH_ID AS BRANCH_ID 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_EMPLOYEE_HISTORY;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';