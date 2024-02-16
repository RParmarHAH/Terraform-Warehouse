CREATE OR REPLACE TABLE DISC_PROD.PUBLIC.PIPELINE_CLONE_CONFIG_BACKUP_20230908 (
	ID NUMBER(38,0),
	SOURCESYSTEM VARCHAR(50),
	SOURCETYPE VARCHAR(100),
	TASKNAME VARCHAR(100),
	TASKGROUP VARCHAR(1000),
	QUERY VARCHAR(16777216),
	FLAG NUMBER(38,0),
	RUNTYPEFLAG NUMBER(38,0),
	LASTRUNDATE TIMESTAMP_NTZ(9),
	INSERTED_DATE TIMESTAMP_NTZ(9),
	INSERTED_BY VARCHAR(200),
	ORDER_BY NUMBER(38,0)
);