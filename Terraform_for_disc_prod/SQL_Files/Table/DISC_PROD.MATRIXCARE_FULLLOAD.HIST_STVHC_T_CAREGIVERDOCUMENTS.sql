CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_CAREGIVERDOCUMENTS (
	CARDOC_ID NUMBER(19,0) NOT NULL,
	CARDOC_CAREGIVERID NUMBER(19,0),
	CARDOC_TYPEID NUMBER(10,0),
	CARDOC_FORMAT VARCHAR(50),
	CARDOC_FILENAME VARCHAR(256),
	CARDOC_FILESIZE NUMBER(19,0),
	CARDOC_NOTES VARCHAR(4000),
	CARDOC_SHARELEVEL NUMBER(10,0),
	CARDOC_CREATEDDATE TIMESTAMP_NTZ(9),
	CARDOC_CREATEDUSER VARCHAR(50),
	CARDOC_MODIFIEDDATE TIMESTAMP_NTZ(9),
	CARDOC_MODIFIEDUSER VARCHAR(50),
	CARDOC_TS VARCHAR(100),
	CARDOC_ISCOMPRESSED BOOLEAN,
	CARDOC_SUBTYPEID NUMBER(10,0),
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