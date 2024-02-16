CREATE OR REPLACE TABLE DISC_PROD.SANDATAEXCHANGE.HIST_DFIMPORT_SANDATAVISITS (
	IMPORTVISITLINEID NUMBER(10,0) NOT NULL,
	VISITKEY VARCHAR(25),
	IMPORTTASKID NUMBER(10,0),
	TIMESHEETID NUMBER(10,0),
	AGENCYID VARCHAR(10),
	VISITID NUMBER(10,0),
	CLIENTID NUMBER(10,0),
	CLIENTNAME VARCHAR(75),
	CLIENTLOCATION VARCHAR(10),
	EMPLOYEEID NUMBER(10,0),
	EMPLOYEENAME VARCHAR(75),
	ADMISSIONTYPEID VARCHAR(10),
	SERVICECODE VARCHAR(10),
	EVENTID VARCHAR(10),
	TIMEIN TIMESTAMP_NTZ(9),
	TIMEOUT TIMESTAMP_NTZ(9),
	TIMEZONE VARCHAR(10),
	STATUSCODE VARCHAR(5),
	IMPORTBATCHID NUMBER(10,0),
	CHANGEDTIME TIMESTAMP_NTZ(9),
	SERVICEDATE TIMESTAMP_NTZ(9),
	HOURS NUMBER(18,5),
	IMPORTEDTODF BOOLEAN,
	ALLOWFUTUREIMPORT BOOLEAN,
	UPDATETIME TIMESTAMP_NTZ(9),
	UPDATETASKID NUMBER(10,0),
	ARCHIVETIME TIMESTAMP_NTZ(9),
	READTIME TIMESTAMP_NTZ(9),
	IMPORTKEY VARCHAR(50),
	ORIGINALHOURS NUMBER(18,5),
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