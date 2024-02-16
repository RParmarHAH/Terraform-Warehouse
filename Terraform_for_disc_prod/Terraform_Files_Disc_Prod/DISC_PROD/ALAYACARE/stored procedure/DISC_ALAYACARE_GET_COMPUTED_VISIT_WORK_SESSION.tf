resource "snowflake_procedure" "DISC_ALAYACARE_GET_COMPUTED_VISIT_WORK_SESSION" {
	name ="GET_COMPUTED_VISIT_WORK_SESSION"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_COMPUTED_VISIT_WORK_SESSION 
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
	
    INSERT OVERWRITE INTO ALAYACARE.COMPUTED_VISIT_WORK_SESSION (
        VISIT_ID, PERCENTAGE_RAW, PERCENTAGE, PUNCHED, PUNCHED_START_MINUS_SCHEDULED_START, VISIT_LATE, PUNCHED_DURATION, VISIT_SCHEDULED_DURATION, SCHEDULED_MINUS_PUNCHED_DURATION)
        SELECT VISIT_ID AS VISIT_ID, PERCENTAGE_RAW AS PERCENTAGE_RAW, PERCENTAGE AS PERCENTAGE, PUNCHED AS PUNCHED, PUNCHED_START_MINUS_SCHEDULED_START AS PUNCHED_START_MINUS_SCHEDULED_START, VISIT_LATE AS VISIT_LATE, PUNCHED_DURATION AS PUNCHED_DURATION, VISIT_SCHEDULED_DURATION AS VISIT_SCHEDULED_DURATION, SCHEDULED_MINUS_PUNCHED_DURATION AS SCHEDULED_MINUS_PUNCHED_DURATION 
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_COMPUTED_VISIT_WORK_SESSION;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

