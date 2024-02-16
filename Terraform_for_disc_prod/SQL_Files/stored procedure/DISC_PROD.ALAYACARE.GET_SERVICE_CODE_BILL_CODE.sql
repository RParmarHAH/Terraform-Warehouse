CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_SERVICE_CODE_BILL_CODE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_SERVICE_CODE_BILL_CODE 
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
	
    INSERT OVERWRITE INTO ALAYACARE.SERVICE_CODE_BILL_CODE (
        SERVICE_CODE_ID, BILL_CODE_ID, FUNDER_ID)
        SELECT SERVICE_CODE_ID AS SERVICE_CODE_ID, BILL_CODE_ID AS BILL_CODE_ID, FUNDER_ID AS FUNDER_ID 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_SERVICE_CODE_BILL_CODE;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';