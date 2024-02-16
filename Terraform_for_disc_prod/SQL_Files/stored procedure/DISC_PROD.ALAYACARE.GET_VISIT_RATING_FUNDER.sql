CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_VISIT_RATING_FUNDER()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_VISIT_RATING_FUNDER 
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
	
    INSERT OVERWRITE INTO ALAYACARE.VISIT_RATING_FUNDER
	SELECT PK_ID,	ID,	FUNDER_ID,	PERCENTAGE,	IS_PRIMARY,	BILLCODE_ID,	VISIT_ID,	SERVICE_ID,	CONTACT_ID,	PROGRAM_ID,	PROGRAM_NAME
FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_VISIT_RATING_FUNDER;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';