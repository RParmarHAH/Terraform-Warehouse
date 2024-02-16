CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_BILLCODES (
	BCD_ID NUMBER(10,0) NOT NULL,
	BCD_BILLCODE VARCHAR(25),
	BCD_NAME VARCHAR(50),
	BCD_ACTIVE BOOLEAN,
	BCD_CREATEDDATE TIMESTAMP_NTZ(9),
	BCD_CREATEDUSER VARCHAR(50),
	BCD_MODIFIEDDATE TIMESTAMP_NTZ(9),
	BCD_MODIFIEDUSER VARCHAR(50),
	BCD_TS VARCHAR(100),
	BCD_LISTITEMTYPE NUMBER(3,0),
	BCD_RPTGROUPID NUMBER(10,0),
	BCD_BRANCHID NUMBER(10,0),
	BCD_OVERRIDEID NUMBER(10,0),
	BCD_DESCRIPTION VARCHAR(1000),
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