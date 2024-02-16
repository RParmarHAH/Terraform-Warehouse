CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_INVOICE_TAXES()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_INVOICE_TAXES 
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
	
    INSERT OVERWRITE INTO ALAYACARE.INVOICE_TAXES (
        INVOICE_ITEM_ID, TAX_NAME_1, TAX_AMOUNT_1, TAX_NAME_2, TAX_AMOUNT_2, TAX_NAME_3, TAX_AMOUNT_3)
        SELECT INVOICE_ITEM_ID AS INVOICE_ITEM_ID, TAX_NAME_1 AS TAX_NAME_1, TAX_AMOUNT_1 AS TAX_AMOUNT_1, TAX_NAME_2 AS TAX_NAME_2, TAX_AMOUNT_2 AS TAX_AMOUNT_2, TAX_NAME_3 AS TAX_NAME_3, TAX_AMOUNT_3 AS TAX_AMOUNT_3 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_INVOICE_TAXES;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';