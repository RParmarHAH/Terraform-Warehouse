CREATE OR REPLACE TABLE DISC_PROD.PUBLIC.PIPELINE_DEDUPE_CONFIG_NEW (
	ID VARCHAR(16777216),
	SOURCESYSTEM VARCHAR(16777216),
	SOURCETYPE VARCHAR(16777216),
	SOURCE VARCHAR(16777216),
	TASK_NAME VARCHAR(16777216),
	TASK_GROUP VARCHAR(16777216),
	CODE_FILE VARCHAR(16777216),
	DEDUPE_TYPE VARCHAR(16777216),
	DEDUPE_OUTPUT_FILE VARCHAR(16777216),
	CONFIG VARCHAR(16777216),
	PRIMARY_SOURCE_DATABASE_NAME VARCHAR(16777216),
	PRIMARY_SOURCE_SCHEMA_NAME VARCHAR(16777216),
	PRIMARY_SOURCE_TABLE_NAME VARCHAR(16777216),
	DESTINATION_DATABASE_NAME VARCHAR(16777216),
	DESTINATION_SCHEMA_NAME VARCHAR(16777216),
	DESTINATION_TABLE_NAME VARCHAR(16777216),
	CONTAINER_NAME VARCHAR(16777216),
	DIRECTORY_NAME VARCHAR(16777216),
	LOADTYPE VARCHAR(16777216),
	FLAG VARCHAR(16777216),
	RUNTYPEFLAG VARCHAR(16777216),
	LASTRUNDATE TIMESTAMP_NTZ(9),
	INSERTED_DATE TIMESTAMP_NTZ(9),
	INSERTED_BY VARCHAR(200),
	UPDATED_BY VARCHAR(200),
	TEMP_STATUES_CHECK VARCHAR(16777216)
);