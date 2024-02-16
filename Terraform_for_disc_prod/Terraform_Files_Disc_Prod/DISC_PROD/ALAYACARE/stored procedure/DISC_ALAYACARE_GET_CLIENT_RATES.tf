resource "snowflake_procedure" "DISC_ALAYACARE_GET_CLIENT_RATES" {
	name ="GET_CLIENT_RATES"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_CLIENT_RATES 
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
	
    INSERT OVERWRITE INTO ALAYACARE.CLIENT_RATES (
        RATE_ID, CLIENT_ID, BILL_CODE, BILL_CODE_DESCRIPTION, FUNDER_CODE, BILLITEM_ID, BILL_CODE_SPECIAL_RATE, IS_DISABLED, BILL_CODE_ACTUAL_RATE, BILL_CODE_ACTUAL_START_DATE, BILL_CODE_SPECIAL_RATE_START_DATE)
        SELECT RATE_ID AS RATE_ID, CLIENT_ID AS CLIENT_ID, BILL_CODE AS BILL_CODE, BILL_CODE_DESCRIPTION AS BILL_CODE_DESCRIPTION, FUNDER_CODE AS FUNDER_CODE, BILLITEM_ID AS BILLITEM_ID, BILL_CODE_SPECIAL_RATE AS BILL_CODE_SPECIAL_RATE, IS_DISABLED AS IS_DISABLED, BILL_CODE_ACTUAL_RATE AS BILL_CODE_ACTUAL_RATE, BILL_CODE_ACTUAL_START_DATE AS BILL_CODE_ACTUAL_START_DATE, BILL_CODE_SPECIAL_RATE_START_DATE AS BILL_CODE_SPECIAL_RATE_START_DATE 
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_CLIENT_RATES;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

