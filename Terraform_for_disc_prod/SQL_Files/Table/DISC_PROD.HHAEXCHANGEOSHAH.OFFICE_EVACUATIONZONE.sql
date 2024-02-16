CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.OFFICE_EVACUATIONZONE (
	AGENCYID NUMBER(10,0),
	EVACUATIONZONEID NUMBER(10,0) NOT NULL,
	EVACUATIONZONE VARCHAR(50),
	DESCRIPTION VARCHAR(200),
	STATUS VARCHAR(50),
	OFFICEID NUMBER(10,0),
	PROVIDEREVACUATIONZONEID NUMBER(10,0),
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