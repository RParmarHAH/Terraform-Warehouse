CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_CAREGIVERGROUP (
	CARG_ID NUMBER(10,0) NOT NULL,
	CARG_NAME VARCHAR(50),
	CARG_ACTIVE BOOLEAN,
	CARG_CREATEDUSER VARCHAR(50),
	CARG_CREATEDDATE TIMESTAMP_NTZ(9),
	CARG_MODIFIEDUSER VARCHAR(50),
	CARG_MODIFIEDDATE TIMESTAMP_NTZ(9),
	CARG_TS VARCHAR(100),
	CARG_LISTITEMTYPE NUMBER(3,0),
	CARG_RPTGROUPID NUMBER(10,0),
	CARG_BRANCHID NUMBER(10,0),
	CARG_OVERRIDEID NUMBER(10,0),
	CARG_DESCRIPTION VARCHAR(1000),
	CARG_ISCONTRACTOR BOOLEAN,
	CARG_AUTOCALCTRAVEL BOOLEAN,
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