CREATE OR REPLACE TABLE DISC_PROD.WORKDAY.HIST_WORKER_LEAVE_OF_ABSENCE (
	EMPLOYEE_ID VARCHAR(100) NOT NULL,
	OPERATION VARCHAR(16777216),
	ON_LEAVE BOOLEAN,
	LEAVE_OF_ABSENCE_TYPE VARCHAR(16777216),
	LANDING_INSERTED_DATE TIMESTAMP_NTZ(9),
	LANDING_INSERTED_BY VARCHAR(16777216),
	PROCESSED_TIMESTAMP TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN,
	FILE VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9)
);