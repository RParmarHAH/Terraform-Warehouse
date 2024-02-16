CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_CLIENTDATETYPES (
	CLIDTTYP_ID NUMBER(10,0),
	CLIDTTYP_NAME VARCHAR(50),
	CLIDTTYP_WARN BOOLEAN,
	CLIDTTYP_ACTIVE BOOLEAN,
	CLIDTTYP_CREATEDDATE TIMESTAMP_NTZ(9),
	CLIDTTYP_CREATEDUSER VARCHAR(50),
	CLIDTTYP_MODIFIEDDATE TIMESTAMP_NTZ(9),
	CLIDTTYP_MODIFIEDUSER VARCHAR(50),
	CLIDTTYP_TS VARCHAR(100),
	CLIDTTYP_LISTITEMTYPE NUMBER(3,0),
	CLIDTTYP_RPTGROUPID NUMBER(10,0),
	CLIDTTYP_BRANCHID NUMBER(10,0),
	CLIDTTYP_OVERRIDEID NUMBER(10,0),
	CLIDTTYP_DESCRIPTION VARCHAR(1000),
	CLIDTTYP_REMINDERITEM BOOLEAN,
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