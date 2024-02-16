CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_CLIENTBRANCHES (
	CLIBR_ID NUMBER(19,0),
	CLIBR_CLIENTID NUMBER(19,0),
	CLIBR_BRANCH_ID NUMBER(10,0),
	CLIBR_CREATEDUSER VARCHAR(50),
	CLIBR_CREATEDDATE TIMESTAMP_NTZ(9),
	CLIBR_MODIFIEDUSER VARCHAR(50),
	CLIBR_MODIFIEDDATE TIMESTAMP_NTZ(9),
	CLIBR_TS VARCHAR(100),
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