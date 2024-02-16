CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_REFERRALFACILITIESSTATUS (
	REFFAC_ID NUMBER(10,0) NOT NULL,
	REFFAC_NAME VARCHAR(50),
	REFFAC_SHOWORHIDE BOOLEAN,
	REFFAC_ACTIVE BOOLEAN,
	REFFAC_LISTITEMTYPE NUMBER(3,0),
	REFFAC_RPTGROUPID NUMBER(10,0),
	REFFAC_BRANCHID NUMBER(10,0),
	REFFAC_OVERRIDEID NUMBER(10,0),
	REFFAC_CREATEDDATE TIMESTAMP_NTZ(9),
	REFFAC_CREATEDUSER VARCHAR(50),
	REFFAC_MODIFIEDDATE TIMESTAMP_NTZ(9),
	REFFAC_MODIFIEDUSER VARCHAR(50),
	REFFAC_TS VARCHAR(100),
	REFFAC_DESCRIPTION VARCHAR(1000),
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