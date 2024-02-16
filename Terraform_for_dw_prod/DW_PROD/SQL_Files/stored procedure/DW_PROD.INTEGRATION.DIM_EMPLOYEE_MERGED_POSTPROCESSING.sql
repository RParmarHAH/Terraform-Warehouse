CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.DIM_EMPLOYEE_MERGED_POSTPROCESSING("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result varchar(1000);
BEGIN

--*****************************************************************************************************************************
-- NAME: DIM_EMPLOYEE_MERGED_POSTPROCESSING
--
-- PURPOSE: Creates one row per client 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 		  					        Initial development
-- 01/23/2023  DIYA MISTRY          Leveraged dedupe for PRIME(OH)
-- 01/24/2023  Sanket jain 			removed oshah filter bak prc-DIM_EMPLOYEE_MERGED_POSTPROCESSING_BAK_1_24_2023
-- 01/26/2023  DIYA MISTRY          Leveraged dedupe for OSHAH - DE and OPENSYSTEMS - DE
-- 03/14/2023  DIYA MISTRY          REMOVED DEVERO(15)
--17/07/2023   JIGAR PRAJAPATI      ADDED MS state
--07/10/203    jigar prajapati      ADDED DERIVED AND WORKDAY RELATED COLUMNS 
--11/10/2023   Deepen Gajjar        Added hispanic_or_latino field
--*****************************************************************************************************************************
INSERT OVERWRITE INTO DW_PROD.INTEGRATION.DIM_EMPLOYEE_MERGED
 WITH EMPLOYEE_DEDUPE AS
 (SELECT D.ORIGINAL_EMPLOYEE_KEY,
D.ORIGINAL_SOURCE_SYSTEM_ID,
D.ORIGINAL_SYSTEM_CODE,
D.ORIGINAL_EMPLOYEE_NUMBER,
D.ORIGINAL_EMPLOYEE_PID,
D.EMPLOYEE_KEY,
D.EMPLOYEE_ID,
D.SYSTEM_CODE,
D.SOURCE_SYSTEM_ID,
D.EMPLOYEE_PID,
D.EMPLOYEE_NUMBER,
D.EMPLOYEE_DOB, D.EMPLOYEE_DATE_OF_DEATH, D.EMPLOYEE_HIRE_DATE, D.EMPLOYEE_REHIRE_DATE, D.EMPLOYEE_BENEFIT_START_DATE, D.EMPLOYEE_FIRST_CHECK_DATE, D.EMPLOYEE_LAST_CHECK_DATE, D.EMPLOYEE_LAST_WORKED_DATE, D.EMPLOYEE_TERMINATE_DATE, D.REASON_TO_TERMINATE, D.ACTIVE_EMPLOYEE_FLAG, D.ABLE_TO_REHIRE_FLAG, D.EMPLOYEE_PREFIX, D.EMPLOYEE_FIRST_NAME, D.EMPLOYEE_MIDDLE_NAME, D.EMPLOYEE_LAST_NAME, D.EMPLOYEE_SUFFIX, D.EMPLOYEE_ADDRESS1, D.EMPLOYEE_ADDRESS2, D.EMPLOYEE_CITY, D.EMPLOYEE_STATE_CODE, D.EMPLOYEE_ZIP, D.EMPLOYEE_HOME_PHONE, D.EMPLOYEE_CELL_PHONE, D.EMPLOYEE_WORK_PHONE, D.EMPLOYEE_PERSONAL_EMAIL, D.EMPLOYEE_WORK_EMAIL, D.LINKED_IN_PROFILE_URL, D.EMPLOYEE_GENDER, D.EMPLOYEE_ETHNICITY,E2.HISPANIC_OR_LATINO, D.EMPLOYEE_LANGUAGE, D.EMPLOYEE_MARITAL_STATUS, D.EMPLOYEE_TYPE, D.EMPLOYEE_CATEGORY, D.EXEMPT_FLAG, D.JOB_TITLE, D.JOB_DESCRIPTION, D.CLASS_ID, D.WORKERS_COMP, D.PAYROLL_ID, D.PERCENT_401K_DEDUCTION, D.AMOUNT_401K_DEDUCTION, D.JAZZHR_APPLICANT_ID, D.JAZZHR_USER_ID, D.JAZZHR_CONTACT_ID, D.WORK_STATE, D.SUTA_STATE, D.EMPLOYEE_DEPARTMENT, D.EMPLOYEE_OFFICE_CODE, D.PRIMARY_BRANCH_KEY, D.PRIMARY_BRANCH_STATE, D.PRIMARY_BRANCH_NAME, D.PRIMARY_BRANCH_SYSTEM_CODE, D.CASE_MANAGER_FLAG, D.SUPERVISOR_FLAG, D.COORDINATOR_FLAG, D.LINKED_ID, D.SALARY, D.PAY_RATE, D.EFFECTIVE_FROM_DATE,
D.EFFECTIVE_TO_DATE, D.MDM_DIM_EMPLOYEE_KEY, D.ETL_TASK_KEY, D.ETL_INSERTED_TASK_KEY, D.ETL_INSERTED_DATE, D.ETL_INSERTED_BY, D.ETL_LAST_UPDATED_DATE, D.ETL_LAST_UPDATED_BY, D.ETL_DELETED_FLAG,
D.ETL_INFERRED_MEMBER_FLAG,
E.DERIVED_FIRST_SERVICE_DATE,E.DERIVED_LAST_SERVICE_DATE,E.DERIVED_PAYROLL_FIRST_CHECK_DATE,E.DERIVED_PAYROLL_LAST_CHECK_DATE,
E.AMS_SOURCE_SYSTEM,  E.PAYROLL_SOURCE_SYSTEM,    E.LOCATION_HIERARCHY,   E.APPLICANT_ID,  E.STATUS,
D.DERIVED_EMPLOYEE_HIRE_DATE,
D.DERIVED_EMPLOYEE_REHIRE_DATE,
D.DERIVED_EMPLOYEE_BENEFIT_START_DATE,
D.DERIVED_EMPLOYEE_FIRST_CHECK_DATE,
D.DERIVED_EMPLOYEE_LAST_CHECK_DATE,
D.DERIVED_EMPLOYEE_LAST_WORKED_DATE,
D.DERIVED_ACTIVE_EMPLOYEE_FLAG,
D.DERIVED_EMPLOYEE_TERMINATE_DATE
 FROM DW_PROD.INTEGRATION.DIM_EMPLOYEE_MERGED_DEDUPE D
left JOIN DW_PROD.HAH.DIM_EMPLOYEE E ON D.ORIGINAL_EMPLOYEE_KEY = E.EMPLOYEE_KEY  
LEFT JOIN DW_PROD.HAH.DIM_EMPLOYEE E2 ON D.EMPLOYEE_KEY = E2.EMPLOYEE_KEY  ), 
EMPLOYEE AS(
SELECT ORIGINAL_EMPLOYEE_KEY, ORIGINAL_SOURCE_SYSTEM_ID, ORIGINAL_SYSTEM_CODE, ORIGINAL_EMPLOYEE_NUMBER, ORIGINAL_EMPLOYEE_PID, EMPLOYEE_KEY, EMPLOYEE_ID, SYSTEM_CODE, SOURCE_SYSTEM_ID, EMPLOYEE_PID, EMPLOYEE_NUMBER, EMPLOYEE_DOB, EMPLOYEE_DATE_OF_DEATH, EMPLOYEE_HIRE_DATE, EMPLOYEE_REHIRE_DATE, EMPLOYEE_BENEFIT_START_DATE, EMPLOYEE_FIRST_CHECK_DATE,
   EMPLOYEE_LAST_CHECK_DATE, EMPLOYEE_LAST_WORKED_DATE, EMPLOYEE_TERMINATE_DATE, REASON_TO_TERMINATE,
   ACTIVE_EMPLOYEE_FLAG, ABLE_TO_REHIRE_FLAG, EMPLOYEE_PREFIX, EMPLOYEE_FIRST_NAME, EMPLOYEE_MIDDLE_NAME, 
   EMPLOYEE_LAST_NAME, EMPLOYEE_SUFFIX, EMPLOYEE_ADDRESS1, EMPLOYEE_ADDRESS2, EMPLOYEE_CITY, EMPLOYEE_STATE_CODE,
   EMPLOYEE_ZIP, EMPLOYEE_HOME_PHONE, EMPLOYEE_CELL_PHONE, EMPLOYEE_WORK_PHONE, EMPLOYEE_PERSONAL_EMAIL, EMPLOYEE_WORK_EMAIL, 
   LINKED_IN_PROFILE_URL, EMPLOYEE_GENDER, EMPLOYEE_ETHNICITY,HISPANIC_OR_LATINO, EMPLOYEE_LANGUAGE, EMPLOYEE_MARITAL_STATUS, EMPLOYEE_TYPE, EMPLOYEE_CATEGORY,
   EXEMPT_FLAG, JOB_TITLE, JOB_DESCRIPTION, CLASS_ID, WORKERS_COMP, PAYROLL_ID, PERCENT_401K_DEDUCTION, AMOUNT_401K_DEDUCTION, JAZZHR_APPLICANT_ID, 
   JAZZHR_USER_ID, JAZZHR_CONTACT_ID, WORK_STATE, SUTA_STATE, EMPLOYEE_DEPARTMENT, EMPLOYEE_OFFICE_CODE, PRIMARY_BRANCH_KEY, PRIMARY_BRANCH_STATE, 
   PRIMARY_BRANCH_NAME, PRIMARY_BRANCH_SYSTEM_CODE, CASE_MANAGER_FLAG, SUPERVISOR_FLAG, COORDINATOR_FLAG, LINKED_ID, SALARY, PAY_RATE, EFFECTIVE_FROM_DATE, 
   EFFECTIVE_TO_DATE, MDM_DIM_EMPLOYEE_KEY, ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, 
   ETL_DELETED_FLAG, ETL_INFERRED_MEMBER_FLAG, 
   DERIVED_FIRST_SERVICE_DATE, DERIVED_LAST_SERVICE_DATE, DERIVED_PAYROLL_FIRST_CHECK_DATE, DERIVED_PAYROLL_LAST_CHECK_DATE,
   AMS_SOURCE_SYSTEM, PAYROLL_SOURCE_SYSTEM, LOCATION_HIERARCHY, APPLICANT_ID,  STATUS, 
   DERIVED_EMPLOYEE_HIRE_DATE, DERIVED_EMPLOYEE_REHIRE_DATE, DERIVED_EMPLOYEE_BENEFIT_START_DATE, 
   DERIVED_EMPLOYEE_FIRST_CHECK_DATE, DERIVED_EMPLOYEE_LAST_CHECK_DATE, DERIVED_EMPLOYEE_LAST_WORKED_DATE, DERIVED_ACTIVE_EMPLOYEE_FLAG, 
   DERIVED_EMPLOYEE_TERMINATE_DATE 
FROM DW_PROD.INTEGRATION.VW_DIM_EMPLOYEE_MERGED WHERE SOURCE_SYSTEM_ID NOT IN (''13'',''14'',''16'')
AND NOT(
(SOURCE_SYSTEM_ID = 3 AND SYSTEM_CODE IN (''GA'', ''AL'',''MS'')) OR
(SOURCE_SYSTEM_ID IN (1,2)) OR
(SOURCE_SYSTEM_ID = 9 AND SYSTEM_CODE IN (''ALABAMA (3554)'', ''GEORGIA (1002)'')))
AND NOT ( SYSTEM_CODE IN (''OPENSYSTEMS - PA'',''8485'',''OSHAH - PA''))   --MJ 01/25/2023
AND NOT ( SYSTEM_CODE IN (''OPENSYSTEMS - DE'',''OSHAH - DE''))   --DM 01/26/2023
AND NOT ( SYSTEM_CODE IN (''OSHAH - MS''))   --DM 01/26/2023
AND ORIGINAL_EMPLOYEE_KEY NOT IN (SELECT ORIGINAL_EMPLOYEE_KEY FROM EMPLOYEE_DEDUPE)
UNION
SELECT * FROM EMPLOYEE_DEDUPE)
SELECT * FROM EMPLOYEE;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';