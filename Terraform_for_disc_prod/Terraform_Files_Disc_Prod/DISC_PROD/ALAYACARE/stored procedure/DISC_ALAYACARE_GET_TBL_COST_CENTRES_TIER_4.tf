resource "snowflake_procedure" "DISC_ALAYACARE_GET_TBL_COST_CENTRES_TIER_4" {
	name ="GET_TBL_COST_CENTRES_TIER_4"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_TBL_COST_CENTRES_TIER_4 
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
	
INSERT OVERWRITE INTO ALAYACARE.TBL_COST_CENTRES_TIER_4
SELECT
    ID ,
    PROPERTIES ,
    PROPERTIES[''branch_id'']::VARCHAR(500) AS PROPERTIES_BRANCH_ID,
PROPERTIES[''create_user_id'']::VARCHAR(100) AS PROPERTIES_CREATE_USER_ID,
PROPERTIES[''created_at'']::VARCHAR(100) AS PROPERTIES_CREATED_AT ,
PROPERTIES[''description'']::VARCHAR(16777216) AS PROPERTIES_DESCRIPTION,
PROPERTIES[''disabled'']::VARCHAR(500) AS PROPERTIES_DISABLED,
PROPERTIES[''number'']::VARCHAR(500) AS PROPERTIES_NUMBER,
PROPERTIES[''update_user_id'']::VARCHAR(100) AS PROPERTIES_UPDATE_USER_ID,
PROPERTIES[''updated_at'']::VARCHAR(100) AS PROPERTIES_UPDATED_AT
FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_TBL_COST_CENTRES_TIER_4; 


;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

