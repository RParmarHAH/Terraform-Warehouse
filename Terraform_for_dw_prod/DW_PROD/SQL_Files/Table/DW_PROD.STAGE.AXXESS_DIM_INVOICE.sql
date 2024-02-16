CREATE OR REPLACE TABLE DW_PROD.STAGE.AXXESS_DIM_INVOICE (
	INVOICE_KEY VARCHAR(32) NOT NULL,
	CLIENT_KEY VARCHAR(32) NOT NULL,
	INVOICE_NUMBER VARCHAR(50) NOT NULL,
	ALTERNATE_INVOICE_NUMBER VARCHAR(50),
	PERIOD VARCHAR(6),
	INVOICE_TYPE VARCHAR(20) COMMENT 'Regular or Lump Sum',
	NUMBER_OF_CLIENTS NUMBER(38,0) DEFAULT 1,
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	BRANCH_KEY VARCHAR(32) NOT NULL,
	PAYOR_CODE VARCHAR(50),
	PAYOR_NAME VARCHAR(100),
	INVOICE_OPEN_FLAG BOOLEAN NOT NULL,
	FIRST_INVOICE_DATE DATE,
	FINAL_PAYMENT_DATE DATE,
	FIRST_INVOICE_NUMBER VARCHAR(50),
	BILL_ITERATION NUMBER(38,0),
	BILL_REPRESENTATIVE VARCHAR(100),
	BILL_SUPERVISOR VARCHAR(100),
	BILL_MANAGER VARCHAR(100),
	INVOICE_STATUS VARCHAR(50),
	WRITEOFF_FLAG BOOLEAN,
	WRITEOFF_REASON VARCHAR(100),
	AMOUNT_BILLED NUMBER(38,3),
	AMOUNT_COLLECTED NUMBER(38,3),
	AMOUNT_OUTSTANDING NUMBER(38,3),
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