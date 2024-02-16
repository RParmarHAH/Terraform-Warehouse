CREATE OR REPLACE TABLE DISC_PROD.PUBLIC.PIPELINE_CONFIG_BUSINESS_AWS_FINAL (
	ID NUMBER(38,0),
	SOURCESYSTEM VARCHAR(50),
	SOURCETYPE VARCHAR(100),
	TASKNAME VARCHAR(100),
	TASKGROUP VARCHAR(1000),
	PRIMARY_SOURCE_DATABASE_NAME VARCHAR(100),
	PRIMARY_SOURCE_SCHEMA_NAME VARCHAR(100),
	PRIMARY_SOURCE_TABLE_NAME VARCHAR(1000),
	PRIMARY_SOURCE_JOIN_KEYS VARCHAR(400),
	SYS_CHANGE_VERSION_START VARCHAR(100),
	DESTINATION_DATABASE_NAME VARCHAR(1000),
	DESTINATION_SCHEMA_NAME VARCHAR(100),
	DESTINATION_TABLE_NAME VARCHAR(100),
	DESTINATION_VIEW_NAME VARCHAR(1000),
	CDCTYPE VARCHAR(100),
	BLOBCONTAINER VARCHAR(100),
	SQLCONTAINER VARCHAR(100),
	SQLDIRECTORY VARCHAR(100),
	SQLINSERTFILENAME VARCHAR(100),
	FLAG NUMBER(38,0),
	DAILY NUMBER(38,0),
	WEEKLY NUMBER(38,0),
	BLOBDIRECTORY VARCHAR(100),
	ARCHIVE_DIRECTORY VARCHAR(100),
	LOADTYPE VARCHAR(100),
	JSON_FILENAME VARCHAR(500),
	PIPELINETYPE VARCHAR(100),
	ARCHIVE_CONTAINER VARCHAR(100),
	RUNTYPEFLAG NUMBER(38,0),
	LASTRUNDATE TIMESTAMP_NTZ(9),
	INSERTED_DATE TIMESTAMP_NTZ(9),
	REMARK VARCHAR(1000),
	INSERTED_BY VARCHAR(200),
	UPDATED_BY VARCHAR(200),
	TEMP_STATUES_CHECK VARCHAR(16777216),
	TOLD_BY VARCHAR(50)
);