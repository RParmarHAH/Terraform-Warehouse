resource "snowflake_procedure" "DISC_ALAYACARE_GET_FACILITY" {
	name ="GET_FACILITY"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_FACILITY 
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
	
    INSERT OVERWRITE INTO ALAYACARE.FACILITY (
        FACILITY_ID, PROFILE_ID, GUID, BRANCH_ID, CREATED_AT, CREATED_BY, UPDATED_AT, UPDATED_BY, PROFILE, PROPERTIES)
        SELECT FACILITY_ID AS FACILITY_ID, PROFILE_ID AS PROFILE_ID, GUID AS GUID, BRANCH_ID AS BRANCH_ID, CREATED_AT AS CREATED_AT, CREATED_BY AS CREATED_BY, UPDATED_AT AS UPDATED_AT, UPDATED_BY AS UPDATED_BY, PROFILE::STRING AS PROFILE, PROPERTIES::STRING AS PROPERTIES
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_FACILITY;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

