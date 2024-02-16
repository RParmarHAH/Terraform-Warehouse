CREATE OR REPLACE TABLE DISC_PROD.CLEARCARE.CAREGIVER_CAREGIVER_MATCH_CRITERIA (
	ID NUMBER(38,0) NOT NULL,
	CAREGIVER_ID NUMBER(38,0),
	AGENCYMATCHINGCRITERIA_ID NUMBER(38,0),
	DATE_DELETED TIMESTAMP_TZ(9),
	AGENCY_ID NUMBER(38,0),
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