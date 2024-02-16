CREATE OR REPLACE TABLE DW_PROD.STAGE.MATRIXCARE_FACT_REVENUE (
	REVENUE_KEY VARCHAR(32) NOT NULL,
	REPORT_DATE DATE NOT NULL,
	BRANCH_KEY VARCHAR(32) NOT NULL,
	EMPLOYEE_KEY VARCHAR(32) NOT NULL,
	CLIENT_KEY VARCHAR(32) NOT NULL,
	CONTRACT_KEY VARCHAR(32) NOT NULL,
	INVOICE_KEY VARCHAR(32) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	SUPERVISOR_KEY VARCHAR(32) NOT NULL,
	REVENUE_DATE DATE NOT NULL,
	PAYMENT_DATE DATE,
	BRANCH_NAME VARCHAR(100),
	EMPLOYEE_ID VARCHAR(50),
	CLIENT_NUMBER NUMBER(38,0),
	CONTRACT_CODE VARCHAR(15),
	INVOICE_NUMBER VARCHAR(50),
	INVOICE_TYPE VARCHAR(20) COMMENT 'Regular or Lump Sum',
	BILL_UNIT_TYPE VARCHAR(50),
	NUMBER_OF_CLIENTS NUMBER(38,0) DEFAULT 1,
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	SUPERVISOR_CODE VARCHAR(50),
	BILL_CODE VARCHAR(50),
	INVOICE_HOURS NUMBER(38,3),
	INVOICE_RATE NUMBER(38,3),
	AMOUNT_BILLED NUMBER(38,3),
	AMOUNT_COLLECTED NUMBER(38,3),
	AMOUNT_OUTSTANDING NUMBER(38,3),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL
);