CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_USER_ROLES()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_USER_ROLES 
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
	
    INSERT OVERWRITE INTO ALAYACARE.USER_ROLES (
        ROLE_ID, PERMISSION_ID, EMPLOYEE_ID, ROLE_DESCRIPTION, ROLE_DETAILS, ROLE_CODE, ROLE_PORTAL, ROLE_ASSIGN_ACCOUNT, ROLE_ASSIGN_EMPLOYEE, ROLE_PERMISSIONS)
        SELECT ROLE_ID AS ROLE_ID, PERMISSION_ID AS PERMISSION_ID, EMPLOYEE_ID AS EMPLOYEE_ID, ROLE_DESCRIPTION AS ROLE_DESCRIPTION, ROLE_DETAILS AS ROLE_DETAILS, ROLE_CODE AS ROLE_CODE, ROLE_PORTAL AS ROLE_PORTAL, ROLE_ASSIGN_ACCOUNT AS ROLE_ASSIGN_ACCOUNT, ROLE_ASSIGN_EMPLOYEE AS ROLE_ASSIGN_EMPLOYEE, ROLE_PERMISSIONS AS ROLE_PERMISSIONS 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_USER_ROLES;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';