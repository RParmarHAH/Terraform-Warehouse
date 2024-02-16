resource "snowflake_procedure" "DISC_ALAYACARE_GET_VISIT_ACTIVITY_CODE" {
	name ="GET_VISIT_ACTIVITY_CODE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_VISIT_ACTIVITY_CODE 
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
	
    INSERT OVERWRITE INTO ALAYACARE.VISIT_ACTIVITY_CODE (
        VISIT_ACTIVITY_CODE_ID, VISIT_ACTIVITY_CODE_PROPERTIES, ACTIVITY_CODE_PROPERTIES)
        SELECT VISIT_ACTIVITY_CODE_ID AS VISIT_ACTIVITY_CODE_ID, VISIT_ACTIVITY_CODE_PROPERTIES AS VISIT_ACTIVITY_CODE_PROPERTIES, ACTIVITY_CODE_PROPERTIES AS ACTIVITY_CODE_PROPERTIES
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_VISIT_ACTIVITY_CODE;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

