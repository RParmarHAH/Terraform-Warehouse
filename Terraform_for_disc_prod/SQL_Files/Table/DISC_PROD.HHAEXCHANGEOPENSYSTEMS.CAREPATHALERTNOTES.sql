CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CAREPATHALERTNOTES (
	AGENCYID NUMBER(10,0),
	VISITFEEDBACKACTIONID NUMBER(10,0) NOT NULL,
	VISITFEEDBACKDETAILID NUMBER(10,0),
	PATIENTID NUMBER(10,0),
	PATIENT VARCHAR(1000),
	VISITID NUMBER(19,0),
	CAREGIVERID NUMBER(10,0),
	CREATEDDATE VARCHAR(250),
	NURSENAME VARCHAR(250),
	NURSEID NUMBER(10,0),
	ACTIONTAKEN VARCHAR(1000),
	NOTE VARCHAR(16777216),
	NOTEPREVIOUSSTATUS VARCHAR(20),
	NOTECURRENTSTATUS VARCHAR(20),
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