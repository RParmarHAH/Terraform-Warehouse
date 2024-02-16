resource "snowflake_procedure" "DISC_ALAYACARE_GET_EMPLOYEE_GROUP" {
	name ="GET_EMPLOYEE_GROUP"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_EMPLOYEE_GROUP 
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
	
    INSERT OVERWRITE INTO ALAYACARE.EMPLOYEE_GROUP (
        LAKE_ID, EMPLOYEE_ID, GROUP_ID, PROPERTIES_IDBILLITEM, PROPERTIES_END_DATE, PROPERTIES_OP, PROPERTIES_IDACCOUNT, PROPERTIES_IDPAYROLLITEM, PROPERTIES_ACTIVE, PROPERTIES_ID, PROPERTIES_IDUSER, PROFILE_REMARKS, PROFILE_COMPANY)
        SELECT LAKE_ID AS LAKE_ID, EMPLOYEE_ID AS EMPLOYEE_ID, GROUP_ID AS GROUP_ID, PROPERTIES:idbillitem::STRING AS PROPERTIES_IDBILLITEM, PROPERTIES:end_date::STRING AS PROPERTIES_END_DATE, PROPERTIES:Op::STRING AS PROPERTIES_OP, PROPERTIES:idaccount::STRING AS PROPERTIES_IDACCOUNT, PROPERTIES:idpayrollitem::STRING AS PROPERTIES_IDPAYROLLITEM, PROPERTIES:active::STRING AS PROPERTIES_ACTIVE, PROPERTIES:id::STRING AS PROPERTIES_ID, PROPERTIES:iduser::STRING AS PROPERTIES_IDUSER, PROFILE:remarks::STRING AS PROFILE_REMARKS, PROFILE:company::STRING AS PROFILE_COMPANY 
        FROM ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_EMPLOYEE_GROUP;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

