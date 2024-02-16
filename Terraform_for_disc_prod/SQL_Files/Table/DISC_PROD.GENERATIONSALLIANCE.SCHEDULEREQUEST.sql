CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.SCHEDULEREQUEST (
	REQUESTID NUMBER(10,0) NOT NULL,
	SCHEDULEID NUMBER(10,0),
	CAREGIVERSSN VARCHAR(9),
	CREATED TIMESTAMP_NTZ(9),
	ISSCHEDULED BOOLEAN,
	USERALERTSTAUS BOOLEAN,
	UPDATEDBY VARCHAR(100),
	LASTUPDATED TIMESTAMP_NTZ(9),
	ISREQUESTOPENED BOOLEAN,
	ISREQUESTCANCELED BOOLEAN,
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