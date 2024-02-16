CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_PAYROLLOTTYPES (
	OTTYPE_ID NUMBER(3,0),
	OTTYPE_NAME VARCHAR(50),
	OTTYPE_DETAILRATESOURCE NUMBER(3,0),
	OTTYPE_ADJDETAILRATESOURCE NUMBER(3,0),
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