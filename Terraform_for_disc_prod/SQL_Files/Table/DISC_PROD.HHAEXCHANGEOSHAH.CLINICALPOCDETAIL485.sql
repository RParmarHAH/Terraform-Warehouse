CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.CLINICALPOCDETAIL485 (
	AGENCYID NUMBER(10,0) NOT NULL,
	POCDETAIL485ID NUMBER(10,0) NOT NULL,
	POCHEADER485ID NUMBER(10,0),
	MASTER485ID NUMBER(10,0),
	PATIENTID NUMBER(10,0),
	POCTASKID NUMBER(10,0),
	POCPERREQUIRED BOOLEAN,
	TIMESPERWEEK NUMBER(10,0),
	MINUTES NUMBER(5,0),
	TIMESPERWEEKMIN NUMBER(5,0),
	TIMESPERWEEKMAX NUMBER(5,0),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	TASKNAME VARCHAR(200),
	SUNDAY BOOLEAN,
	MONDAY BOOLEAN,
	TUESDAY BOOLEAN,
	WEDNESDAY BOOLEAN,
	THURSDAY BOOLEAN,
	FRIDAY BOOLEAN,
	SATURDAY BOOLEAN,
	ASNEEDED BOOLEAN,
	TASKINSTRUCTION VARCHAR(250),
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