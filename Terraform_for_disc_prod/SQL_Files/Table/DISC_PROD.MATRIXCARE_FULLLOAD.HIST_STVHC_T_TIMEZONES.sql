CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_TIMEZONES (
	TZ_ID NUMBER(5,0) NOT NULL,
	TZ_NAME VARCHAR(50),
	TZ_SUPPORTSDS BOOLEAN,
	TZ_BASEOFFSET NUMBER(5,0),
	TZ_ADJUSTMENTRULES VARCHAR(16777216),
	TZ_DISPLAYNAME VARCHAR(100),
	TZ_STANDARDNAME VARCHAR(100),
	TZ_DATA VARCHAR(16777216),
	TZ_CREATEDDATE TIMESTAMP_NTZ(9),
	TZ_CREATEDUSER VARCHAR(50),
	TZ_MODIFIEDDATE TIMESTAMP_NTZ(9),
	TZ_MODIFIEDUSER VARCHAR(50),
	TZ_TS VARCHAR(100),
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