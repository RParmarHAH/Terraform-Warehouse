CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.EVVIVRCALLLOG (
	AGENCYID NUMBER(10,0),
	CALLFLOWID NUMBER(10,0) NOT NULL,
	CALLTIME TIMESTAMP_NTZ(9),
	CALLTYPE VARCHAR(20),
	ASSIGNMENTID VARCHAR(20),
	CALLERID VARCHAR(50),
	DIALEDNUMBER VARCHAR(50),
	EVVSOURCE VARCHAR(10),
	EVVTYPE VARCHAR(10),
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