CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_BRANCHTAXES (
	BRTX_ID NUMBER(10,0) NOT NULL,
	BRTX_GROUPID NUMBER(10,0),
	BRTX_TAXTYPEID NUMBER(10,0),
	BRTX_DESC VARCHAR(100),
	BRTX_PERCENT NUMBER(18,0),
	BRTX_FIXEDAMT NUMBER(18,2),
	BRTX_EFFECTIVESTART TIMESTAMP_NTZ(9),
	BRTX_EFFECTIVEEND TIMESTAMP_NTZ(9),
	BRTX_CREATEDDATE TIMESTAMP_NTZ(9),
	BRTX_CREATEDUSER VARCHAR(50),
	BRTX_MODIFIEDDATE TIMESTAMP_NTZ(9),
	BRTX_MODIFIEDUSER VARCHAR(50),
	BRTX_TS VARCHAR(100),
	BRTX_HCPCS VARCHAR(25),
	BRTX_ACCTID NUMBER(10,0),
	BRTX_ACCTCODE VARCHAR(50),
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