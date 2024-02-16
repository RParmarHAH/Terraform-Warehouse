CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_CLIENTINQUIRYRATING (
	CLIINQRAT_ID NUMBER(10,0) NOT NULL,
	CLIINQRAT_NAME VARCHAR(50),
	CLIINQRAT_DESCRIPTION VARCHAR(1000),
	CLIINQRAT_ACTIVE BOOLEAN,
	CLIINQRAT_CREATEDDATE TIMESTAMP_NTZ(9),
	CLIINQRAT_CREATEDUSER VARCHAR(50),
	CLIINQRAT_MODIFIEDDATE TIMESTAMP_NTZ(9),
	CLIINQRAT_MODIFIEDUSER VARCHAR(50),
	CLIINQRAT_TS VARCHAR(100),
	CLIINQRAT_LISTITEMTYPE NUMBER(3,0),
	CLIINQRAT_RPTGROUPID NUMBER(10,0),
	CLIINQRAT_BRANCHID NUMBER(10,0),
	CLIINQRAT_OVERRIDEID NUMBER(10,0),
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