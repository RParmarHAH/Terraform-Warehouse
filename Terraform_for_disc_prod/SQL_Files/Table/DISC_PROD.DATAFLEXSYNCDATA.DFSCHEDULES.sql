CREATE OR REPLACE TABLE DISC_PROD.DATAFLEXSYNCDATA.DFSCHEDULES (
	DBNAME VARCHAR(12),
	REFERENCENO NUMBER(10,0),
	CLIENTNUMBER NUMBER(10,0),
	CONTRACTCODE VARCHAR(10),
	ITEMVALUES VARCHAR(16777216),
	LASTUPDATEDATE TIMESTAMP_NTZ(9),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEBATCH VARCHAR(36),
	UPDATEDTIME TIMESTAMP_NTZ(9),
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