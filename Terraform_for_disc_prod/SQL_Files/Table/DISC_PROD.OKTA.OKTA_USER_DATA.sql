CREATE OR REPLACE TABLE DISC_PROD.OKTA.OKTA_USER_DATA (
	OKTA_INTERNAL_USER_ID VARCHAR(25) NOT NULL,
	USER_STATUS VARCHAR(50),
	CREATED_DATE TIMESTAMP_NTZ(9),
	ACTIVATED_DATE TIMESTAMP_NTZ(9),
	STATUS_CHANGED_DATE TIMESTAMP_NTZ(9),
	LAST_LOGIN_DATE TIMESTAMP_NTZ(9),
	LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	PASSWORD_CHANGED_DATE TIMESTAMP_NTZ(9),
	DATA_READ_TIMESTAMP TIMESTAMP_NTZ(9),
	OKTA_USERNAME VARCHAR(100) NOT NULL,
	ENTERPRISE_ID VARCHAR(50),
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	MIDDLE_NAME VARCHAR(50),
	JOB_TITLE VARCHAR(100),
	ROLE_TYPE VARCHAR(20),
	IS_EMPLOYEE BOOLEAN,
	BRANCH_KEY VARCHAR(32),
	BRANCH_OFFICE_CODE VARCHAR(5),
	BRANCH_NAME VARCHAR(150),
	BRANCH_STATE VARCHAR(50),
	PRIMARY_EMAIL VARCHAR(150),
	SECONDARY_EMAIL VARCHAR(150),
	PRIMARY_PHONE VARCHAR(50),
	MOBILE_PHONE VARCHAR(50),
	MANAGER_EMPLOYEE_KEY VARCHAR(150),
	MANAGER_EMPLOYEE_NAME VARCHAR(150),
	LOCALE VARCHAR(50),
	IMPORT_BATCH_ID VARCHAR(100),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN,
	constraint PK_SSO_OKTA_USER_DATA_OKTA_INTERNAL_USER_ID primary key (OKTA_INTERNAL_USER_ID)
);