CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVERREFERRALTYPE (
	CARREFT_ID NUMBER(10,0),
	CARREFT_NAME VARCHAR(50),
	CARREFT_ACTIVE BOOLEAN,
	CARREFT_CREATEDDATE TIMESTAMP_NTZ(9),
	CARREFT_CREATEDUSER VARCHAR(50),
	CARREFT_MODIFIEDDATE TIMESTAMP_NTZ(9),
	CARREFT_MODIFIEDUSER VARCHAR(50),
	CARREFT_TS VARCHAR(100),
	CARREFT_LISTITEMTYPE NUMBER(3,0),
	CARREFT_RPTGROUPID NUMBER(10,0),
	CARREFT_BRANCHID NUMBER(10,0),
	CARREFT_OVERRIDEID NUMBER(10,0),
	CARREFT_DESCRIPTION VARCHAR(1000),
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