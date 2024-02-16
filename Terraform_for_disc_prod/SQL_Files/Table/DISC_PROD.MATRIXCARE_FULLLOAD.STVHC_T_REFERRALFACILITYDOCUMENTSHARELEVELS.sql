CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_REFERRALFACILITYDOCUMENTSHARELEVELS (
	REFFACDOCSLVL_ID NUMBER(10,0),
	REFFACDOCSLVL_NAME VARCHAR(50),
	REFFACDOCSLVL_PERMISSIONNAME VARCHAR(50),
	REFFACDOCSLVL_ACTIVE BOOLEAN,
	REFFACDOCSLVL_CREATEDDATE TIMESTAMP_NTZ(9),
	REFFACDOCSLVL_CREATEDUSER VARCHAR(50),
	REFFACDOCSLVL_MODIFIEDDATE TIMESTAMP_NTZ(9),
	REFFACDOCSLVL_MODIFIEDUSER VARCHAR(50),
	REFFACDOCSLVL_TS VARCHAR(100),
	REFFACDOCSLVL_LISTITEMTYPE NUMBER(3,0),
	REFFACDOCSLVL_RPTGROUPID NUMBER(10,0),
	REFFACDOCSLVL_BRANCHID NUMBER(10,0),
	REFFACDOCSLVL_OVERRIDEID NUMBER(10,0),
	REFFACDOCSLVL_DESCRIPTION VARCHAR(1000),
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