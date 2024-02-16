CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEEDISON.CALLMAINTENANCE (
	AGENCYID NUMBER(10,0),
	OFFICEID NUMBER(10,0),
	MAINTENANCEID NUMBER(10,0),
	AIDEID NUMBER(10,0),
	ASSIGNMENTID VARCHAR(20),
	CALLERID VARCHAR(12),
	DIALEDNUMBER VARCHAR(12),
	CALLTYPE VARCHAR(4),
	CALLTIME TIMESTAMP_NTZ(9),
	CALLDURATION NUMBER(10,0),
	STATUS VARCHAR(50),
	DUTYSHEET VARCHAR(16777216),
	DUTIES VARCHAR(16777216),
	CALLUNIQUEID VARCHAR(100),
	EVVSOURCE VARCHAR(10),
	EVVTYPE VARCHAR(10),
	EVVDEVICEID VARCHAR(10),
	EVVTOKENID VARCHAR(10),
	EVVCALLTIME TIMESTAMP_NTZ(9),
	EVVPATIENTID NUMBER(19,0),
	GPSDISTANCE FLOAT,
	MODIFIEDDATE TIMESTAMP_NTZ(9),
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