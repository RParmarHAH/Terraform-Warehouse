CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.OFFICECATEGORYORDERS (
	AGENCYID NUMBER(10,0) NOT NULL,
	CATEGORYORDERID NUMBER(10,0) NOT NULL,
	OFFICEID NUMBER(10,0),
	DISCIPLINECATEGORYID NUMBER(10,0),
	CATEGORYORDER VARCHAR(1000),
	SORTORDER NUMBER(10,0),
	ACTIVE BOOLEAN,
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	CREATEDUTCDATE TIMESTAMP_NTZ(9),
	LASTUPDATEDBY NUMBER(10,0),
	LASTUPDATEDDATE TIMESTAMP_NTZ(9),
	LASTUPDATEDUTCDATE TIMESTAMP_NTZ(9),
	OLDIDENTITYID NUMBER(10,0),
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