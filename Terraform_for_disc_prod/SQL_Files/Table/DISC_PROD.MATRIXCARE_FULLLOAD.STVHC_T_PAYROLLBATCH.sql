CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_PAYROLLBATCH (
	PROLLB_ID NUMBER(19,0),
	PROLLB_BRANCHID NUMBER(10,0),
	PROLLB_EXTRACTTYPEID NUMBER(10,0),
	PROLLB_PAYDATE TIMESTAMP_NTZ(9),
	PROLLB_FINALIZEDDATE TIMESTAMP_NTZ(9),
	PROLLB_CAREGIVERGROUPID NUMBER(10,0),
	PROLLB_PAYROLLCOMPANYEXTRACTTYPEID NUMBER(10,0),
	PROLLB_LASTPRCOMPANYEXTRACTDATE TIMESTAMP_NTZ(9),
	PROLLB_LASTPRCOMPANYEXTRACTUSER VARCHAR(50),
	PROLLB_CREATEDDATE TIMESTAMP_NTZ(9),
	PROLLB_CREATEDUSER VARCHAR(50),
	PROLLB_MODIFIEDDATE TIMESTAMP_NTZ(9),
	PROLLB_MODIFIEDUSER VARCHAR(50),
	PROLLB_TS VARCHAR(100),
	PROLLB_CANCELUSER VARCHAR(50),
	PROLLB_CANCELDATE TIMESTAMP_NTZ(9),
	PROLLB_SERVICETHROUGHDATE TIMESTAMP_NTZ(9),
	PROLLB_LASTDRAFTDATE TIMESTAMP_NTZ(9),
	PROLLB_LASTDRAFTUSER VARCHAR(50),
	PROLLB_CAREGIVERID NUMBER(19,0),
	PROLLB_OTSETTINGS VARCHAR(16777216),
	PROLLB_ISHOLIDAYOTELIGIBLE BOOLEAN,
	INSERTDATE TIMESTAMP_NTZ(9),
	UPDATEDATE TIMESTAMP_NTZ(9),
	DELETEDFLAG BOOLEAN,
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