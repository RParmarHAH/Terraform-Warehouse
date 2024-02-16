CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.CLIENTWOUND (
	CLIENTWOUNDID NUMBER(10,0) NOT NULL,
	SCHEDULEID NUMBER(10,0),
	LENGTH NUMBER(5,2),
	WIDTH NUMBER(5,2),
	DEPTH NUMBER(5,2),
	DRAINAGE VARCHAR(500),
	COMMENT VARCHAR(16777216),
	PICTURE VARCHAR(100),
	REASON VARCHAR(16777216),
	STAGE VARCHAR(1),
	CREATED TIMESTAMP_NTZ(9),
	CREATEDBY VARCHAR(100),
	UPDATED TIMESTAMP_NTZ(9),
	UPDATEDBY VARCHAR(100),
	APPROVEDSTATUS VARCHAR(1),
	CLIENTWOUNDMASTERID NUMBER(10,0),
	ODOR BOOLEAN,
	WOUNDNOTESSTAGEID NUMBER(10,0),
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