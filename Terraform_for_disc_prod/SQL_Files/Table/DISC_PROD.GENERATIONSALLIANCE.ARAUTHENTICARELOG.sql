CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.ARAUTHENTICARELOG (
	ARLOGID NUMBER(10,0) NOT NULL,
	LOGDATE TIMESTAMP_NTZ(9),
	STATUS VARCHAR(1),
	ERRORS VARCHAR(16777216),
	INVOICEID VARCHAR(56),
	INVOICEGROUPID VARCHAR(56),
	DETAILS VARCHAR(16777216),
	LOGFILENAME VARCHAR(60),
	SCHEDULEID NUMBER(10,0),
	EXPORTEDBY VARCHAR(100),
	EXPORTEDON TIMESTAMP_NTZ(9),
	BATCHID VARCHAR(36),
	APIREQUEST VARCHAR(16777216),
	APIRESPONSE VARCHAR(2000),
	STATECODE VARCHAR(2),
	AUTHBATCHID VARCHAR(10),
	SFTPERRORDATA VARCHAR(2000),
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