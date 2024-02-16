CREATE OR REPLACE TABLE DISC_PROD.SANDATAIMPORT.HIST_SANDATA_SCHEDULESTASKS (
	ID NUMBER(10,0) NOT NULL,
	AGENCYID VARCHAR(25),
	SCHEDULEID NUMBER(10,0),
	TASKID NUMBER(10,0),
	TASKNAME VARCHAR(64),
	CREATEDAT TIMESTAMP_NTZ(9),
	UPDATEDAT TIMESTAMP_NTZ(9),
	HASHEDROWVALUES VARCHAR(250),
	BATCHID NUMBER(10,0),
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