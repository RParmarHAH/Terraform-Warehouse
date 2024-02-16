CREATE OR REPLACE TABLE DW_PROD.INTEGRATION.DIM_CLIENT_MERGED_BAKUP_02082023 (
	ORIGINAL_CLIENT_KEY VARCHAR(32),
	ORIGINAL_SOURCE_SYSTEM_ID NUMBER(38,0),
	ORIGINAL_SYSTEM_CODE VARCHAR(20),
	ORIGINAL_CLIENT_NUMBER VARCHAR(50),
	ORIGINAL_AGENCY VARCHAR(40),
	CLIENT_KEY VARCHAR(32),
	CLIENT_NUMBER VARCHAR(50),
	SYSTEM_CODE VARCHAR(20),
	SOURCE_SYSTEM_ID NUMBER(38,0),
	CLIENT_PID VARCHAR(32),
	CLIENT_DOB DATE,
	CLIENT_DATE_OF_DEATH DATE,
	CLIENT_GENDER VARCHAR(6),
	CLIENT_ETHNICITY VARCHAR(50),
	CLIENT_MARITAL_STATUS VARCHAR(500),
	CLIENT_SALUTATION VARCHAR(20),
	CLIENT_FIRST_NAME VARCHAR(1000),
	CLIENT_MIDDLE_NAME VARCHAR(1000),
	CLIENT_LAST_NAME VARCHAR(1000),
	CLIENT_NAME VARCHAR(3500),
	CLIENT_ADDRESS1 VARCHAR(1000),
	CLIENT_ADDRESS2 VARCHAR(1000),
	CLIENT_CITY VARCHAR(500),
	CLIENT_STATE_CODE VARCHAR(500),
	CLIENT_ZIP VARCHAR(12),
	CLIENT_CLN_ADDRESS1 VARCHAR(500),
	CLIENT_CLN_ADDRESS2 VARCHAR(500),
	CLIENT_CLN_CITY VARCHAR(50),
	CLIENT_CLN_STATE_CODE VARCHAR(500),
	CLIENT_CLN_ZIP VARCHAR(12),
	CLIENT_STD_ADDRESS1 VARCHAR(150),
	CLIENT_STD_ADDRESS2 VARCHAR(150),
	CLIENT_STD_CITY VARCHAR(50),
	CLIENT_STD_STATE_CODE VARCHAR(2),
	CLIENT_STD_ZIP VARCHAR(500),
	CLIENT_HOME_PHONE VARCHAR(20),
	CLIENT_CELL_PHONE VARCHAR(20),
	CLIENT_WORK_PHONE VARCHAR(20),
	CLIENT_FAX_NUMBER VARCHAR(20),
	CLIENT_PERSONAL_EMAIL VARCHAR(50000),
	REFERRAL_DATE DATE,
	DAYS_TO_SERVICE NUMBER(38,3),
	CONTRACT_BEGIN_DATE DATE,
	CONTRACT_END_DATE DATE,
	FIRST_SERVICE_DATE DATE,
	LAST_SERVICE_DATE DATE,
	BEGIN_DATE DATE,
	END_DATE DATE,
	ACTIVE_CLIENT_FLAG BOOLEAN,
	ON_HOLD_FLAG BOOLEAN,
	ON_HOLD_START_DATE DATE,
	ON_HOLD_END_DATE DATE,
	LINKED_ID VARCHAR(50),
	ACQUIRED_FROM_COMPANY_KEY VARCHAR(32),
	ACQUIRED_FROM_COMPANY_ID NUMBER(38,0),
	ACQUIRED_FROM_COMPANY_FULL_NAME VARCHAR(50),
	ACQUISITION_DATE DATE,
	ACQUISITION_FLAG BOOLEAN,
	ADMISSION_DATE DATE,
	ADMISSION_FLAG BOOLEAN,
	CLIENT_CONVERTED_FLAG BOOLEAN,
	PRIMARY_SUPERVISOR_KEY VARCHAR(100),
	PRIMARY_SUPERVISOR_CODE VARCHAR(100),
	PRIMARY_SUPERVISOR_NAME VARCHAR(100),
	SECONDARY_SUPERVISOR_KEY VARCHAR(100),
	SECONDARY_SUPERVISOR_CODE VARCHAR(500),
	SECONDARY_SUPERVISOR_NAME VARCHAR(500),
	PRIMARY_BRANCH_KEY VARCHAR(500),
	PRIMARY_BRANCH_NAME VARCHAR(100),
	PRIMARY_BRANCH_STATE VARCHAR(500),
	GUARANTOR_NAME VARCHAR(100),
	NOTES VARCHAR(10000),
	AGENCY VARCHAR(40),
	REFERRALS VARCHAR(10000),
	REFERRER_KEY VARCHAR(40),
	MEDICAID_ID VARCHAR(25),
	EFFECTIVE_FROM_DATE TIMESTAMP_NTZ(9),
	EFFECTIVE_TO_DATE TIMESTAMP_NTZ(9),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN,
	ETL_INFERRED_MEMBER_FLAG BOOLEAN,
	DERIVED_REFERRAL_DATE DATE,
	DERIVED_CONTRACT_BEGIN_DATE DATE,
	DERIVED_CONTRACT_END_DATE DATE,
	DERIVED_FIRST_SERVICE_DATE DATE,
	DERIVED_LAST_SERVICE_DATE DATE,
	DERIVED_BEGIN_DATE DATE,
	DERIVED_END_DATE DATE,
	DERIVED_DAYS_TO_SERVICE NUMBER(9,0)
);