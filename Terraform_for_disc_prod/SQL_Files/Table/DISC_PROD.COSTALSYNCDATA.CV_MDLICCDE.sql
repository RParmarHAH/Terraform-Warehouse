CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.CV_MDLICCDE (
	DB VARCHAR(25),
	RECSTAT VARCHAR(1),
	ENTRY_USER VARCHAR(3),
	ENTRY_DATE TIMESTAMP_NTZ(9),
	UPDATE_USER VARCHAR(3),
	UPDATE_DATE TIMESTAMP_NTZ(9),
	LICENSE_CODE VARCHAR(11),
	LICENSE_CODE_DESC VARCHAR(31),
	TERM NUMBER(5,0),
	DDL_TERM_TYPE NUMBER(5,0),
	REMARK_40 VARCHAR(41),
	CB_LICENSE_REQ_BY_SERV_C NUMBER(3,0),
	NOTIFY NUMBER(3,0),
	LICENSE_REQUIRED NUMBER(3,0),
	NUMBER_OF_DAYS NUMBER(5,0),
	CB_LICENSE_REQ_BY_PROC NUMBER(3,0),
	LICENSE_TYPE_CODE VARCHAR(7),
	DDL_LICENSE_TYPE NUMBER(5,0),
	IN_SERVICE_HRS_REQUIRED VARCHAR(5),
	PRECEPT_HRS_REQUIRED VARCHAR(5),
	CB_LICENSE_MULTI_STATE NUMBER(3,0),
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