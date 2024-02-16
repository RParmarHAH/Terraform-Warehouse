CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_INVOICEGROUPINGTYPE (
	INVGR_ID NUMBER(10,0),
	INVGR_NAME VARCHAR(50),
	INVGR_DESCRIPTION VARCHAR(1000),
	INVGR_SPSTAMPID VARCHAR(50),
	INVGR_SPDYNAMICGROUP VARCHAR(50),
	INVGR_ACTIVE BOOLEAN,
	INVGR_CREATEDDATE TIMESTAMP_NTZ(9),
	INVGR_CREATEDUSER VARCHAR(50),
	INVGR_MODIFIEDDATE TIMESTAMP_NTZ(9),
	INVGR_MODIFIEDUSER VARCHAR(50),
	INVGR_TS VARCHAR(100),
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