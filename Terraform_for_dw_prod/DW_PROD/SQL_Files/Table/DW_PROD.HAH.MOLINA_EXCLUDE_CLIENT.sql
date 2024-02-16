CREATE OR REPLACE TABLE DW_PROD.HAH.MOLINA_EXCLUDE_CLIENT (
	CLIENT_KEY VARCHAR(32),
	CLIENT_NUMBER VARCHAR(16777216),
	SYSTEM_CODE VARCHAR(6),
	SOURCE_SYSTEM_ID NUMBER(2,0),
	CLIENT_PID VARCHAR(16777216),
	CLIENT_MEDICARE_ID VARCHAR(16777216),
	MEDICAID_ID VARCHAR(16777216),
	CLIENT_DOB DATE,
	CLIENT_DATE_OF_DEATH VARCHAR(16777216),
	CLIENT_GENDER VARCHAR(16777216),
	CLIENT_ETHNICITY VARCHAR(16777216),
	HISPANIC_OR_LATINO BOOLEAN,
	CLIENT_GENDER_IDENTITY VARCHAR(16777216),
	CLIENT_SEXUAL_ORIENTATION VARCHAR(16777216),
	CLIENT_RACE VARCHAR(16777216),
	CLIENT_MARITAL_STATUS VARCHAR(16777216),
	CLIENT_SALUTATION VARCHAR(16777216),
	CLIENT_FIRST_NAME VARCHAR(16777216),
	CLIENT_MIDDLE_NAME VARCHAR(16777216),
	CLIENT_LAST_NAME VARCHAR(16777216),
	CLIENT_NAME VARCHAR(16777216),
	CLIENT_ADDRESS1 VARCHAR(16777216),
	CLIENT_ADDRESS2 VARCHAR(16777216),
	CLIENT_CITY VARCHAR(16777216),
	CLIENT_STATE_CODE VARCHAR(16777216),
	CLIENT_ZIP VARCHAR(16777216),
	CLIENT_CLN_ADDRESS1 VARCHAR(16777216),
	CLIENT_CLN_ADDRESS2 VARCHAR(16777216),
	CLIENT_CLN_CITY VARCHAR(16777216),
	CLIENT_CLN_STATE_CODE VARCHAR(16777216),
	CLIENT_CLN_ZIP VARCHAR(16777216),
	CLIENT_STD_ADDRESS1 VARCHAR(16777216),
	CLIENT_STD_ADDRESS2 VARCHAR(16777216),
	CLIENT_STD_CITY VARCHAR(16777216),
	CLIENT_STD_STATE_CODE VARCHAR(16777216),
	CLIENT_STD_ZIP VARCHAR(16777216),
	CLIENT_HOME_PHONE VARCHAR(16777216),
	CLIENT_CELL_PHONE VARCHAR(16777216),
	CLIENT_WORK_PHONE VARCHAR(16777216),
	CLIENT_FAX_NUMBER VARCHAR(16777216),
	CLIENT_PERSONAL_EMAIL VARCHAR(16777216),
	REFERRAL_DATE VARCHAR(16777216),
	DAYS_TO_SERVICE VARCHAR(16777216),
	CONTRACT_BEGIN_DATE VARCHAR(16777216),
	CONTRACT_END_DATE VARCHAR(16777216),
	FIRST_SERVICE_DATE VARCHAR(16777216),
	LAST_SERVICE_DATE VARCHAR(16777216),
	BEGIN_DATE VARCHAR(16777216),
	END_DATE VARCHAR(16777216),
	ACTIVE_CLIENT_FLAG VARCHAR(16777216),
	ON_HOLD_FLAG VARCHAR(16777216),
	ON_HOLD_START_DATE DATE,
	ON_HOLD_END_DATE DATE,
	LINKED_ID VARCHAR(16777216),
	ACQUIRED_FROM_COMPANY_KEY VARCHAR(16777216),
	ACQUIRED_FROM_COMPANY_ID VARCHAR(16777216),
	ACQUIRED_FROM_COMPANY_FULL_NAME VARCHAR(16777216),
	ACQUISITION_DATE VARCHAR(16777216),
	ACQUISITION_FLAG VARCHAR(16777216),
	ADMISSION_DATE VARCHAR(16777216),
	ADMISSION_FLAG VARCHAR(16777216),
	CLIENT_CONVERTED_FLAG VARCHAR(16777216),
	PRIMARY_SUPERVISOR_KEY VARCHAR(16777216),
	PRIMARY_SUPERVISOR_CODE VARCHAR(16777216),
	PRIMARY_SUPERVISOR_NAME VARCHAR(16777216),
	SECONDARY_SUPERVISOR_KEY VARCHAR(16777216),
	SECONDARY_SUPERVISOR_CODE VARCHAR(16777216),
	SECONDARY_SUPERVISOR_NAME VARCHAR(16777216),
	PRIMARY_BRANCH_KEY VARCHAR(16777216),
	PRIMARY_BRANCH_NAME VARCHAR(16777216),
	PRIMARY_BRANCH_STATE VARCHAR(16777216),
	GUARANTOR_NAME VARCHAR(16777216),
	NOTES VARCHAR(16777216),
	AGENCY VARCHAR(16777216),
	EFFECTIVE_FROM_DATE DATE,
	EFFECTIVE_TO_DATE DATE,
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG NUMBER(1,0),
	ETL_INFERRED_MEMBER_FLAG NUMBER(1,0)
);