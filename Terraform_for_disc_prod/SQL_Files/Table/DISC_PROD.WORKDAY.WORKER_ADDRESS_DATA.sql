CREATE OR REPLACE TABLE DISC_PROD.WORKDAY.WORKER_ADDRESS_DATA (
	EMPLOYEE_ID VARCHAR(100) NOT NULL,
	ADDRESS_TYPE VARCHAR(16777216),
	IS_PRIMARY BOOLEAN,
	ADDRESS_LINE_DATA VARCHAR(16777216),
	ADDRESS_LINE_DATA_2 VARCHAR(16777216),
	MUNICIPALITY VARCHAR(16777216),
	REGION VARCHAR(16777216),
	SUBREGION VARCHAR(16777216),
	POSTAL_CODE VARCHAR(16777216),
	COUNTRY VARCHAR(16777216),
	ADDRESS_IS_PUBLIC VARCHAR(16777216),
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