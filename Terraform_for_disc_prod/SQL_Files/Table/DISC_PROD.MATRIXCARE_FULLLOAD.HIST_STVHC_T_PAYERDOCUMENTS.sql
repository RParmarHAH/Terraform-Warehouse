CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_PAYERDOCUMENTS (
	PAYDOC_ID NUMBER(19,0) NOT NULL,
	PAYDOC_PAYERID NUMBER(19,0),
	PAYDOC_TYPEID NUMBER(10,0),
	PAYDOC_FORMAT VARCHAR(50),
	PAYDOC_FILENAME VARCHAR(256),
	PAYDOC_FILESIZE NUMBER(19,0),
	PAYDOC_NOTES VARCHAR(4000),
	PAYDOC_SHARELEVEL NUMBER(10,0),
	PAYDOC_CREATEDDATE TIMESTAMP_NTZ(9),
	PAYDOC_CREATEDUSER VARCHAR(50),
	PAYDOC_MODIFIEDDATE TIMESTAMP_NTZ(9),
	PAYDOC_MODIFIEDUSER VARCHAR(50),
	PAYDOC_TS VARCHAR(100),
	PAYDOC_ISCOMPRESSED BOOLEAN,
	PAYDOC_SUBTYPEID NUMBER(10,0),
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