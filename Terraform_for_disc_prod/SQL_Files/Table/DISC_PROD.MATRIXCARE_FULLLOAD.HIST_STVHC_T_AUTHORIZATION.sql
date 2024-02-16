CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_AUTHORIZATION (
	AUTH_ID NUMBER(19,0) NOT NULL,
	AUTH_ADMISSIONID NUMBER(19,0),
	AUTH_PAYERID NUMBER(19,0),
	AUTH_SERVICECODEID NUMBER(10,0),
	AUTH_UNITFLAG NUMBER(5,0),
	AUTH_BEGINDATE TIMESTAMP_NTZ(9),
	AUTH_ENDDATE TIMESTAMP_NTZ(9),
	AUTH_CODE VARCHAR(50),
	AUTH_ACTIVEFLAG BOOLEAN,
	AUTH_NOTES VARCHAR(16777216),
	AUTH_CREATEDDATE TIMESTAMP_NTZ(9),
	AUTH_CREATEDUSER VARCHAR(50),
	AUTH_MODIFIEDDATE TIMESTAMP_NTZ(9),
	AUTH_MODIFIEDUSER VARCHAR(50),
	AUTH_TS VARCHAR(100),
	AUTH_POCID NUMBER(19,0),
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