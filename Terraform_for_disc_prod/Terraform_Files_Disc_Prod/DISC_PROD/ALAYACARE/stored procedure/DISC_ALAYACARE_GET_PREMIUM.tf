resource "snowflake_procedure" "DISC_ALAYACARE_GET_PREMIUM" {
	name ="GET_PREMIUM"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_PREMIUM 
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
	
    INSERT OVERWRITE INTO ALAYACARE.PREMIUM
	SELECT PREMIUM_ID,	PREMIUM_CODE,	PREMIUM_CREATION_DATE,	PREMIUM_REVISION_DATE,	GUID,	
PROPERTIES_TBL_PREMIUMS[''Op'']::VARCHAR(35) AS PROPERTIES_TBL_PREMIUMS_OP,
PROPERTIES_TBL_PREMIUMS[''code'']::VARCHAR(99) AS PROPERTIES_TBL_PREMIUMS_CODE,
PROPERTIES_TBL_PREMIUMS[''create_time'']::VARCHAR(35) AS PROPERTIES_TBL_PREMIUMS_CREATE_TIME,
PROPERTIES_TBL_PREMIUMS[''create_user_id'']::VARCHAR(35) AS PROPERTIES_TBL_PREMIUMS_CREATE_USER_ID,
PROPERTIES_TBL_PREMIUMS[''guid'']::VARCHAR(35) AS PROPERTIES_TBL_PREMIUMS_GUID,
PROPERTIES_TBL_PREMIUMS[''id'']::VARCHAR(35) AS PROPERTIES_TBL_PREMIUMS_ID,
PROPERTIES_TBL_PREMIUMS[''idmasteraccount'']::VARCHAR(35) AS PROPERTIES_TBL_PREMIUMS_IDMASTERACCOUNT,
PROPERTIES_TBL_PREMIUMS[''pay_code_id'']::VARCHAR(35) AS PROPERTIES_TBL_PREMIUMS_PAY_CODE_ID,
PROPERTIES_TBL_PREMIUMS[''rule'']::VARCHAR(35) AS PROPERTIES_TBL_PREMIUMS_RULE,
PROPERTIES_TBL_PREMIUMS[''rule_data'']::VARCHAR(16777216) AS PROPERTIES_TBL_PREMIUMS_RULE_DATA,
PROPERTIES_TBL_PREMIUMS[''update_time'']::VARCHAR(35) AS PROPERTIES_TBL_PREMIUMS_UPDATE_TIME,
PROPERTIES_TBL_PREMIUMS[''update_user_id'']::VARCHAR(35) AS PROPERTIES_TBL_PREMIUMS_UPDATE_USER_ID,
PREMIUM_PAY_CODE,	PREMIUM_PAY_CODE_DESCRIPTION,	PREMIUM_PAY_CODE_RATE
FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_PREMIUM;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

