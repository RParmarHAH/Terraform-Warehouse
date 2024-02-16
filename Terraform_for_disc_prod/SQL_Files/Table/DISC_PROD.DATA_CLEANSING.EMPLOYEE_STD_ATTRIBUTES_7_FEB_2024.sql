CREATE OR REPLACE TABLE DISC_PROD.DATA_CLEANSING.EMPLOYEE_STD_ATTRIBUTES_7_FEB_2024 (
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	SYSTEM_CODE VARCHAR(16777216) NOT NULL,
	EMPLOYEE_ID VARCHAR(16777216) NOT NULL,
	EMPLOYEE_FIRST_NAME VARCHAR(100) NOT NULL,
	EMPLOYEE_LAST_NAME VARCHAR(100) NOT NULL,
	SRC_EMPLOYEE_ADDRESS VARCHAR(500),
	STD_EMPLOYEE_ADDRESS VARCHAR(500),
	SRC_EMPLOYEE_CITY VARCHAR(100),
	STD_EMPLOYEE_CITY VARCHAR(100),
	STD_EMPLOYEE_COUNTY VARCHAR(200),
	SRC_EMPLOYEE_STATE_CODE VARCHAR(100),
	STD_EMPLOYEE_STATE_NAME VARCHAR(100),
	STD_EMPLOYEE_STATE_CODE VARCHAR(10),
	SRC_EMPLOYEE_ZIP VARCHAR(100),
	STD_EMPLOYEE_ZIP VARCHAR(10),
	STD_EMPLOYEE_ZIP_PLUS_FOUR VARCHAR(10),
	STD_EMPLOYEE_COUNTRY_CODE VARCHAR(10),
	ADDRESS_NUMBER VARCHAR(10),
	STREET VARCHAR(500),
	LABEL VARCHAR(500),
	POINTS VARCHAR(100),
	LATITUDE FLOAT,
	LONGITUDE FLOAT,
	RELEVANCE FLOAT,
	SRC_EMPLOYEE_ADDRESS_PROCESSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_SSN VARCHAR(200),
	STD_EMPLOYEE_SSN VARCHAR(20),
	SRC_EMPLOYEE_SSN_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_DOB DATE,
	STD_EMPLOYEE_DOB DATE,
	SRC_EMPLOYEE_DOB_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_HOME_PHONE VARCHAR(100),
	STD_EMPLOYEE_HOME_PHONE VARCHAR(20),
	SRC_EMPLOYEE_HOME_PHONE_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_CELL_PHONE VARCHAR(100),
	STD_EMPLOYEE_CELL_PHONE VARCHAR(20),
	SRC_EMPLOYEE_CELL_PHONE_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_WORK_PHONE VARCHAR(100),
	STD_EMPLOYEE_WORK_PHONE VARCHAR(20),
	SRC_EMPLOYEE_WORK_PHONE_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_PERSONAL_EMAIL VARCHAR(200),
	STD_EMPLOYEE_PERSONAL_EMAIL VARCHAR(200),
	SRC_EMPLOYEE_PERSONAL_EMAIL_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	SRC_EMPLOYEE_WORK_EMAIL VARCHAR(200),
	STD_EMPLOYEE_WORK_EMAIL VARCHAR(200),
	SRC_EMPLOYEE_WORK_EMAIL_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN,
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	METHD_UPD VARCHAR(500),
	constraint PK_EMPLOYEE_STD_ATTRIBUTES_ primary key (SOURCE_SYSTEM_ID, SYSTEM_CODE, EMPLOYEE_ID)
);