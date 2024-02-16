CREATE OR REPLACE TABLE DISC_PROD.DEVERO.HIST_DEVERO_PHYSICIAN (
	PHYSICIAN_ID VARCHAR(16777216),
	PHYSICIAN_XML VARCHAR(16777216),
	DATE_MODIFIED VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN
);