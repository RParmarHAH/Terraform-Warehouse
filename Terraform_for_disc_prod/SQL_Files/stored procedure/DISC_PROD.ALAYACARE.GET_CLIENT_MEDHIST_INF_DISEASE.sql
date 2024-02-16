CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_CLIENT_MEDHIST_INF_DISEASE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_CLIENT_MEDHIST_INF_DISEASE 
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
	
    INSERT OVERWRITE INTO ALAYACARE.CLIENT_MEDHIST_INF_DISEASE (
        CLIENT_ID, DISEASE, NOTES, START_DATE, END_DATE)
        SELECT CLIENT_ID AS CLIENT_ID, DISEASE AS DISEASE, NOTES AS NOTES, START_DATE AS START_DATE, END_DATE AS END_DATE 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_CLIENT_MEDHIST_INF_DISEASE;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';