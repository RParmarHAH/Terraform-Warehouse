CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEPREFERRED.SERVICETYPE_REPL (
	AGENCYID NUMBER(10,0),
	SERVICETYPEID NUMBER(10,0),
	SERVICETYPE VARCHAR(50),
	SERVICECATEGORYID NUMBER(10,0),
	DESCRIPTION VARCHAR(500),
	ACTIVE BOOLEAN,
	PAYERID NUMBER(10,0),
	DISCIPLINETYPE NUMBER(3,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	CREATEDBY NUMBER(10,0),
	UPDATEDBY NUMBER(10,0),
	CREATEDUTCDATE TIMESTAMP_NTZ(9),
	UPDATEDUTCDATE TIMESTAMP_NTZ(9),
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