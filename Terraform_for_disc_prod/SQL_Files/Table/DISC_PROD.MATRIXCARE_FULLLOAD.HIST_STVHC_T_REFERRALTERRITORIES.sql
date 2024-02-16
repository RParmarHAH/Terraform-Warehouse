CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_REFERRALTERRITORIES (
	REFTER_ID NUMBER(10,0) NOT NULL,
	REFTER_NAME VARCHAR(50),
	REFTER_DESCRIPTION VARCHAR(1000),
	REFTER_BRANCHID NUMBER(10,0),
	REFTER_ACTIVE BOOLEAN,
	REFTER_CREATEDDATE TIMESTAMP_NTZ(9),
	REFTER_CREATEDUSER VARCHAR(50),
	REFTER_MODIFIEDDATE TIMESTAMP_NTZ(9),
	REFTER_MODIFIEDUSER VARCHAR(50),
	REFTER_TS VARCHAR(100),
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