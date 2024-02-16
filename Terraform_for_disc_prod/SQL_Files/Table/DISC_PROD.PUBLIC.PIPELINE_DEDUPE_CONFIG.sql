CREATE OR REPLACE TABLE DISC_PROD.PUBLIC.PIPELINE_DEDUPE_CONFIG (
	ID NUMBER(38,0),
	SOURCESYSTEM VARCHAR(100),
	SOURCETYPE VARCHAR(100),
	CODE_FILE VARCHAR(200),
	DEDUPE_OUTPUT_FILE VARCHAR(200),
	MATCH_OUTPUT_FILE VARCHAR(200),
	SCHEMA_NAME VARCHAR(100),
	DEDUPE_TABLE_NAME VARCHAR(100),
	MATCH_TABLE_NAME VARCHAR(100),
	FLAG NUMBER(38,0),
	RUNTYPEFLAG NUMBER(38,0),
	LASTRUNDATE TIMESTAMP_NTZ(9),
	JSON_FILENAME VARCHAR(100),
	LOADTYPE VARCHAR(100),
	INSERTED_DATE TIMESTAMP_NTZ(9),
	PRIMARY_SOURCE_DATABASE_NAME VARCHAR(100),
	PRIMARY_SOURCE_SCHEMA_NAME VARCHAR(100),
	PRIMARY_SOURCE_TABLE_NAME VARCHAR(100),
	DESTINATION_DATABASE_NAME VARCHAR(100),
	DESTINATION_SCHEMA_NAME VARCHAR(100),
	DESTINATION_TABLE_NAME VARCHAR(100),
	CONTAINER_NAME VARCHAR(100),
	DIRECTORY_NAME VARCHAR(100),
	INSERTED_BY VARCHAR(200),
	UPDATED_BY VARCHAR(200)
);