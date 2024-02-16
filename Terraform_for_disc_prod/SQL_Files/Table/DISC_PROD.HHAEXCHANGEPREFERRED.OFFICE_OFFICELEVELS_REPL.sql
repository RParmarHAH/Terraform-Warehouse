CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEPREFERRED.OFFICE_OFFICELEVELS_REPL (
	AGENCYID NUMBER(10,0),
	OFFICELEVELID NUMBER(10,0),
	OFFICELEVELNAME VARCHAR(100),
	PARENTOFFICELEVELID NUMBER(10,0),
	OFFICELEVELTYPEID NUMBER(10,0),
	ACTIVE BOOLEAN,
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	CREATEDUTCDATE TIMESTAMP_NTZ(9),
	LASTUPDATEDBY NUMBER(10,0),
	LASTUPDATEDDATE TIMESTAMP_NTZ(9),
	LASTUPDATEDUTCDATE TIMESTAMP_NTZ(9),
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