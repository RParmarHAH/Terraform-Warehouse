resource "snowflake_procedure" "DISC_ALAYACARE_GET_EMPLOYEE_RULE" {
	name ="GET_EMPLOYEE_RULE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_EMPLOYEE_RULE 
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
	
    INSERT OVERWRITE INTO ALAYACARE.EMPLOYEE_RULE (
        RULE_ID, EMPLOYEE_ID, TYPE, START_AT, END_AT, DESCRIPTION, DURATION_PAID, RRULE, TIMEOFF_TYPE, DAYDIFF, EMPLOYEE_EMAIL)
        SELECT RULE_ID AS RULE_ID, EMPLOYEE_ID AS EMPLOYEE_ID, TYPE AS TYPE, START_AT AS START_AT, END_AT AS END_AT, DESCRIPTION AS DESCRIPTION, DURATION_PAID AS DURATION_PAID, RRULE AS RRULE, TIMEOFF_TYPE AS TIMEOFF_TYPE, DAYDIFF AS DAYDIFF, EMPLOYEE_EMAIL AS EMPLOYEE_EMAIL 
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_EMPLOYEE_RULE;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

