CREATE OR REPLACE TABLE DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK cluster by (EMPLOYEE_ENTERPRISE_ID,AMS_EMPLOYEE_KEY,PAYROLL_EMPLOYEE_KEY,AMS_EMPLOYEE_ID, AMS_SOURCE_SYSTEM_ID, AMS_SYSTEM_CODE)(
	EMPLOYEE_ENTERPRISE_ID NUMBER(38,0) NOT NULL,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	BRANCH_STATE_CODE VARCHAR(2),
	AMS_EMPLOYEE_KEY VARCHAR(32),
	AMS_SOURCE_SYSTEM_ID NUMBER(38,0),
	AMS_SYSTEM_CODE VARCHAR(30),
	AMS_EMPLOYEE_ID VARCHAR(50),
	AMS_METADATA VARIANT,
	PAYROLL_EMPLOYEE_KEY VARCHAR(32),
	PAYROLL_SOURCE_SYSTEM_ID NUMBER(38,0),
	PAYROLL_SYSTEM_CODE VARCHAR(30),
	PAYROLL_EMPLOYEE_ID VARCHAR(50),
	PAYROLL_METADATA VARIANT,
	APPLICANT_EMPLOYEE_KEY VARCHAR(32),
	APPLICANT_SOURCE_SYSTEM_ID NUMBER(38,0),
	APPLICANT_SYSTEM_CODE VARCHAR(30),
	APPLICANT_EMPLOYEE_ID VARCHAR(50),
	AMS_IVR_ID VARCHAR(50),
	GATOR_EMPLOYEE_KEY VARCHAR(32),
	GATOR_EMPLOYEE_ACCOUNT_ID VARCHAR(50),
	COACHUPCARE_ID VARCHAR(50),
	CARIBOU_ID_SENT VARCHAR(200),
	SERVICENOW_ID NUMBER(38,0),
	DERIVED_WORKDAY_ID VARCHAR(20),
	WORKDAY_USERNAME VARCHAR(50),
	WORKDAY_INTERNAL_ID VARCHAR(50),
	BROADSPIRE_ID VARCHAR(50),
	OKTA_ID VARCHAR(50),
	OKTA_USERNAME VARCHAR(100),
	ACTIVE_DIRECTORY_SID NUMBER(38,0),
	ACTIVE_DIRECTORY_EMAIL VARCHAR(1000),
	EMPLOYEE_RISKONNECT_ID VARCHAR(50),
	MOST_RECENT_SERVICE_DATE DATE,
	MOST_RECENT_PAYROLL_DATE DATE,
	EXCEPTION_FLAG BOOLEAN,
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	DUP_FLAG BOOLEAN,
	DUP_FLAG_REASON VARCHAR(100),
	INACTIVE BOOLEAN DEFAULT FALSE,
	AMS_PUBLIC_ID VARCHAR(30),
	AMS_PAYROLL_ID VARCHAR(51),
	EMPLOYEE_SSN VARCHAR(51),
	constraint PK_EMPLOYEE_CROSS_WALK primary key (EMPLOYEE_ENTERPRISE_ID)
);