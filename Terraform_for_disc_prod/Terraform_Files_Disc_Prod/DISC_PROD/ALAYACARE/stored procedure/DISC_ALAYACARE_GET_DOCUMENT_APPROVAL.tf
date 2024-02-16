resource "snowflake_procedure" "DISC_ALAYACARE_GET_DOCUMENT_APPROVAL" {
	name ="GET_DOCUMENT_APPROVAL"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_DOCUMENT_APPROVAL 
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
	
    INSERT OVERWRITE INTO ALAYACARE.DOCUMENT_APPROVAL (
        DOCUMENT_ID, CLIENT_ID, DOCUMENT_TYPE, DOCUMENT_STATUS, CERTIFICATION_START_DATE, CERTIFICATION_END_DATE, PHYSICIAN_NAME, PHYSICIAN_CONTACT_ID, START_CARE_DATE, CREATION_DATE, EMPLOYEE_ID)
        SELECT DOCUMENT_ID AS DOCUMENT_ID, CLIENT_ID AS CLIENT_ID, DOCUMENT_TYPE AS DOCUMENT_TYPE, DOCUMENT_STATUS AS DOCUMENT_STATUS, CERTIFICATION_START_DATE AS CERTIFICATION_START_DATE, CERTIFICATION_END_DATE AS CERTIFICATION_END_DATE, PHYSICIAN_NAME AS PHYSICIAN_NAME, PHYSICIAN_CONTACT_ID AS PHYSICIAN_CONTACT_ID, START_CARE_DATE AS START_CARE_DATE, CREATION_DATE AS CREATION_DATE, EMPLOYEE_ID AS EMPLOYEE_ID 
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_DOCUMENT_APPROVAL;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

