CREATE OR REPLACE TABLE DW_PROD.STAGE.MATRIXCARE_DIM_INVOICE_TRANSACTION_TYPE (
	TRANSACTION_TYPE_KEY VARCHAR(32) NOT NULL,
	PARENT_TRANSACTION_TYPE_KEY VARCHAR(32),
	TRANSACTION_CODE VARCHAR(32) NOT NULL,
	TRANSACTION_NAME VARCHAR(50) NOT NULL,
	TRANSACTION_DESC VARCHAR(500),
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	primary key (TRANSACTION_TYPE_KEY)
);