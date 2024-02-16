CREATE OR REPLACE PROCEDURE DISC_PROD.ALAYACARE.GET_SKILL()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_SKILL 
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
	
    INSERT OVERWRITE INTO ALAYACARE.SKILL (
        SKILL_ID, TYPE, LABEL_1_NAME, LABEL_2_NAME, LABEL_3_NAME, DATE_LABEL_NAME, ACQUIRED_DATE_LABEL_NAME, PROPERTIES_TBL_EMPLOYEE_SKILL_IDCATEGORY, PROPERTIES_TBL_EMPLOYEE_SKILL_CATEGORY_DESCRIPTION, PROPERTIES_TBL_EMPLOYEE_SKILL_HAS_DATE, PROPERTIES_TBL_EMPLOYEE_SKILL_ACQUIRED_DATE_LABEL, PROPERTIES_TBL_EMPLOYEE_SKILL_DATE_LABEL, PROPERTIES_TBL_EMPLOYEE_SKILL_IS_CLIENT_SPECIFIC, PROPERTIES_TBL_EMPLOYEE_SKILL_HAS_ACQUIRED_DATE, PROPERTIES_TBL_EMPLOYEE_SKILL_CATEGORY_IDMASTERACCOUNT, PROPERTIES_TBL_EMPLOYEE_SKILL_LABEL2, PROPERTIES_TBL_EMPLOYEE_SKILL_OP, PROPERTIES_TBL_EMPLOYEE_SKILL_IDMASTERACCOUNT, PROPERTIES_TBL_EMPLOYEE_SKILL_CATEGORY_DETAILS, PROPERTIES_TBL_EMPLOYEE_SKILL_DESCRIPTION, PROPERTIES_TBL_EMPLOYEE_SKILL_CATEGORY_ID, PROPERTIES_TBL_EMPLOYEE_SKILL_LABEL1, PROPERTIES_TBL_EMPLOYEE_SKILL_ID)
        SELECT SKILL_ID AS SKILL_ID, TYPE AS TYPE, LABEL_1_NAME AS LABEL_1_NAME, LABEL_2_NAME AS LABEL_2_NAME, LABEL_3_NAME AS LABEL_3_NAME, DATE_LABEL_NAME AS DATE_LABEL_NAME, ACQUIRED_DATE_LABEL_NAME AS ACQUIRED_DATE_LABEL_NAME, PROPERTIES_TBL_EMPLOYEE_SKILL:idcategory::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_IDCATEGORY, PROPERTIES_TBL_EMPLOYEE_SKILL:category_description::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_CATEGORY_DESCRIPTION, PROPERTIES_TBL_EMPLOYEE_SKILL:has_date::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_HAS_DATE, PROPERTIES_TBL_EMPLOYEE_SKILL:acquired_date_label::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_ACQUIRED_DATE_LABEL, PROPERTIES_TBL_EMPLOYEE_SKILL:date_label::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_DATE_LABEL, PROPERTIES_TBL_EMPLOYEE_SKILL:is_client_specific::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_IS_CLIENT_SPECIFIC, PROPERTIES_TBL_EMPLOYEE_SKILL:has_acquired_date::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_HAS_ACQUIRED_DATE, PROPERTIES_TBL_EMPLOYEE_SKILL:category_idmasteraccount::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_CATEGORY_IDMASTERACCOUNT, PROPERTIES_TBL_EMPLOYEE_SKILL:label2::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_LABEL2, PROPERTIES_TBL_EMPLOYEE_SKILL:Op::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_OP, PROPERTIES_TBL_EMPLOYEE_SKILL:idmasteraccount::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_IDMASTERACCOUNT, PROPERTIES_TBL_EMPLOYEE_SKILL:category_details::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_CATEGORY_DETAILS, PROPERTIES_TBL_EMPLOYEE_SKILL:description::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_DESCRIPTION, PROPERTIES_TBL_EMPLOYEE_SKILL:category_id::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_CATEGORY_ID, PROPERTIES_TBL_EMPLOYEE_SKILL:label1::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_LABEL1, PROPERTIES_TBL_EMPLOYEE_SKILL:id::STRING AS PROPERTIES_TBL_EMPLOYEE_SKILL_ID 
        FROM ALAYACARE_PRODUCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_SKILL;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
';