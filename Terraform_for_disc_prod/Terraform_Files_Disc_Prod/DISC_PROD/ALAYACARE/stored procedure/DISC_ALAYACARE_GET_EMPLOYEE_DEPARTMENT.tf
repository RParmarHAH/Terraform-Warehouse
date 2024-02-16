resource "snowflake_procedure" "DISC_ALAYACARE_GET_EMPLOYEE_DEPARTMENT" {
	name ="GET_EMPLOYEE_DEPARTMENT"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_EMPLOYEE_DEPARTMENT 
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
	
    INSERT OVERWRITE INTO ALAYACARE.EMPLOYEE_DEPARTMENT (
        LAKE_ID, EMPLOYEE_ID, DEPARTMENT_ID,
		PROPERTIES_ACTIVE, PROPERTIES_END_DATE, PROPERTIES_ID, PROPERTIES_IDACCOUNT, PROPERTIES_IDBILLITEM, PROPERTIES_IDPAYROLLITEM, PROPERTIES_IDUSER, 
		PROFILE_COMPANY, PROFILE_PHONE_MAIN)
        SELECT LAKE_ID AS LAKE_ID, EMPLOYEE_ID AS EMPLOYEE_ID, DEPARTMENT_ID AS DEPARTMENT_ID,
			PROPERTIES:active::STRING AS PROPERTIES_ACTIVE, PROPERTIES:end_date::STRING AS PROPERTIES_END_DATE, PROPERTIES:id::STRING AS PROPERTIES_ID, PROPERTIES:idaccount::STRING AS PROPERTIES_IDACCOUNT, PROPERTIES:idbillitem::STRING AS PROPERTIES_IDBILLITEM, PROPERTIES:idpayrollitem::STRING AS PROPERTIES_IDPAYROLLITEM, PROPERTIES:iduser::STRING AS PROPERTIES_IDUSER, 
			PROFILE:company::STRING AS PROFILE_COMPANY, PROFILE:phone_main::STRING AS PROFILE_PHONE_MAIN
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_EMPLOYEE_DEPARTMENT;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

