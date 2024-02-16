CREATE OR REPLACE TABLE DISC_PROD.EMPEONEDISON.CPOSITION (
	CO VARCHAR(10) NOT NULL,
	POSITIONCODE VARCHAR(20),
	DESCRIPTION VARCHAR(200),
	TITLE VARCHAR(50),
	CC1 VARCHAR(10),
	CC2 VARCHAR(10),
	CC3 VARCHAR(10),
	CC4 VARCHAR(10),
	CC5 VARCHAR(10),
	EEOCLASS VARCHAR(10),
	WCC VARCHAR(10),
	FLSAOVERTIMEEXEMPT BOOLEAN,
	PAYGRADE VARCHAR(10),
	JOBDESCRIPTION VARCHAR(7000),
	JOBREQUIREMENTS VARCHAR(7000),
	FTE NUMBER(6,4),
	APPROVEDDATE TIMESTAMP_NTZ(9),
	EFFECTIVEDATE TIMESTAMP_NTZ(9),
	CLOSEDDATE TIMESTAMP_NTZ(9),
	SUPERVISOR VARCHAR(100),
	SUPERVISORID VARCHAR(10),
	BUDGETED BOOLEAN,
	EMPLOYEEID VARCHAR(10),
	EMPLOYEENAME VARCHAR(40),
	GUIDFIELD VARCHAR(36),
	LASTCHANGE TIMESTAMP_NTZ(9),
	LASTCHANGEUSER VARCHAR(50),
	CMSLABORJOBCODE VARCHAR(20),
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