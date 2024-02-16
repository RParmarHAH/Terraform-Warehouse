CREATE OR REPLACE TABLE DW_PROD.STAGE.DATAFLEXSYNCDATA_FACT_INVOICE_TRACKING (
	INVOICE_TRACKING_KEY VARCHAR(32) NOT NULL,
	REPORT_DATE DATE NOT NULL,
	BRANCH_KEY VARCHAR(32) NOT NULL,
	CLIENT_KEY VARCHAR(32) NOT NULL,
	CONTRACT_KEY VARCHAR(32) NOT NULL,
	INVOICE_KEY VARCHAR(32) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	TRACKING_DATE DATE NOT NULL,
	BRANCH_NAME VARCHAR(100),
	CLIENT_NUMBER NUMBER(38,0),
	CONTRACT_CODE VARCHAR(10),
	INVOICE_NUMBER VARCHAR(50),
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	SERVICE_AREA VARCHAR(20),
	AMOUNT_TYPE VARCHAR(50),
	TRACKING_TYPE VARCHAR(50),
	REJECTION_REASON_CODE VARCHAR(50),
	REJECTION_REASON_DESCRIPTION VARCHAR(100),
	TRACKING_COUNT NUMBER(38,0),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL
);