CREATE OR REPLACE TABLE DISC_PROD.CLEARCARE.FRANCHISES_FRANCHISORACTIVITYTAG (
	ID NUMBER(38,0) NOT NULL,
	CREATED TIMESTAMP_TZ(9),
	UPDATED TIMESTAMP_TZ(9),
	DELETED TIMESTAMP_TZ(9),
	NAME VARCHAR(16383),
	MODIFIED_NAME VARCHAR(16383),
	IS_PUBLISHED BOOLEAN,
	DELETED_BY_ID NUMBER(38,0),
	LAST_UPDATED_BY_ID NUMBER(38,0),
	ORIGINATOR_ID NUMBER(38,0),
	PARENT_ID NUMBER(38,0),
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