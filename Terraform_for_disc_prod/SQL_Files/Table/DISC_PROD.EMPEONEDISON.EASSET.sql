CREATE OR REPLACE TABLE DISC_PROD.EMPEONEDISON.EASSET (
	CO VARCHAR(10) NOT NULL,
	ID VARCHAR(10),
	NAME VARCHAR(256),
	RETURNDATE DATE,
	NOTES VARCHAR(4000),
	ASSETID VARCHAR(36),
	LASTCHANGE TIMESTAMP_NTZ(9),
	LASTCHANGEUSER VARCHAR(50),
	ASSETIDENTIFIER VARCHAR(50),
	DATEISSUED DATE,
	EXPIRATIONDATE DATE,
	RETURNED BOOLEAN,
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