CREATE OR REPLACE TABLE DISC_PROD.EMPEONEDISON.CTEAM (
	CO VARCHAR(10) NOT NULL,
	CODE VARCHAR(10),
	NAME VARCHAR(200),
	ADDRESS1 VARCHAR(50),
	ADDRESS2 VARCHAR(50),
	CITY VARCHAR(30),
	STATE VARCHAR(10),
	ZIP VARCHAR(10),
	MANAGER VARCHAR(10),
	GUIDFIELD VARCHAR(36),
	LASTCHANGE TIMESTAMP_NTZ(9),
	LASTCHANGEUSER VARCHAR(50),
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