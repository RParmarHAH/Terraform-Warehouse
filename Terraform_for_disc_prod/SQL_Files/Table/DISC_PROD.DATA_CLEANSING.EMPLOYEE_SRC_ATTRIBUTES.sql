CREATE OR REPLACE TABLE DISC_PROD.DATA_CLEANSING.EMPLOYEE_SRC_ATTRIBUTES (
	SOURCE_SYSTEM_ID NUMBER(38,0),
	SYSTEM_CODE VARCHAR(16777216),
	EMPLOYEE_ID VARCHAR(16777216),
	EMPLOYEE_FIRST_NAME VARCHAR(100),
	EMPLOYEE_LAST_NAME VARCHAR(100),
	SRC_EMPLOYEE_ADDRESS VARCHAR(500),
	SRC_EMPLOYEE_CITY VARCHAR(100),
	SRC_EMPLOYEE_STATE_CODE VARCHAR(100),
	SRC_EMPLOYEE_ZIP VARCHAR(100),
	SRC_EMPLOYEE_MIN_ACTIVITY_DATE DATE,
	SRC_EMPLOYEE_MAX_ACTIVITY_DATE DATE,
	SRC_EMPLOYEE_ADDRESS_PROCESSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_SSN VARCHAR(200),
	SRC_EMPLOYEE_DOB DATE,
	SRC_EMPLOYEE_HOME_PHONE VARCHAR(50),
	SRC_EMPLOYEE_CELL_PHONE VARCHAR(50),
	SRC_EMPLOYEE_WORK_PHONE VARCHAR(50),
	SRC_EMPLOYEE_PERSONAL_EMAIL VARCHAR(200),
	SRC_EMPLOYEE_WORK_EMAIL VARCHAR(200),
	SRC_EMPLOYEE_SSN_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_DOB_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_HOME_PHONE_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_CELL_PHONE_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_WORK_PHONE_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_PERSONAL_EMAIL_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_WORK_EMAIL_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100)
);