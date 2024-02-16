CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.INSERVICEMASTER (
	INSERVICENAME VARCHAR(255) NOT NULL,
	STATUS VARCHAR(1),
	CREATEDBY VARCHAR(15),
	CREATED TIMESTAMP_NTZ(9),
	UPDATEDBY VARCHAR(15),
	LASTUPDATED TIMESTAMP_NTZ(9),
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