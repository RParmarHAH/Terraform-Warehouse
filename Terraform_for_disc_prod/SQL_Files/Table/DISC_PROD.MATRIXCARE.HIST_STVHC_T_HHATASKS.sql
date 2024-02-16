CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_HHATASKS (
	HHAT_ID NUMBER(10,0) NOT NULL,
	HHAT_HHAC_ID NUMBER(10,0),
	HHAT_NAME VARCHAR(50),
	HHAT_ACTIVE BOOLEAN,
	HHAT_CREATEDDATE TIMESTAMP_NTZ(9),
	HHAT_CREATEDUSER VARCHAR(50),
	HHAT_MODIFIEDDATE TIMESTAMP_NTZ(9),
	HHAT_MODIFIEDUSER VARCHAR(50),
	HHAT_TS VARCHAR(100),
	HHAT_LISTITEMTYPE NUMBER(3,0),
	HHAT_BRANCHID NUMBER(10,0),
	HHAT_RPTGROUPID NUMBER(10,0),
	HHAT_OVERRIDEID NUMBER(10,0),
	HHAT_DESCRIPTION VARCHAR(1000),
	HHAT_TELEPHONYTASKID VARCHAR(4),
	HHAT_SEQUENCE NUMBER(10,0),
	HHAT_TELEPHONYENABLED BOOLEAN,
	HHAT_MEASURETYPE NUMBER(10,0),
	HHAT_UNITTYPE NUMBER(10,0),
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