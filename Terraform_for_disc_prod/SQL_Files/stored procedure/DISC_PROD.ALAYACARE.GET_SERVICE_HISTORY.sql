CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_SERVICE_HISTORY()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_SERVICE_HISTORY 
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
	
    INSERT OVERWRITE INTO ALAYACARE.SERVICE_HISTORY (
        SERVICE_ID
        , SERVICE_CLIENT_ID, SERVICE_BILL_CODE_ID, STATUS_HISTORICAL, STATUS_REASON, CREATE_DATE, REVISION_ID, REVISION_FROM, REVISION_UNTIL, LENGTH_OF_STAY, BRANCH_ID, SERVICE_FACILITY, SERVICE_ASSIGNED_EMPLOYEE_ID, SERVICE_BILLING_CONTACT_ID)
        SELECT SERVICE_ID AS SERVICE_ID
        , CASE WHEN SERVICE_CLIENT_ID = '''' THEN NULL ELSE SERVICE_CLIENT_ID END AS SERVICE_CLIENT_ID
        , CASE WHEN SERVICE_BILL_CODE_ID = '''' THEN NULL ELSE SERVICE_BILL_CODE_ID END AS SERVICE_BILL_CODE_ID
        , STATUS_HISTORICAL AS STATUS_HISTORICAL, STATUS_REASON AS STATUS_REASON, CREATE_DATE AS CREATE_DATE, REVISION_ID AS REVISION_ID, REVISION_FROM AS REVISION_FROM, REVISION_UNTIL AS REVISION_UNTIL, LENGTH_OF_STAY AS LENGTH_OF_STAY, BRANCH_ID AS BRANCH_ID
        , CASE WHEN SERVICE_FACILITY = '''' THEN NULL ELSE SERVICE_FACILITY END AS SERVICE_FACILITY
        , CASE WHEN SERVICE_ASSIGNED_EMPLOYEE_ID = '''' THEN NULL ELSE SERVICE_ASSIGNED_EMPLOYEE_ID END AS SERVICE_ASSIGNED_EMPLOYEE_ID
        , CASE WHEN SERVICE_BILLING_CONTACT_ID = '''' THEN NULL ELSE SERVICE_BILLING_CONTACT_ID END AS SERVICE_BILLING_CONTACT_ID 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_SERVICE_HISTORY;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';