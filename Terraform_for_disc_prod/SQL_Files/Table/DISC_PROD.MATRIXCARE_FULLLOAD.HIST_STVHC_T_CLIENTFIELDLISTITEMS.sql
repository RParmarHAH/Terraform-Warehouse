CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_CLIENTFIELDLISTITEMS (
	CLIDD_ID NUMBER(10,0) NOT NULL,
	CLIDD_FIELDID NUMBER(10,0),
	CLIDD_SORTID NUMBER(5,0),
	CLIDD_VALUE NUMBER(5,0),
	CLIDD_TEXT VARCHAR(24),
	CLIDD_ACTIVE BOOLEAN,
	CLIDD_CREATEDUSER VARCHAR(50),
	CLIDD_CREATEDDATE TIMESTAMP_NTZ(9),
	CLIDD_MODIFIEDUSER VARCHAR(50),
	CLIDD_MODIFIEDDATE TIMESTAMP_NTZ(9),
	CLIDD_TS VARCHAR(100),
	INSERTDATE TIMESTAMP_NTZ(9),
	UPDATEDATE TIMESTAMP_NTZ(9),
	DELETEDFLAG BOOLEAN,
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