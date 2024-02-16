CREATE OR REPLACE TABLE DISC_PROD.EMPEONEDISON.ECLOCKDEVICETEMPLATE (
	CLOCKDEVICETEMPLATEID VARCHAR(36) NOT NULL,
	CO VARCHAR(10),
	ID VARCHAR(10),
	TEMPLATETYPE VARCHAR(20),
	SIZE NUMBER(10,0),
	TEMPLATE VARCHAR(16777216),
	LASTCHANGE TIMESTAMP_NTZ(9),
	LASTCHANGEUSER VARCHAR(50),
	TEMPLATEID NUMBER(10,0),
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