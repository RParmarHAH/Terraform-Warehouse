resource "snowflake_procedure" "DISC_ALAYACARE_GET_WORK_SESSION_TIER_4" {
	name ="GET_WORK_SESSION_TIER_4"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_WORK_SESSION_TIER_4 
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
	
INSERT OVERWRITE INTO ALAYACARE.WORK_SESSION_TIER_4 
SELECT 
	VISIT_ID ,
	START_TIME ,
	PUNCH_IN_LON ,
	PUNCH_IN_LAT ,
	PUNCH_IN_DISTANCE ,
	PUNCH_IN_DISTANCE_LIMIT ,
	END_TIME ,
	PUNCH_OUT_LON ,
	PUNCH_OUT_LAT ,
	PUNCH_OUT_DISTANCE ,
	PUNCH_OUT_DISTANCE_LIMIT 
FROM
ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_WORK_SESSION_TIER_4;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

