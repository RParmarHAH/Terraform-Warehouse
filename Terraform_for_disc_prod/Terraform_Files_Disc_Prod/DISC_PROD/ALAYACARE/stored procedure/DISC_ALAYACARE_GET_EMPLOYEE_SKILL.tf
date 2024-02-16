resource "snowflake_procedure" "DISC_ALAYACARE_GET_EMPLOYEE_SKILL" {
	name ="GET_EMPLOYEE_SKILL"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_EMPLOYEE_SKILL 
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
	
    INSERT OVERWRITE INTO ALAYACARE.EMPLOYEE_SKILL (
        SKILL_ID, SKILLLABEL_ID, CLIENT_ID, EMPLOYEE_ID, STATUS, EXPIRY_DATE, CREATED_AT, UPDATED_AT, TRAINING_DATE, CLIENT_SPECIFIC_SKILL, LABEL_1_VALUE, LABEL_2_VALUE, LABEL_3_VALUE, DATE_LABEL_VALUE, 
		PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_COMMENTS, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_CREATE_TIME, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_CREATE_USER_ID, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_EXPIRY_DATE, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_GUID, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_ID, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_IDSKILL, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_IDSTATUS, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_IDUSER, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_START_AT, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_UPDATE_TIME, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_UPDATE_USER_ID)
        SELECT SKILL_ID AS SKILL_ID, SKILLLABEL_ID AS SKILLLABEL_ID, CLIENT_ID AS CLIENT_ID, EMPLOYEE_ID AS EMPLOYEE_ID, STATUS AS STATUS, EXPIRY_DATE AS EXPIRY_DATE, CREATED_AT AS CREATED_AT, UPDATED_AT AS UPDATED_AT, TRAINING_DATE AS TRAINING_DATE, CLIENT_SPECIFIC_SKILL AS CLIENT_SPECIFIC_SKILL, LABEL_1_VALUE AS LABEL_1_VALUE, LABEL_2_VALUE AS LABEL_2_VALUE, LABEL_3_VALUE AS LABEL_3_VALUE, DATE_LABEL_VALUE AS DATE_LABEL_VALUE, 
			REPLACE(PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE:comments::STRING, '''''''', '''''''''''') AS PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_COMMENTS, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE:create_time::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_CREATE_TIME, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE:create_user_id::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_CREATE_USER_ID, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE:expiry_date::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_EXPIRY_DATE, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE:guid::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_GUID, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE:id::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_ID, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE:idskill::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_IDSKILL, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE:idstatus::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_IDSTATUS, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE:iduser::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_IDUSER, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE:start_at::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_START_AT, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE:update_time::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_UPDATE_TIME, PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE:update_user_id::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_UPDATE_USER_ID 
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_EMPLOYEE_SKILL;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

