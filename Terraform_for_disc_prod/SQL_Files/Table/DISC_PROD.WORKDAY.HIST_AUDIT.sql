CREATE OR REPLACE TABLE DISC_PROD.WORKDAY.HIST_AUDIT (
	VERSION VARCHAR(16777216),
	PRIOR_ENTRY_TIME VARCHAR(16777216),
	CURRENT_ENTRY_TIME VARCHAR(16777216),
	PRIOR_EFFECTIVE_TIME VARCHAR(16777216),
	CURRENT_EFFECTIVE_TIME VARCHAR(16777216),
	FULL_FILE BOOLEAN,
	DOCUMENT_RETENTION_POLICY VARCHAR(16777216),
	WORKER_COUNT VARCHAR(16777216),
	LANDING_INSERTED_DATE TIMESTAMP_NTZ(9),
	LANDING_INSERTED_BY VARCHAR(16777216),
	FILE VARCHAR(16777216),
	PROCESSED_TIMESTAMP TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9)
);