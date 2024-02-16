CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_ACTIVITYRESULTS (
	ACTRSLT_ID NUMBER(10,0) NOT NULL,
	ACTRSLT_ACTIVITYCATEGORYID NUMBER(10,0),
	ACTRSLT_ACTIVE BOOLEAN,
	ACTRSLT_CREATEDDATE TIMESTAMP_NTZ(9),
	ACTRSLT_CREATEDUSER VARCHAR(50),
	ACTRSLT_MODIFIEDDATE TIMESTAMP_NTZ(9),
	ACTRSLT_MODIFIEDUSER VARCHAR(50),
	ACTRSLT_TS VARCHAR(100),
	ACTRSLT_NAME VARCHAR(50),
	ACTRSLT_LISTITEMTYPE NUMBER(3,0),
	ACTRSLT_RPTGROUPID NUMBER(10,0),
	ACTRSLT_BRANCHID NUMBER(10,0),
	ACTRSLT_OVERRIDEID NUMBER(10,0),
	ACTRSLT_DESCRIPTION VARCHAR(1000),
	INSERTDATE TIMESTAMP_NTZ(9),
	UPDATEDATE TIMESTAMP_NTZ(9),
	DELETEDFLAG BOOLEAN,
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