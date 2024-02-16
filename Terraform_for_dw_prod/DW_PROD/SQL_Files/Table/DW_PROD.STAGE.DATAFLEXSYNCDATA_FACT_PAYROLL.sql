CREATE OR REPLACE TABLE DW_PROD.STAGE.DATAFLEXSYNCDATA_FACT_PAYROLL (
	PAYROLL_KEY VARCHAR(32) NOT NULL,
	REPORT_DATE DATE NOT NULL,
	EMPLOYEE_KEY VARCHAR(32) NOT NULL,
	BRANCH_KEY VARCHAR(32) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	PAYROLL_DATE DATE NOT NULL,
	EMPLOYEE_ID VARCHAR(50) NOT NULL,
	BRANCH_NAME VARCHAR(100) NOT NULL,
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	PAY_PERIOD_START_DATE DATE,
	PAY_PERIOD_END_DATE DATE,
	CHECK_NUMBER VARCHAR(100) NOT NULL,
	PAY_HOURS NUMBER(38,3),
	SERVICE_HOURS NUMBER(38,3),
	OVERTIME_HOURS NUMBER(38,3),
	NON_SERVICE_UNITS NUMBER(38,3),
	SICK_HOURS NUMBER(38,3),
	VACATION_HOURS NUMBER(38,3),
	PAY_RATE NUMBER(38,3),
	OVERTIME_RATE NUMBER(38,3),
	GROSS_PAY_AMOUNT NUMBER(38,3),
	SERVICE_PAY_AMOUNT NUMBER(38,3),
	OVERTIME_PAY_AMOUNT NUMBER(38,3),
	NON_SERVICE_PAY_AMOUNT NUMBER(38,3),
	TAX_AMOUNT NUMBER(38,3),
	NET_PAY_AMOUNT NUMBER(38,3),
	OTHER_DEDUCTIONS_AMOUNT NUMBER(38,3),
	UNION_DUES_AMOUNT NUMBER(38,3),
	REINBURSMENT_AMOUNT NUMBER(38,3),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL
);