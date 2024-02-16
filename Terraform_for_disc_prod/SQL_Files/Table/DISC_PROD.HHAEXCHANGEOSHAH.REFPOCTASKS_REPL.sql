CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.REFPOCTASKS_REPL (
	AGENCYID NUMBER(19,0),
	POCTASKID NUMBER(10,0) NOT NULL,
	POCTASKCODE NUMBER(10,0),
	POCCATEGORYID NUMBER(10,0),
	TASKNAME VARCHAR(200),
	ACTIVE BOOLEAN,
	POCMASTERID NUMBER(19,0),
	DUTYLISTSETUPID NUMBER(10,0),
	ALLOWADDITIONALPROMPTS BOOLEAN,
	NUMBEROFDIGITS NUMBER(3,0),
	DISPLAYDECIMAL BOOLEAN,
	DECIMALLENGTH NUMBER(3,0),
	MINALLOWABLEENTRY VARCHAR(20),
	MAXALLOWABLEENTRY VARCHAR(20),
	ALLOWMILEAGE VARCHAR(10),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
	LASTMODIFIEDBY NUMBER(10,0),
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