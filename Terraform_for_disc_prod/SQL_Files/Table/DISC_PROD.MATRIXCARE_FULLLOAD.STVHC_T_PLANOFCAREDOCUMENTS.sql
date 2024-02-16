CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_PLANOFCAREDOCUMENTS (
	POCDOC_ID NUMBER(19,0),
	POCDOC_PLANOFCAREID NUMBER(19,0),
	POCDOC_TYPEID NUMBER(10,0),
	POCDOC_FORMAT VARCHAR(50),
	POCDOC_FILENAME VARCHAR(256),
	POCDOC_FILESIZE NUMBER(19,0),
	POCDOC_NOTES VARCHAR(4000),
	POCDOC_SHARELEVEL NUMBER(10,0),
	POCDOC_CREATEDDATE TIMESTAMP_NTZ(9),
	POCDOC_CREATEDUSER VARCHAR(50),
	POCDOC_MODIFIEDDATE TIMESTAMP_NTZ(9),
	POCDOC_MODIFIEDUSER VARCHAR(50),
	POCDOC_TS VARCHAR(100),
	POCDOC_ISCOMPRESSED BOOLEAN,
	POCDOC_SUBTYPEID NUMBER(10,0),
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