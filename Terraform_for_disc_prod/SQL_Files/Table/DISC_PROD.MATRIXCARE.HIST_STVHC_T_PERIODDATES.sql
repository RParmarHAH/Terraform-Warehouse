CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_PERIODDATES (
	PRDCLS_ID NUMBER(19,0) NOT NULL,
	PRDCLS_BRANCHID NUMBER(10,0),
	PRDCLS_PERIODCLOSINGTYPEID NUMBER(10,0),
	PRDCLS_PERIODENDDATE TIMESTAMP_NTZ(9),
	PRDCLS_ACTUALCLOSINGDATE TIMESTAMP_NTZ(9),
	PRDCLS_PERIODDESCRIPTION VARCHAR(50),
	PRDCLS_NOTES VARCHAR(500),
	PRDCLS_CREATEDDATE TIMESTAMP_NTZ(9),
	PRDCLS_CREATEDUSER VARCHAR(50),
	PRDCLS_MODIFIEDDATE TIMESTAMP_NTZ(9),
	PRDCLS_MODIFIEDUSER VARCHAR(50),
	PRDCLS_TS VARCHAR(100),
	PRDCLS_ACCTEXTRACTID NUMBER(19,0),
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