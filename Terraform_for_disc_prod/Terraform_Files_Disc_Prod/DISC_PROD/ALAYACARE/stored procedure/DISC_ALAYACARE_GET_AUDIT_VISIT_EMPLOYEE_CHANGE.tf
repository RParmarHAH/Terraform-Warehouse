resource "snowflake_procedure" "DISC_ALAYACARE_GET_AUDIT_VISIT_EMPLOYEE_CHANGE" {
	name ="GET_AUDIT_VISIT_EMPLOYEE_CHANGE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_AUDIT_VISIT_EMPLOYEE_CHANGE 
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
	
    INSERT OVERWRITE INTO ALAYACARE.AUDIT_VISIT_EMPLOYEE_CHANGE (
        VISIT_ID, VISIT_START_TIME, VISIT_END_TIME, ACTION, EMPLOYEE_ID, UPDATE_EMPLOYEE_ID, UPDATE_TIME, BRANCH_ID)
        SELECT VISIT_ID AS VISIT_ID, VISIT_START_TIME AS VISIT_START_TIME, VISIT_END_TIME AS VISIT_END_TIME, ACTION AS ACTION, EMPLOYEE_ID AS EMPLOYEE_ID, UPDATE_EMPLOYEE_ID AS UPDATE_EMPLOYEE_ID, UPDATE_TIME AS UPDATE_TIME, BRANCH_ID AS BRANCH_ID
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_AUDIT_VISIT_EMPLOYEE_CHANGE;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

