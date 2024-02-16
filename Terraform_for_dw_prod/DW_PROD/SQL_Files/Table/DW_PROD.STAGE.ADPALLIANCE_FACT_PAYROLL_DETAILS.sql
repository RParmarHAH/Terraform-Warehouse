CREATE OR REPLACE TABLE DW_PROD.STAGE.ADPALLIANCE_FACT_PAYROLL_DETAILS (
	PAYROLL_DETAIL_KEY VARCHAR(32),
	PAYROLL_KEY VARCHAR(32),
	REPORT_DATE DATE,
	EMPLOYEE_KEY VARCHAR(32),
	BRANCH_KEY VARCHAR(32),
	SOURCE_SYSTEM_ID NUMBER(2,0),
	PAYROLL_DATE DATE,
	EMPLOYEE_ID VARCHAR(50),
	BRANCH_NAME VARCHAR(100),
	SYSTEM_CODE VARCHAR(30),
	PAY_PERIOD_START_DATE DATE,
	PAY_PERIOD_END_DATE DATE,
	CHECK_NUMBER VARCHAR(100),
	PAY_CODE VARCHAR(50),
	PAY_CODE_DESCRIPTION VARCHAR(16777216),
	PAY_CODE_TYPE VARCHAR(50),
	PAY_CODE_TYPE_DESCRIPTION VARCHAR(16777216),
	PAY_CODE_CATEGORY VARCHAR(50),
	NUMBER_OF_UNITS NUMBER(38,0),
	UNIT_TYPE_CODE VARCHAR(100),
	UNIT_TYPE_DESCRIPTION VARCHAR(100),
	RATE NUMBER(38,3),
	AMOUNT NUMBER(38,3),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL
);