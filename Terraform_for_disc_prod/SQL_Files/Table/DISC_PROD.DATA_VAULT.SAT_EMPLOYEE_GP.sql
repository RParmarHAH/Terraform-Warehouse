CREATE OR REPLACE TABLE DISC_PROD.DATA_VAULT.SAT_EMPLOYEE_GP (
	HASH_EMPLOYEE_KEY VARCHAR(32),
	DB VARCHAR(5),
	EMPLOYEE_ID VARCHAR(15),
	INACTIVE NUMBER(3,0),
	SSN VARCHAR(15),
	DEPARTMENT VARCHAR(7),
	WORK_STATE VARCHAR(2),
	OFFICE NUMBER(10,0),
	IS_ADMIN NUMBER(10,0),
	FIRST_NAME VARCHAR(15),
	LAST_NAME VARCHAR(21),
	MIDDLE_NAME VARCHAR(15),
	CONTRACT_TYPE VARCHAR(21),
	LAST_CHECK_DATE TIMESTAMP_NTZ(9),
	ADDRESS_CODE VARCHAR(15),
	ADDRESS1 VARCHAR(61),
	ADDRESS2 VARCHAR(61),
	ADDRESS3 VARCHAR(61),
	CITY VARCHAR(35),
	STATE VARCHAR(29),
	ZIP VARCHAR(11),
	PHONE_NUMBER VARCHAR(10),
	SHORT_EMPLOYEE_ID NUMBER(10,0),
	GENDER NUMBER(5,0),
	DOB TIMESTAMP_NTZ(9),
	HIRE_DATE TIMESTAMP_NTZ(9),
	BENEFIT_START_DATE TIMESTAMP_NTZ(9),
	TERMINATE_DATE TIMESTAMP_NTZ(9),
	GENDER_TEXT VARCHAR(6),
	ETHICS VARCHAR(35),
	SUTA_STATE VARCHAR(3),
	VACATION_AVAILABLE NUMBER(17,6),
	SICK_AVAILABLE NUMBER(17,6),
	JOB_TITLE VARCHAR(7),
	JOB_DESCRIPTION VARCHAR(31),
	PHONE_NUMBER_2 VARCHAR(12),
	CLASS_ID VARCHAR(20),
	ETHICS_CODE NUMBER(5,0),
	WORKERS_COMP VARCHAR(12),
	REASON_TO_TERM VARCHAR(50),
	LAST_DAY_WORKED TIMESTAMP_NTZ(9),
	OFFICE_STATE VARCHAR(5),
	OFFICE_NO VARCHAR(5),
	REPLACEMENTS VARCHAR(21),
	MARITAL_STATUS NUMBER(10,0),
	MARITAL_STATUS_TEXT VARCHAR(20),
	EMPLOYMENT_TYPE NUMBER(10,0),
	EMPLOYMENT_TYPE_TEXT VARCHAR(20),
	FIRST_CHECK_DATE TIMESTAMP_NTZ(9),
	VACATION_ACCRUED NUMBER(17,6),
	SICK_ACCRUED NUMBER(17,6),
	DEPARTMENT_NAME VARCHAR(50),
	EMAIL VARCHAR(250),
	PTO_CODE VARCHAR(50),
	PERSONAL_EMAIL VARCHAR(250),
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);