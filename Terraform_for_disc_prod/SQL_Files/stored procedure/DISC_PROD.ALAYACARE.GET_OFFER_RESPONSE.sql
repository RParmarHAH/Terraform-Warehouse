CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_OFFER_RESPONSE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_OFFER_RESPONSE 
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
	
    INSERT OVERWRITE INTO ALAYACARE.OFFER_RESPONSE  
	SELECT RESP_ID,	OFFER_ID,	OFFER_GUID_TO,	OFFER_STATUS_UPDATE_EMPLOYEE_ID,	OFFER_CREATION_EMPLOYEE_ID,	RESP_EMPLOYEE_ID,	RESP_UPDATE_EMPLOYEE_ID,	OFFER_DUE_DATE_ID,	OFFER_STATUS_UPDATE_DATE_ID,	OFFER_CREATION_DATE_ID,	RESP_UPDATE_DATE_ID,	OFFER_STATUS,	RESP_COMMENT,	RESP_ACTIVE,	RESP_STATUS,	RESP_RECEIVED,	REC_START_DATE
FROM  ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_OFFER_RESPONSE;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';