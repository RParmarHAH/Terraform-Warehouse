CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CLINICALORDER485 (
	AGENCYID NUMBER(10,0) NOT NULL,
	ORDER485ID NUMBER(10,0) NOT NULL,
	ORDERGOAL485ID NUMBER(10,0),
	MASTER485ID NUMBER(10,0),
	PATIENTID NUMBER(10,0),
	DISCIPLINEID NUMBER(10,0),
	CATEGORYID NUMBER(10,0),
	CATEGORYORDERID NUMBER(10,0),
	ORDER_DETAIL VARCHAR(1000),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
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