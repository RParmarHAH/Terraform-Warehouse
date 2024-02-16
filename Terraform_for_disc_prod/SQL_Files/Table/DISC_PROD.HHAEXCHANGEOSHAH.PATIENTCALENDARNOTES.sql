CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.PATIENTCALENDARNOTES (
	AGENCYID NUMBER(10,0),
	PATIENTNOTEID NUMBER(19,0),
	PATIENTID NUMBER(10,0),
	REASONID NUMBER(10,0),
	NOTEDATE TIMESTAMP_NTZ(9),
	STARTDATE TIMESTAMP_NTZ(9),
	FROMDATE TIMESTAMP_NTZ(9),
	TODATE TIMESTAMP_NTZ(9),
	PATIENTNOTE VARCHAR(16777216),
	NOTETYPE VARCHAR(25),
	URGENTMESSAGE VARCHAR(1),
	CREATEDDATE TIMESTAMP_NTZ(9),
	CREATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	STATUS BOOLEAN,
	FROMPAYERID NUMBER(19,0),
	TOPAYERID NUMBER(19,0),
	VISITID NUMBER(19,0),
	VISITDATE TIMESTAMP_NTZ(9),
	SCHEDULED VARCHAR(15),
	PRIORITY BOOLEAN,
	INTERNAL BOOLEAN,
	CAREGIVERID NUMBER(10,0),
	VISITNOTEID NUMBER(10,0),
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