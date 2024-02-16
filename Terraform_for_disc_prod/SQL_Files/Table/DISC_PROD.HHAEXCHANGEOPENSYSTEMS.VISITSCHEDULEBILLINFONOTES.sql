CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.VISITSCHEDULEBILLINFONOTES (
	AGENCYID NUMBER(10,0) NOT NULL,
	SCHEDULEBILLINFONOTEID NUMBER(19,0) NOT NULL,
	VISITID NUMBER(19,0),
	REASON VARCHAR(16777216),
	NOTES VARCHAR(16777216),
	USERNAME VARCHAR(200),
	ACTIONTAKENREASON VARCHAR(16777216),
	CAPTURESCHEDULENOTE NUMBER(5,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
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