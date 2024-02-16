CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEEDISON.REJECTEDCALLS (
	AGENCYID NUMBER(10,0),
	REJECTEDCALLID NUMBER(19,0),
	MAINTENANCEID NUMBER(10,0),
	ASSIGNMENTID VARCHAR(20),
	CAREGIVERID NUMBER(19,0),
	CAREGIVERNAME VARCHAR(200),
	CAREGIVERCODE VARCHAR(100),
	OFFICEID NUMBER(10,0),
	OFFICENAME VARCHAR(100),
	CAREGIVERPHONE1 VARCHAR(50),
	CAREGIVERPHONE2 VARCHAR(50),
	CAREGIVERTEAM VARCHAR(100),
	PATIENTNAME VARCHAR(2000),
	CALLDATE DATE,
	CALLTIME_0 VARCHAR(50),
	CALLTYPE VARCHAR(4),
	CALLERID VARCHAR(50),
	STATUS VARCHAR(50),
	EVVSOURCE VARCHAR(20),
	EVVTYPE VARCHAR(20),
	DUTYSHEETCOUNT NUMBER(10,0),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
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