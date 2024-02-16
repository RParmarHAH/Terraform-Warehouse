CREATE OR REPLACE TABLE DW_PROD.STAGE.MATRIXCARE_DIM_CLIENT (
	CLIENT_KEY VARCHAR(32),
	CLIENT_NUMBER NUMBER(38,0),
	SYSTEM_CODE VARCHAR(20),
	SOURCE_SYSTEM_ID NUMBER(38,0),
	CLIENT_PID VARCHAR(32),
	CLIENT_MEDICARE_ID VARCHAR(30),
	MEDICAID_ID VARCHAR(30),
	CLIENT_DOB DATE,
	CLIENT_DATE_OF_DEATH DATE,
	CLIENT_GENDER VARCHAR(6),
	CLIENT_ETHNICITY VARCHAR(50),
	HISPANIC_OR_LATINO BOOLEAN,
	CLIENT_GENDER_IDENTITY VARCHAR(100),
	CLIENT_SEXUAL_ORIENTATION VARCHAR(100),
	CLIENT_RACE VARCHAR(100),
	CLIENT_MARITAL_STATUS VARCHAR(20),
	CLIENT_SALUTATION VARCHAR(20),
	CLIENT_FIRST_NAME VARCHAR(50),
	CLIENT_MIDDLE_NAME VARCHAR(10),
	CLIENT_LAST_NAME VARCHAR(50),
	CLIENT_NAME VARCHAR(150),
	CLIENT_ADDRESS1 VARCHAR(150),
	CLIENT_ADDRESS2 VARCHAR(150),
	CLIENT_CITY VARCHAR(50),
	CLIENT_STATE_CODE VARCHAR(2),
	CLIENT_ZIP VARCHAR(12),
	CLIENT_CLN_ADDRESS1 VARCHAR(150),
	CLIENT_CLN_ADDRESS2 VARCHAR(150),
	CLIENT_CLN_CITY VARCHAR(50),
	CLIENT_CLN_STATE_CODE VARCHAR(2),
	CLIENT_CLN_ZIP VARCHAR(12),
	CLIENT_STD_ADDRESS1 VARCHAR(150),
	CLIENT_STD_ADDRESS2 VARCHAR(150),
	CLIENT_STD_CITY VARCHAR(50),
	CLIENT_STD_STATE_CODE VARCHAR(2),
	CLIENT_STD_ZIP VARCHAR(12),
	CLIENT_HOME_PHONE VARCHAR(20),
	CLIENT_CELL_PHONE VARCHAR(20),
	CLIENT_WORK_PHONE VARCHAR(20),
	CLIENT_FAX_NUMBER VARCHAR(20),
	CLIENT_PERSONAL_EMAIL VARCHAR(150),
	REFERRAL_DATE DATE,
	DAYS_TO_SERVICE NUMBER(38,3),
	CONTRACT_BEGIN_DATE DATE,
	CONTRACT_END_DATE DATE,
	FIRST_SERVICE_DATE DATE,
	LAST_SERVICE_DATE DATE,
	BEGIN_DATE DATE,
	END_DATE DATE,
	ACTIVE_CLIENT_FLAG BOOLEAN,
	CLIENT_STATUS VARCHAR(100),
	DISCHARGE_REASON VARCHAR(5000),
	ON_HOLD_FLAG BOOLEAN,
	ON_HOLD_START_DATE DATE,
	ON_HOLD_END_DATE DATE,
	ACQUIRED_FROM_COMPANY_KEY VARCHAR(32),
	ACQUIRED_FROM_COMPANY_ID NUMBER(38,0),
	ACQUIRED_FROM_COMPANY_FULL_NAME VARCHAR(50),
	ACQUISITION_DATE DATE,
	ACQUISITION_FLAG BOOLEAN,
	ADMISSION_DATE DATE,
	ADMISSION_FLAG BOOLEAN,
	CLIENT_CONVERTED_FLAG BOOLEAN,
	PRIMARY_SUPERVISOR_KEY VARCHAR(32),
	PRIMARY_SUPERVISOR_CODE VARCHAR(5),
	PRIMARY_SUPERVISOR_NAME VARCHAR(100),
	SECONDARY_SUPERVISOR_KEY VARCHAR(32),
	SECONDARY_SUPERVISOR_CODE VARCHAR(5),
	SECONDARY_SUPERVISOR_NAME VARCHAR(100),
	PRIMARY_BRANCH_KEY VARCHAR(32),
	PRIMARY_BRANCH_NAME VARCHAR(100),
	PRIMARY_BRANCH_STATE VARCHAR(2),
	GUARANTOR_NAME VARCHAR(100),
	NOTES VARCHAR(5000),
	EFFECTIVE_FROM_DATE TIMESTAMP_NTZ(9) NOT NULL,
	EFFECTIVE_TO_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	ETL_INFERRED_MEMBER_FLAG BOOLEAN NOT NULL
);