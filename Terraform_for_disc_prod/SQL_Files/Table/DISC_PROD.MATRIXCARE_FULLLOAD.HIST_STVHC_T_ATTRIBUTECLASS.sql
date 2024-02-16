CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_ATTRIBUTECLASS (
	ATRCL_ID NUMBER(10,0) NOT NULL,
	ATRCL_NAME VARCHAR(50),
	ATRCL_SEQ NUMBER(10,0),
	ATRCL_ACTIVE BOOLEAN,
	ATRCL_CREATEDDATE TIMESTAMP_NTZ(9),
	ATRCL_CREATEDUSER VARCHAR(50),
	ATRCL_MODIFIEDDATE TIMESTAMP_NTZ(9),
	ATRCL_MODIFIEDUSER VARCHAR(50),
	ATRCL_TS VARCHAR(100),
	ATRCL_LISTITEMTYPE NUMBER(3,0),
	ATRCL_RPTGROUPID NUMBER(10,0),
	ATRCL_BRANCHID NUMBER(10,0),
	ATRCL_OVERRIDEID NUMBER(10,0),
	ATRCL_DESCRIPTION VARCHAR(1000),
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