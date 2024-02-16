CREATE OR REPLACE TABLE DISC_PROD.CLEARCARE.ASSESSMENT_LIFEACTIVITY (
	ID NUMBER(38,0) NOT NULL,
	CREATED TIMESTAMP_TZ(9),
	UPDATED TIMESTAMP_TZ(9),
	AGENCY_ID NUMBER(38,0),
	NAME VARCHAR(16383),
	DESCRIPTION VARCHAR(16383),
	ACTIVITY_TYPE NUMBER(38,0),
	BENCHMARKS VARCHAR(16383),
	DELETED TIMESTAMP_TZ(9),
	ORIGINATOR_ID NUMBER(38,0),
	LAST_UPDATED_BY_ID NUMBER(38,0),
	DELETED_BY_ID NUMBER(38,0),
	DATE_DELETED TIMESTAMP_TZ(9),
	FRANCHISOR_ID NUMBER(38,0),
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL
);