CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_PAYROLLADJUSTMENTCODE (
	PROLLAC_ID NUMBER(10,0),
	PROLLAC_ACTIVE BOOLEAN,
	PROLLAC_CREATEDDATE TIMESTAMP_NTZ(9),
	PROLLAC_CREATEDUSER VARCHAR(50),
	PROLLAC_MODIFIEDDATE TIMESTAMP_NTZ(9),
	PROLLAC_MODIFIEDUSER VARCHAR(50),
	PROLLAC_TS VARCHAR(100),
	PROLLAC_NAME VARCHAR(50),
	PROLLAC_LISTITEMTYPE NUMBER(3,0),
	PROLLAC_RPTGROUPID NUMBER(10,0),
	PROLLAC_BRANCHID NUMBER(10,0),
	PROLLAC_DESCRIPTION VARCHAR(1000),
	PROLLAC_OVERRIDEID NUMBER(10,0),
	PROLLAC_PAYROLLCODE VARCHAR(50),
	PROLLAC_DEDUCTEARN VARCHAR(5),
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