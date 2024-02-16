CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.TBL_GEOCODESTATUSBACKUP1 (
	INT_STATUSID NUMBER(10,0),
	UNIQUEID VARCHAR(9) NOT NULL,
	TABLENAME VARCHAR(15) NOT NULL,
	DTM_SAVEDTM TIMESTAMP_NTZ(9) NOT NULL,
	GEOCODESTATUS VARCHAR(100) NOT NULL,
	ERRORMESSAGE VARCHAR(1000),
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