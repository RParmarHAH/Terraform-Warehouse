CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_OTEXEMPTTYPES (
	OTEXTYP_ID NUMBER(10,0),
	OTEXTYP_NAME VARCHAR(50),
	OTEXTYP_OTEXEMPTHRS NUMBER(8,2),
	OTEXTYP_LISTITEMTYPE NUMBER(3,0),
	OTEXTYP_BRANCHID NUMBER(10,0),
	OTEXTYP_RPTGROUPID NUMBER(10,0),
	OTEXTYP_OVERRIDEID NUMBER(10,0),
	OTEXTYP_ACTIVE BOOLEAN,
	OTEXTYP_CREATEDDATE TIMESTAMP_NTZ(9),
	OTEXTYP_CREATEDUSER VARCHAR(50),
	OTEXTYP_MODIFIEDDATE TIMESTAMP_NTZ(9),
	OTEXTYP_MODIFIEDUSER VARCHAR(50),
	OTEXTYP_TS VARCHAR(100),
	OTEXTYP_DESCRIPTION VARCHAR(1000),
	OTEXTYP_BILL BOOLEAN,
	OTEXTYP_PAY BOOLEAN,
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