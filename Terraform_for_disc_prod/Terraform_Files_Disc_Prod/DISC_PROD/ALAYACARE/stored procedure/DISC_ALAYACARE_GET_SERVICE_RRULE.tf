resource "snowflake_procedure" "DISC_ALAYACARE_GET_SERVICE_RRULE" {
	name ="GET_SERVICE_RRULE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_SERVICE_RRULE 
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
	
    INSERT OVERWRITE INTO ALAYACARE.SERVICE_RRULE (
        SERVICE_RRULE_ID, SERVICE_CODE_ID, EMPLOYEE_ID, SERVICE_ID, DURATION, RULE, RULE_FREQ, SERVICE_RECURRENCE_STATUS, REPEAT_INTERVAL, CREATE_TIME, START_DATE, END_DATE, SCHEDULED_UNTIL_DATE)
        SELECT SERVICE_RRULE_ID AS SERVICE_RRULE_ID, SERVICE_CODE_ID AS SERVICE_CODE_ID, EMPLOYEE_ID AS EMPLOYEE_ID, SERVICE_ID AS SERVICE_ID, DURATION AS DURATION, RULE AS RULE, RULE_FREQ AS RULE_FREQ, SERVICE_RECURRENCE_STATUS AS SERVICE_RECURRENCE_STATUS, REPEAT_INTERVAL AS REPEAT_INTERVAL, CREATE_TIME AS CREATE_TIME, START_DATE AS START_DATE, END_DATE AS END_DATE, SCHEDULED_UNTIL_DATE AS SCHEDULED_UNTIL_DATE 
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_SERVICE_RRULE;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

