CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.CAREGIVERNOTES (
	SOCIALSECNUM VARCHAR(9) NOT NULL,
	NOTEDATE TIMESTAMP_NTZ(9) NOT NULL,
	NOTETIME TIMESTAMP_NTZ(9) NOT NULL,
	DESCRIPTION VARCHAR(7200),
	CREATEDBY VARCHAR(100),
	CREATED TIMESTAMP_NTZ(9),
	UPDATEDBY VARCHAR(100),
	LASTUPDATED TIMESTAMP_NTZ(9),
	NOTETYPEID NUMBER(10,0),
	NOTEPRIORITY BOOLEAN,
	CALLID NUMBER(10,0),
	PRIMARYCALLERNOTEID NUMBER(10,0),
	PRIMARYCALLERTYPE VARCHAR(1),
	CAREGIVERNOTEID NUMBER(10,0),
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