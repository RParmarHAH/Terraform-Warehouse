CREATE OR REPLACE TABLE DISC_PROD.ZENDESK.HIST_ORGANIZATIONS (
	SOURCE VARCHAR(7),
	ID VARCHAR(20),
	JSON_DATA VARIANT,
	ETL_TASK_KEY NUMBER(9,0),
	ETL_INSERTED_TASK_KEY NUMBER(9,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN
);