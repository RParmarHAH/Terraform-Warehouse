CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_EMPLOYEE_RULE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_EMPLOYEE_RULE 
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
	
    INSERT OVERWRITE INTO ALAYACARE.EMPLOYEE_RULE (
        RULE_ID, EMPLOYEE_ID, TYPE, START_AT, END_AT, DESCRIPTION, DURATION_PAID, RRULE, TIMEOFF_TYPE, DAYDIFF, EMPLOYEE_EMAIL)
        SELECT RULE_ID AS RULE_ID, EMPLOYEE_ID AS EMPLOYEE_ID, TYPE AS TYPE, START_AT AS START_AT, END_AT AS END_AT, DESCRIPTION AS DESCRIPTION, DURATION_PAID AS DURATION_PAID, RRULE AS RRULE, TIMEOFF_TYPE AS TIMEOFF_TYPE, DAYDIFF AS DAYDIFF, EMPLOYEE_EMAIL AS EMPLOYEE_EMAIL 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_EMPLOYEE_RULE;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';