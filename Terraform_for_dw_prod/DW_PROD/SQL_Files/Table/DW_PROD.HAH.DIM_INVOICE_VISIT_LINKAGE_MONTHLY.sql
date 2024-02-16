CREATE OR REPLACE TABLE DW_PROD.HAH.DIM_INVOICE_VISIT_LINKAGE_MONTHLY (
	REVENUE_KEY VARCHAR(32) NOT NULL,
	VISIT_KEY VARCHAR(32) NOT NULL,
	VISIT_ID VARCHAR(50),
	SERVICE_DATE DATE,
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	MONTH_DATE DATE
);