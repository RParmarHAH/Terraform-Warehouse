CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_ACTIVITIES (
	ACT_ID NUMBER(19,0) NOT NULL,
	ACT_BRANCHID NUMBER(10,0),
	ACT_STARTTIME TIMESTAMP_NTZ(9),
	ACT_ENDTIME TIMESTAMP_NTZ(9),
	ACT_ACTIVITYCATEGORYID NUMBER(10,0),
	ACT_ACTIVITYTYPEID NUMBER(10,0),
	ACT_ACTIVITYRESULTID NUMBER(10,0),
	ACT_SUBJECT VARCHAR(256),
	ACT_NOTES VARCHAR(16777216),
	ACT_ACTIVITYSHARELEVELID NUMBER(10,0),
	ACT_RECURRENCEID NUMBER(19,0),
	ACT_ISRECURRINGAPPOINTMENTROOT BOOLEAN,
	ACT_CREATEDDATE TIMESTAMP_NTZ(9),
	ACT_CREATEDUSER VARCHAR(50),
	ACT_MODIFIEDDATE TIMESTAMP_NTZ(9),
	ACT_MODIFIEDUSER VARCHAR(50),
	ACT_TS VARCHAR(100),
	ACT_FOLLOWUPDATE TIMESTAMP_NTZ(9),
	ACT_LEGACYID NUMBER(10,0),
	ACT_DISMISS BOOLEAN,
	ACT_REMINDERNOTES VARCHAR(2048),
	ACT_ASSOCIATEDCOSTS NUMBER(18,2),
	ACT_LETTERID NUMBER(10,0),
	ACT_DISPLAYONCALENDAR BOOLEAN,
	ACT_STARTOFFSET NUMBER(5,0),
	ACT_ENDOFFSET NUMBER(5,0),
	ACT_TIMEZONEID NUMBER(5,0),
	INSERTDATE TIMESTAMP_NTZ(9),
	UPDATEDATE TIMESTAMP_NTZ(9),
	DELETEDFLAG BOOLEAN,
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