CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_PAYERTYPE (
	PAYTYP_ID NUMBER(10,0) NOT NULL,
	PAYTYP_NAME VARCHAR(50),
	PAYTYP_ACTIVE BOOLEAN,
	PAYTYP_CREATEDDATE TIMESTAMP_NTZ(9),
	PAYTYP_CREATEDUSER VARCHAR(50),
	PAYTYP_MODIFIEDDATE TIMESTAMP_NTZ(9),
	PAYTYP_MODIFIEDUSER VARCHAR(50),
	PAYTYP_TS VARCHAR(255),
	PAYTYP_LISTITEMTYPE NUMBER(3,0),
	PAYTYP_RPTGROUPID NUMBER(10,0),
	PAYTYP_BRANCHID NUMBER(10,0),
	PAYTYP_OVERRIDEID NUMBER(10,0),
	PAYTYP_DESCRIPTION VARCHAR(1000),
	PAYTYP_ACCTID NUMBER(10,0),
	PAYTYP_DEFACCTID NUMBER(10,0),
	PAYTYP_ACCTCODE VARCHAR(50),
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