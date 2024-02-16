CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_ADMISSIONDOCUMENTS (
	ADMDOC_ID NUMBER(19,0),
	ADMDOC_ADMISSIONID NUMBER(19,0),
	ADMDOC_TYPEID NUMBER(10,0),
	ADMDOC_FORMAT VARCHAR(50),
	ADMDOC_FILENAME VARCHAR(256),
	ADMDOC_FILESIZE NUMBER(19,0),
	ADMDOC_NOTES VARCHAR(4000),
	ADMDOC_SHARELEVEL NUMBER(10,0),
	ADMDOC_CREATEDDATE TIMESTAMP_NTZ(9),
	ADMDOC_CREATEDUSER VARCHAR(50),
	ADMDOC_MODIFIEDDATE TIMESTAMP_NTZ(9),
	ADMDOC_MODIFIEDUSER VARCHAR(50),
	ADMDOC_TS VARCHAR(100),
	ADMDOC_ISCOMPRESSED BOOLEAN,
	ADMDOC_SUBTYPEID NUMBER(10,0),
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