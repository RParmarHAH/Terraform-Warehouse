resource "snowflake_procedure" "DISC_ALAYACARE_GET_APR" {
	name ="GET_APR"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_APR 
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
	
    INSERT OVERWRITE INTO ALAYACARE.APR (
        APR_ID, SERVICE_ID, SERVICE_CHANGE_TYPE, EXTERNAL_ID, REPORT_TITLE, CLIENT_ID, FUNDER_ID, EMPLOYEE_CREATE_ID, EMPLOYEE_UPDATE_ID, CREATE_DATE, REVISION_DATE, SUBMISSION_DATE, SERVICE_DISCHARGE_DATE, SUB_FIRSTVISIT_DAYS, SUB_LASTVISIT_DAYS, SUB_SERVICEDISCHARGE_DAYS, SUB_FIRSTVISIT, SUB_LASTVISIT, SUB_SERVICEDISCHARGE, STATUS, TYPE, URGENT, RESPONSE, BRANCH_ID, PROPERTIES_PROVIDER, PROPERTIES_PROVIDER_SERVICE, PROPERTIES_SERVICE)
        SELECT APR_ID AS APR_ID, SERVICE_ID AS SERVICE_ID, SERVICE_CHANGE_TYPE AS SERVICE_CHANGE_TYPE, EXTERNAL_ID AS EXTERNAL_ID, REPORT_TITLE AS REPORT_TITLE, CLIENT_ID AS CLIENT_ID, FUNDER_ID AS FUNDER_ID, EMPLOYEE_CREATE_ID AS EMPLOYEE_CREATE_ID, EMPLOYEE_UPDATE_ID AS EMPLOYEE_UPDATE_ID, CREATE_DATE AS CREATE_DATE, REVISION_DATE AS REVISION_DATE, SUBMISSION_DATE AS SUBMISSION_DATE, SERVICE_DISCHARGE_DATE AS SERVICE_DISCHARGE_DATE, SUB_FIRSTVISIT_DAYS AS SUB_FIRSTVISIT_DAYS, SUB_LASTVISIT_DAYS AS SUB_LASTVISIT_DAYS, SUB_SERVICEDISCHARGE_DAYS AS SUB_SERVICEDISCHARGE_DAYS, SUB_FIRSTVISIT AS SUB_FIRSTVISIT, SUB_LASTVISIT AS SUB_LASTVISIT, SUB_SERVICEDISCHARGE AS SUB_SERVICEDISCHARGE, STATUS AS STATUS, TYPE AS TYPE, URGENT AS URGENT, RESPONSE AS RESPONSE, BRANCH_ID AS BRANCH_ID, PROPERTIES_PROVIDER::STRING AS PROPERTIES_PROVIDER, PROPERTIES_PROVIDER_SERVICE::STRING AS PROPERTIES_PROVIDER_SERVICE, PROPERTIES_SERVICE::STRING AS PROPERTIES_SERVICE 
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_APR;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

