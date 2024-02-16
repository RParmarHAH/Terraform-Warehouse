CREATE OR REPLACE TABLE DISC_PROD.CLEARCARE.HIST_CARELOGS_SIGNATURE (
	ID NUMBER(38,0) NOT NULL,
	CARELOG_ID NUMBER(38,0),
	CCI_TIMESTAMP TIMESTAMP_TZ(9),
	NAME VARCHAR(16383),
	SOURCE VARCHAR(16383),
	RECORDING_SID VARCHAR(16383),
	RECORDING_PROCESSED BOOLEAN,
	AUDIO VARCHAR(16383),
	SIGNATURE_TYPE NUMBER(38,0),
	SIGNED BOOLEAN,
	CCI_SIGNED_DATA VARCHAR(16383),
	CREATED TIMESTAMP_TZ(9),
	SCANNED_SIGNATURE_FILE VARCHAR(16383),
	UPDATED TIMESTAMP_TZ(9),
	DELETED TIMESTAMP_TZ(9),
	ORIGINATOR_ID NUMBER(38,0),
	LAST_UPDATED_BY_ID NUMBER(38,0),
	DELETED_BY_ID NUMBER(38,0),
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