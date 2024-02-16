CREATE OR REPLACE TABLE DISC_PROD.SANDATAEXCHANGE.DFIMPORT_IMPORTVISITS (
	LINEID NUMBER(10,0),
	VISITKEY VARCHAR(25),
	IMPORTTASKID NUMBER(10,0),
	TIMESHEETID NUMBER(10,0),
	STATE VARCHAR(5),
	REFNO NUMBER(10,0),
	TRACKINGID NUMBER(10,0),
	CLIENTNO NUMBER(10,0),
	EMPLOYEENO NUMBER(10,0),
	CONTRACTCODE VARCHAR(5),
	BILLCODE VARCHAR(7),
	PAYROLLDATE TIMESTAMP_NTZ(9),
	WEEKENDDATE TIMESTAMP_NTZ(9),
	OFFICENO NUMBER(10,0),
	SUPERVISORCODE VARCHAR(5),
	ISIMPORTED BOOLEAN,
	READTIME TIMESTAMP_NTZ(9),
	ISVALID BOOLEAN,
	VISITCHANGETYPE NUMBER(10,0),
	SERVICEDATE TIMESTAMP_NTZ(9),
	HOURSDELTA NUMBER(18,5),
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