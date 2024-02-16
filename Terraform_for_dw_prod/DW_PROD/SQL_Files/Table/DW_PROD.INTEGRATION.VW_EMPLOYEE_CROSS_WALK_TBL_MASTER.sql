CREATE OR REPLACE TABLE DW_PROD.INTEGRATION.VW_EMPLOYEE_CROSS_WALK_TBL_MASTER (
	EMPLOYEE_ENTERPRISE_ID NUMBER(38,0),
	FIRST_NAME VARCHAR(16777216),
	LAST_NAME VARCHAR(16777216),
	BRANCH_STATE_CODE VARCHAR(16777216),
	BROADSPIRE_ID VARCHAR(16777216),
	AMS_EMPLOYEE_KEY VARCHAR(16777216),
	AMS_SOURCE_SYSTEM_ID NUMBER(38,5),
	AMS_SYSTEM_CODE VARCHAR(16777216),
	AMS_EMPLOYEE_ID VARCHAR(16777216),
	AMS_METADATA OBJECT,
	PAYROLL_EMPLOYEE_KEY VARCHAR(16777216),
	PAYROLL_SOURCE_SYSTEM_ID NUMBER(38,5),
	PAYROLL_SYSTEM_CODE VARCHAR(16777216),
	PAYROLL_EMPLOYEE_ID VARCHAR(16777216),
	PAYROLL_METADATA OBJECT,
	APPLICANT_EMPLOYEE_KEY VARCHAR(16777216),
	APPLICANT_SOURCE_SYSTEM_ID NUMBER(38,0),
	APPLICANT_SYSTEM_CODE VARCHAR(16777216),
	APPLICANT_EMPLOYEE_ID VARCHAR(16777216),
	EXCEPTION_FLAG BOOLEAN,
	AMS_PAYROLL_ID VARCHAR(16777216),
	EMPLOYEE_SSN VARCHAR(16777216)
);