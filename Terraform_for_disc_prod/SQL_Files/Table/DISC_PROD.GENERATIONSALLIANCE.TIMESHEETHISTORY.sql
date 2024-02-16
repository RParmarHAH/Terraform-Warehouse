CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.TIMESHEETHISTORY (
	ID NUMBER(10,0) NOT NULL,
	PAYPERIODID NUMBER(10,0),
	DATETIME TIMESTAMP_NTZ(9),
	FUNCTION VARCHAR(20),
	USERNAME VARCHAR(100),
	REC_ADDED NUMBER(10,0),
	REC_UPDATED NUMBER(10,0),
	REC_DELETED NUMBER(10,0),
	CHKBILLEPAID BOOLEAN,
	CHKRECVD BOOLEAN,
	TOTALPROCESSED NUMBER(10,0),
	CHKCONFIRMEDONLY BOOLEAN,
	CHKINCAVAILABLESHIFT BOOLEAN,
	CHKSPLITMIDNIGHT BOOLEAN,
	REC_EXPENSECOUNT NUMBER(10,0),
	REC_COUNTBILLEDORPAID NUMBER(10,0),
	REC_DELETEDEXPENSECOUNT NUMBER(10,0),
	STATUS VARCHAR(1),
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