create or replace view DW_PROD.INTEGRATION.VW_APPLICANT_EMPLOYEE_INPUT_QUERY_BKP(
	ID,
	EMPLOYEE_KEY,
	EMPLOYEE_ID,
	SYSTEM_CODE,
	SOURCE_SYSTEM_ID,
	SSN,
	DOB,
	APPLIED_DATE,
	HIRED_DATE,
	HIRED_DATE_MONTH,
	NAME,
	FIRST_NAME,
	LAST_NAME,
	PHONE,
	EMAIL,
	ADDRESS,
	CITY,
	STATE,
	POSTAL,
	BRANCH_KEY,
	BRANCH_NAME,
	ETL_INSERTED_DATE,
	EMPLOYEE_LAST_CHECK_DATE,
	EMPLOYEE_FIRST_CHECK_DATE,
	EMPLOYEE_LAST_WORKED_DATE,
	EMPLOYEE_HIRE_DATE,
	SOURCE_SYSTEM
) as 
select distinct ID,
EMPLOYEE_KEY,
EMPLOYEE_ID,
SYSTEM_CODE,
SOURCE_SYSTEM_ID,
case when SSN is null then random() else REGEXP_REPLACE(SSN,'-','')::NUMBER end SSN,
case when DATE_OF_BIRTH::varchar is null then randstr(5,random()) else DATE_OF_BIRTH::varchar end as  DOB,
APPLIED_DATE,
HIRED_DATE,
HIRED_DATE_MONTH,
NAME,
FIRST_NAME,
LAST_NAME,
case when PHONE is null then randstr(5,random()) else PHONE end PHONE,
case when EMAIL is null then randstr(5,random()) else EMAIL end EMAIL,
case when ADDRESS is null then randstr(5,random()) else ADDRESS end ADDRESS,
CITY,
STATE,
POSTAL,
BRANCH_KEY,
BRANCH_NAME,
ETL_INSERTED_DATE,
EMPLOYEE_LAST_CHECK_DATE,EMPLOYEE_FIRST_CHECK_DATE,EMPLOYEE_LAST_WORKED_DATE,EMPLOYEE_HIRE_DATE,SOURCE_SYSTEM
from (
SELECT D.APPLICANT_KEY AS ID, D.APPLICANT_KEY AS EMPLOYEE_KEY, APPLICANT_ID as EMPLOYEE_ID,D.SYSTEM_CODE,D.SOURCE_SYSTEM_ID,HEX_DECODE_STRING(SSN) as SSN ,DATE_OF_BIRTH ,
null as APPLIED_DATE, null as HIRED_DATE,MONTH(TO_DATE(F.HIRED_DATETIME)) HIRED_DATE_MONTH,FIRST_NAME || LAST_NAME AS NAME,
FIRST_NAME,LAST_NAME,MOBILE_PHONE AS PHONE,
EMAIL,ADDRESS,CITY,STATE,POSTAL,BRANCH_KEY,BRANCH_NAME,D.ETL_INSERTED_DATE,NULL AS EMPLOYEE_LAST_CHECK_DATE,NULL AS EMPLOYEE_FIRST_CHECK_DATE,
NULL AS EMPLOYEE_LAST_WORKED_DATE, NULL AS EMPLOYEE_HIRE_DATE,'APPLICANT' AS SOURCE_SYSTEM 
FROM  DW_PROD.HAH.DIM_APPLICANT  D
LEFT JOIN  DW_PROD.HAH.FACT_APPLICANT_STATUS F ON D.APPLICANT_KEY = F.APPLICANT_KEY  -- 27
WHERE D.SYSTEM_CODE  = 'WORKDAY' AND LINKED_ID IS NULL
union all
SELECT ID,EMPLOYEE_KEY,EMPLOYEE_ID,SYSTEM_CODE,SOURCE_SYSTEM_ID,SSN as SSN,DOB,APPLIED_DATE,HIRED_DATE,HIRED_DATE_MONTH,FIRST_NAME || LAST_NAME AS NAME,
FIRST_NAME,LAST_NAME,PHONE,EMAIL,ADDRESS,CITY,STATE,POSTAL,BRANCH_KEY,BRANCH_NAME,ETL_INSERTED_DATE,EMPLOYEE_LAST_CHECK_DATE,EMPLOYEE_FIRST_CHECK_DATE,
EMPLOYEE_LAST_WORKED_DATE,EMPLOYEE_HIRE_DATE,SOURCE_SYSTEM FROM (SELECT ID,EMPLOYEE_KEY,EMPLOYEE_ID,SYSTEM_CODE,SOURCE_SYSTEM_ID,SSN,DOB,APPLIED_DATE,
HIRED_DATE,HIRED_DATE_MONTH,FIRST_NAME,LAST_NAME,PHONE,EMAIL,ADDRESS,CITY,STATE,POSTAL,BRANCH_KEY,BRANCH_NAME,ETL_INSERTED_DATE,EMPLOYEE_LAST_CHECK_DATE,
EMPLOYEE_FIRST_CHECK_DATE,EMPLOYEE_LAST_WORKED_DATE,EMPLOYEE_HIRE_DATE,'APPLICANT' AS SOURCE_SYSTEM FROM DW_PROD.INTEGRATION.VW_JAZZHR_PARADOX_MASTER_LIST
)
UNION ALL 
SELECT DISTINCT EMPLOYEE_KEY AS ID,EMPLOYEE_KEY,EMPLOYEE_ID,SYSTEM_CODE,SOURCE_SYSTEM_ID,HEX_DECODE_STRING(EMPLOYEE_PID) AS SSN,TRY_TO_DATE(EMPLOYEE_DOB) DOB,
NULL AS APPLIED_DATE,TRY_TO_DATE(EMPLOYEE_HIRE_DATE) HIRED_DATE,MONTH(TRY_TO_DATE(EMPLOYEE_HIRE_DATE)) HIRED_DATE_MONTH,EMPLOYEE_FIRST_NAME || EMPLOYEE_LAST_NAME AS NAME,
UPPER(REGEXP_REPLACE(EMPLOYEE_FIRST_NAME, '[^A-ZA-Z]','')) FIRST_NAME,
UPPER(REGEXP_REPLACE(EMPLOYEE_LAST_NAME, '[^A-ZA-Z]','')) LAST_NAME,
TRIM(REGEXP_REPLACE(REPLACE(COALESCE(EMPLOYEE_HOME_PHONE,EMPLOYEE_CELL_PHONE,EMPLOYEE_WORK_PHONE), '+1',''), '[^0-9]','')) PHONE,
UPPER(TRIM(COALESCE(EMPLOYEE_PERSONAL_EMAIL,EMPLOYEE_WORK_EMAIL))) EMAIL,UPPER(TRIM(COALESCE(EMPLOYEE_ADDRESS1,EMPLOYEE_ADDRESS2))) ADDRESS,
UPPER(TRIM(EMPLOYEE_CITY)) CITY,COALESCE(PRIMARY_BRANCH_STATE, WORK_STATE) STATE,TRIM(REGEXP_REPLACE(EMPLOYEE_ZIP, '[^0-9]', '')) POSTAL,PRIMARY_BRANCH_KEY BRANCH_KEY,
PRIMARY_BRANCH_NAME BRANCH_NAME,ETL_INSERTED_DATE,EMPLOYEE_LAST_CHECK_DATE,EMPLOYEE_FIRST_CHECK_DATE,EMPLOYEE_LAST_WORKED_DATE,EMPLOYEE_HIRE_DATE,
'EMPLOYEE' AS SOURCE_SYSTEM FROM DW_PROD.INTEGRATION.DIM_EMPLOYEE_AMS_MERGED 
 WHERE COALESCE(EMPLOYEE_HIRE_DATE,CURRENT_dATE) >= '2019-11-21' and employee_key not in ('8a060032368b0b38711dcf37a92a9f4c')
AND FIRST_NAME <> 'TEST'      
  );