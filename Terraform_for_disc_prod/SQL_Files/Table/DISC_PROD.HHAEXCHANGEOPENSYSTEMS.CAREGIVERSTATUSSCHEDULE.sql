CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CAREGIVERSTATUSSCHEDULE (
	AGENCYID NUMBER(10,0) NOT NULL,
	STATUSSCHEDULEID NUMBER(19,0) NOT NULL,
	CAREGIVERID NUMBER(19,0),
	SCHEDULEDATE TIMESTAMP_NTZ(9),
	STATUSID NUMBER(19,0),
	CURRENTSTATUS VARCHAR(50),
	REASONID NUMBER(19,0),
	NOTE VARCHAR(500),
	CREATEDBY NUMBER(19,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	TERMINATIONDATE TIMESTAMP_NTZ(9),
	SENT105 BOOLEAN,
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	STATUSCHANGED BOOLEAN,
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