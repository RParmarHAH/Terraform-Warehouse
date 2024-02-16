CREATE OR REPLACE TABLE DISC_PROD.DATAFLEXSYNCDATA.DFTIMESHEETHOURS_HISTORY (
	DBNAME VARCHAR(10),
	REFERENCENO NUMBER(10,0),
	WEEKENDDATE DATE,
	SERVICEDATE TIMESTAMP_NTZ(9),
	SERVICEDAYOFWEEK NUMBER(10,0),
	SERVICEHOURS NUMBER(12,5),
	BILLED BOOLEAN,
	STARTTIME TIMESTAMP_NTZ(9),
	ENDTIME TIMESTAMP_NTZ(9),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEBATCH VARCHAR(36),
	UPDATEDTIME TIMESTAMP_NTZ(9),
	PAID BOOLEAN,
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);