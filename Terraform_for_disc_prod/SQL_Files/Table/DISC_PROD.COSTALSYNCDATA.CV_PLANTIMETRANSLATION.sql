CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.CV_PLANTIMETRANSLATION (
	DB VARCHAR(128),
	ENTRY_DATE TIMESTAMP_NTZ(9),
	UPDATE_DATE TIMESTAMP_NTZ(9),
	PLAN_CODE VARCHAR(7),
	PROCCODE VARCHAR(9),
	DDL_TIME_TRANS_TYPE NUMBER(5,0),
	CONVERSION_FACTOR NUMBER(19,5),
	TIME_TRANSLATION_CODE VARCHAR(7),
	DEX_ROW_ID NUMBER(10,0),
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