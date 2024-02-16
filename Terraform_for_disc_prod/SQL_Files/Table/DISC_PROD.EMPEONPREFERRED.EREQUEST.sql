CREATE OR REPLACE TABLE DISC_PROD.EMPEONPREFERRED.EREQUEST (
	REQUESTID VARCHAR(36) NOT NULL,
	CO VARCHAR(10),
	ID VARCHAR(10),
	TYPE VARCHAR(50),
	SUBTYPE VARCHAR(50),
	NAME VARCHAR(50),
	DESCRIPTION VARCHAR(16777216),
	REQUESTERCOMMENT VARCHAR(16777216),
	REVIEWERCOMMENT VARCHAR(16777216),
	REFERENCEID VARCHAR(100),
	DETAILS VARCHAR(16777216),
	PREVDETAILS VARCHAR(16777216),
	STATE VARCHAR(50),
	REQUESTEDON TIMESTAMP_NTZ(9),
	REVIEWED BOOLEAN,
	REVIEWEDON TIMESTAMP_NTZ(9),
	REVIEWEDBY VARCHAR(400),
	LASTCHANGE TIMESTAMP_NTZ(9),
	LASTCHANGEUSER VARCHAR(50),
	REFERENCEDATE TIMESTAMP_NTZ(9),
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