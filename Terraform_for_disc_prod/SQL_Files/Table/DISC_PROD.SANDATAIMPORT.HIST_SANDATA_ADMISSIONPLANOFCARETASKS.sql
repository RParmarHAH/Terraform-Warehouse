CREATE OR REPLACE TABLE DISC_PROD.SANDATAIMPORT.HIST_SANDATA_ADMISSIONPLANOFCARETASKS (
	ID NUMBER(10,0) NOT NULL,
	AGENCYID VARCHAR(25),
	PHID NUMBER(10,0),
	ADMISSIONID NUMBER(10,0),
	SERVICEID VARCHAR(6),
	BEGINDATE TIMESTAMP_NTZ(9),
	ENDDATE TIMESTAMP_NTZ(9),
	PLANID NUMBER(19,0),
	TASKID VARCHAR(6),
	DAYSPERWEEK NUMBER(3,0),
	SUN BOOLEAN,
	MON BOOLEAN,
	TUE BOOLEAN,
	WED BOOLEAN,
	THU BOOLEAN,
	FRI BOOLEAN,
	SAT BOOLEAN,
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