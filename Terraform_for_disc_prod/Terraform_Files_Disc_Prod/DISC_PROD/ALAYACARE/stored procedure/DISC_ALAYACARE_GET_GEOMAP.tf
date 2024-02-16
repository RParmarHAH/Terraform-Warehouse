resource "snowflake_procedure" "DISC_ALAYACARE_GET_GEOMAP" {
	name ="GET_GEOMAP"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_GEOMAP 
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
	
    INSERT OVERWRITE INTO ALAYACARE.GEOMAP (
        ID, EMPLOYEE_ID, CLIENT_ID, SERVICE_ID, ENTITY_TYPE, ENTITY_ADDRESS, ENTITY_STATUS, BRANCH_ID)
        SELECT ID AS ID, EMPLOYEE_ID AS EMPLOYEE_ID, CLIENT_ID AS CLIENT_ID, SERVICE_ID AS SERVICE_ID, ENTITY_TYPE AS ENTITY_TYPE, ENTITY_ADDRESS AS ENTITY_ADDRESS, ENTITY_STATUS AS ENTITY_STATUS, BRANCH_ID AS BRANCH_ID 
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_GEOMAP;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

