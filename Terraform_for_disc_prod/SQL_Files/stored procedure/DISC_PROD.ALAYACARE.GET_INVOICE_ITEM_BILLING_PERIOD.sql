CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_INVOICE_ITEM_BILLING_PERIOD()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_INVOICE_ITEM_BILLING_PERIOD 
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
	
    INSERT OVERWRITE INTO ALAYACARE.INVOICE_ITEM_BILLING_PERIOD (
        INVOICE_ITEM_ID, INVOICE_ITEM_GUID_TO, INVOICE_POSTING_DATE, BILLINGPERIOD_ID)
        SELECT INVOICE_ITEM_ID AS INVOICE_ITEM_ID, INVOICE_ITEM_GUID_TO AS INVOICE_ITEM_GUID_TO, INVOICE_POSTING_DATE AS INVOICE_POSTING_DATE, BILLINGPERIOD_ID AS BILLINGPERIOD_ID 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_INVOICE_ITEM_BILLING_PERIOD;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';