CREATE OR REPLACE TABLE DW_PROD.STAGE.OPENSYSTEMS_DIM_VISIT_EXCEPTION (
	EXCEPTION_KEY VARCHAR(32) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	EXCEPTION_CODE VARCHAR(100) NOT NULL,
	EXCEPTION_DESC VARCHAR(200),
	EXCEPTION_CATEGORY VARCHAR(100),
	CATEGORY_KEY VARCHAR(50) NOT NULL,
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL
);