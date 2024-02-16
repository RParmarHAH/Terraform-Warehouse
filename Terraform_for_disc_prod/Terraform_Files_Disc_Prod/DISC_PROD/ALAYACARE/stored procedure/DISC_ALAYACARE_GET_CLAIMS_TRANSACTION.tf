resource "snowflake_procedure" "DISC_ALAYACARE_GET_CLAIMS_TRANSACTION" {
	name ="GET_CLAIMS_TRANSACTION"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_CLAIMS_TRANSACTION 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                			NOTES:
-- ----------  		-------------------   			-----------------------------------------------------------------------------------------------
-- 2023-11-24		KOMAL DHOKAI/RAVI SUTHAR		INITIAL DEVELOPMENT
--*****************************************************************************************************************************
    return_result varchar(1000);
BEGIN
	
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ALAYACARE.CLAIMS_TRANSACTION (
        MAIN_TRANSACTION_ID ,MAIN_TRANSACTION_POSTING_DATE ,PAYMENT_METHOD_TYPE ,MAIN_TRANSACTION_AMOUNT ,MAIN_TRANSACTION_MEMO )
        SELECT MAIN_TRANSACTION_ID AS MAIN_TRANSACTION_ID, MAIN_TRANSACTION_POSTING_DATE AS MAIN_TRANSACTION_POSTING_DATE, PAYMENT_METHOD_TYPE AS PAYMENT_METHOD_TYPE, MAIN_TRANSACTION_AMOUNT AS MAIN_TRANSACTION_AMOUNT, MAIN_TRANSACTION_MEMO AS MAIN_TRANSACTION_MEMO
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_CLAIMS_TRANSACTION;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

