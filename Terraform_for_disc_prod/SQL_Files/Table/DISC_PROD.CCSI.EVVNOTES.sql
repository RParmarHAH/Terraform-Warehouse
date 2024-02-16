CREATE OR REPLACE TABLE DISC_PROD.CCSI.EVVNOTES (
	RECORD_NUMBER NUMBER(38,0),
	DATE VARCHAR(100),
	TIME VARCHAR(100),
	CLIENT VARCHAR(500),
	WORKER_NO VARCHAR(100),
	WORKER_NAME VARCHAR(500),
	NOTE_1 VARCHAR(1000),
	NOTE_2 VARCHAR(1000),
	NOTE_3 VARCHAR(1000),
	NOTE_4 VARCHAR(1000),
	FOLLOW_UP VARCHAR(1),
	DESK VARCHAR(100),
	PRINTED VARCHAR(100),
	PUNCH_DATE VARCHAR(100),
	PUNCH_TIME VARCHAR(100),
	PUNCH_IN_OUT VARCHAR(100),
	HCA_HAS_SMARTPHONE VARCHAR(100),
	CALLER_ID VARCHAR(100),
	SHARED_CODE VARCHAR(100),
	CREATED_DATE VARCHAR(100),
	CREATED_BY VARCHAR(10),
	UPDATED_DATE VARCHAR(1000),
	UPDATED_BY VARCHAR(10),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);