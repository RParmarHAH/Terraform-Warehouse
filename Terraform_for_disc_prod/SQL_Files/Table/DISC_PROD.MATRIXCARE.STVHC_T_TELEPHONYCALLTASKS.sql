CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_TELEPHONYCALLTASKS (
	TCT_TELEPHONYCALLTASKID NUMBER(19,0),
	TCT_TELEPHONYCALLID NUMBER(19,0),
	TCT_TELEPHONYTASKID NUMBER(10,0),
	TCT_DURATION NUMBER(8,4),
	TCT_SERVERCALLID NUMBER(19,0),
	TCT_CREATEDDATE TIMESTAMP_NTZ(9),
	INSERTDATE TIMESTAMP_NTZ(9),
	UPDATEDATE TIMESTAMP_NTZ(9),
	DELETEDFLAG BOOLEAN,
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);