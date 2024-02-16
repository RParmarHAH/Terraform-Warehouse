CREATE OR REPLACE TABLE DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_DISTRIBUTION_LIST (
	ID VARCHAR(1000),
	PARENT_DISTRIBUTION_ID VARCHAR(1000),
	OWNER_ID VARCHAR(1000),
	ORGANIZATION_ID VARCHAR(1000),
	REQUEST_STATUS VARCHAR(1000),
	REQUEST_TYPE VARCHAR(1000),
	SURVEY_ID VARCHAR(1000),
	NAME VARCHAR(1000),
	SEND_DATE VARCHAR(1000),
	CREATED_DATE VARCHAR(1000),
	MODIFIED_DATE VARCHAR(1000),
	HEADERS VARCHAR(1000),
	RECIPIENTS VARCHAR(1000),
	MESSAGE VARCHAR(1000),
	STATS VARCHAR(1000),
	SURVEY_LINK_EXPIRATION_DATE VARCHAR(1000),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN
);