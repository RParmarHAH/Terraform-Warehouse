resource "snowflake_view" "DISC_AXXESS_VW_AXXESS_EMPLOYEE_NEW" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "VW_AXXESS_EMPLOYEE_NEW"
	statement = <<-SQL
	 
SELECT SYSTEM_EMPLOYEE_ID as EMPLOYEE_ID,
CREATE_TIMESTAMP,
UPDATE_TIMESTAMP,
USER_STATUS AS ACTIVE_STATUS,
USER_EMAIL AS EMAIL,
HIRE_DATE,
TERMINATION_DATE,
REPLACE(REPLACE(WORKER_FIRSTNAME,'"',''),$$\$$,'') AS FIRST_NAME,
REPLACE(REPLACE(WORKER_MIDDLENAME,'"',''),$$\$$,'') AS MIDDLE_NAME,
REPLACE(REPLACE(WORKER_LASTNAME,'"',''),$$\$$,'') AS LAST_NAME,
SSN,
DATE_OF_BIRTH,
EMPLOYEE_ID as EMPLOYEE_NUMBER,
ADDRESS_LINE1 AS ADDRESS_LINE_1,
ADDRESS_LINE2 AS ADDRESS_LINE_2,
ADDRESS_CITY,
ADDRESS_ZIP_CODE AS ADDRESS_ZIPCODE,
ADDRESS_STATE_CODE AS ADDRESS_STATECODE,
PRIMARY_PHONE_TYPE,
PRIMARY_PHONE_NUMBER,
GENDER,
EMPLOYEMENT_TYPE,
"CREDENTIALS",
TITLETYPE,
IS_CASE_MANAGER,
NULL  AS COMMENTS,
ACCOUNT_ID,
ACCOUNT_NAME,
'OH' AS  WORKING_LOCATION_STATECODE,
ETL_TASK_KEY,
ETL_INSERTED_TASK_KEY,
ETL_INSERTED_DATE,
ETL_INSERTED_BY,
ETL_LAST_UPDATED_DATE,
ETL_LAST_UPDATED_BY,
ETL_DELETED_FLAG,
'HC' AS REVENUE_CATEGORY
FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_HC_EMPLOYEEINFO
UNION
SELECT SYSTEM_EMPLOYEE_ID as EMPLOYEE_ID,
CREATE_TIMESTAMP,
UPDATE_TIMESTAMP,
ACTIVE_STATUS,
USER_EMAIL,
HIRE_DATE,
TERMINATION_DATE,
REPLACE(REPLACE(FIRST_NAME,'"',''),$$\$$,'') FIRST_NAME,
REPLACE(REPLACE(MIDDLE_NAME,'"',''),$$\$$,'') MIDDLE_NAME,
REPLACE(REPLACE(LAST_NAME,'"',''),$$\$$,'') LAST_NAME,
SSN,
DATE_OF_BIRTH,
EMPLOYEE_ID AS EMPLOYEE_NUMBER,
ADDRESS_LINE_1,
ADDRESS_LINE_2,
ADDRESS_CITY,
ADDRESS_ZIPCODE,
ADDRESS_STATECODE,
PRIMARY_PHONE_TYPE,
PRIMARY_PHONE_NUMBER,
GENDER,
EMPLOYMENT_TYPE,
"CREDENTIALS",
TITLE_TYPE,
IS_CASE_MANAGER,
NULL  AS  COMMENTS,
ACCOUNT_ID,
ACCOUNT_NAME,
'OH' AS  WORKING_LOCATION_STATECODE,
ETL_TASK_KEY,
ETL_INSERTED_TASK_KEY,
ETL_INSERTED_DATE,
ETL_INSERTED_BY,
ETL_LAST_UPDATED_DATE,
ETL_LAST_UPDATED_BY,
ETL_DELETED_FLAG,
'HH' AS REVENUE_CATEGORY
FROM DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_HH_EMPLOYEEINFO;
SQL
	or_replace = true 
	is_secure = false 
}

