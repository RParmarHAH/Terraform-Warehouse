CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_DIAGNOSISCATEGORIES (
	DIAGC_ID NUMBER(10,0),
	DIAGC_NAME VARCHAR(50),
	DIAGC_ACTIVE BOOLEAN,
	DIAGC_CREATEDDATE TIMESTAMP_NTZ(9),
	DIAGC_CREATEDUSER VARCHAR(50),
	DIAGC_MODIFIEDDATE TIMESTAMP_NTZ(9),
	DIAGC_MODIFIEDUSER VARCHAR(50),
	DIAGC_TS VARCHAR(100),
	DIAGC_DESCRIPTION VARCHAR(1000),
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