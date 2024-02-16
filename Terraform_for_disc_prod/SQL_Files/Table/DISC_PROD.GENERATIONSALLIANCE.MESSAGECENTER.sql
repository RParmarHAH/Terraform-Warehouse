CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.MESSAGECENTER (
	MESSAGECENTERID NUMBER(10,0) NOT NULL,
	SUBJECT VARCHAR(200),
	ASSIGNEDTO VARCHAR(100),
	STATUS NUMBER(3,0),
	CREATED TIMESTAMP_NTZ(9),
	CREATEDBY VARCHAR(100),
	LASTUPDATED TIMESTAMP_NTZ(9),
	UPDATEDBY VARCHAR(100),
	ISVISIBLETOALL BOOLEAN,
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