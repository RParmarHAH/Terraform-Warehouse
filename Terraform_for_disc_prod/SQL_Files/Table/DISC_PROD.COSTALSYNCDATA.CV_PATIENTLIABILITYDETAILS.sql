CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.CV_PATIENTLIABILITYDETAILS (
	DB VARCHAR(25),
	RECSTAT VARCHAR(1),
	ENTRY_USER VARCHAR(3),
	ENTRY_DATE TIMESTAMP_NTZ(9),
	UPDATE_USER VARCHAR(3),
	UPDATE_DATE TIMESTAMP_NTZ(9),
	PATIENT_NUMBER VARCHAR(9),
	PLAN_CODE VARCHAR(7),
	STATRT_DATE TIMESTAMP_NTZ(9),
	SEQUENCE_NUMBER NUMBER(19,5),
	PROCCODE VARCHAR(9),
	CO_PAYMENT NUMBER(19,5),
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