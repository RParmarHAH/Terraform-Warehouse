CREATE OR REPLACE TABLE DW_PROD.STAGE.OSHAH_FACT_VISIT_EXCEPTION (
	VISIT_EXCEPTION_KEY VARCHAR(32) NOT NULL,
	VISIT_KEY VARCHAR(32) NOT NULL,
	EXCEPTION_KEY VARCHAR(32) NOT NULL,
	SERVICE_DATE DATE NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	EXCEPTION_CODE VARCHAR(100) NOT NULL,
	ACKNOWLEDGED_FLAG BOOLEAN,
	RESOLVED_FLAG BOOLEAN,
	REASON_CODE VARCHAR(200),
	REASON_NAME VARCHAR(500),
	RESOLUTION_CODE VARCHAR(500),
	RESOLUTION_NAME VARCHAR(500),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL
);