CREATE OR REPLACE TABLE DISC_PROD.WORKDAY.RELATED_PERSON_PHONE_DATA (
	RELATED_PERSON_ID VARCHAR(16777216),
	OPERATION VARCHAR(16777216),
	PHONE_TYPE VARCHAR(16777216),
	PHONE_DEVICE_TYPE VARCHAR(16777216),
	PHONE_IS_PUBLIC BOOLEAN,
	IS_PRIMARY BOOLEAN,
	FORMATTED_PHONE_NUMBER VARCHAR(16777216),
	PHONE_AREA_CODE VARCHAR(16777216),
	PHONE_NUMBER VARCHAR(16777216),
	COMPLETE_PHONE_NUMBER VARCHAR(16777216),
	LANDING_INSERTED_DATE TIMESTAMP_NTZ(9),
	LANDING_INSERTED_BY VARCHAR(16777216),
	PROCESSED_TIMESTAMP TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN,
	FILE VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9)
);