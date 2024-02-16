CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEEDISON.BANKCODES_REPL (
	AGENCYID NUMBER(10,0),
	BANKCODEID NUMBER(10,0),
	BANKCODE VARCHAR(100),
	DESCRIPTION VARCHAR(500),
	STATUS VARCHAR(10),
	CREATEDBY NUMBER(10,0),
	CREATEDBYUSER VARCHAR(200),
	CREATEDDATE TIMESTAMP_NTZ(9),
	CREATEDUTCDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBYUSER VARCHAR(200),
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