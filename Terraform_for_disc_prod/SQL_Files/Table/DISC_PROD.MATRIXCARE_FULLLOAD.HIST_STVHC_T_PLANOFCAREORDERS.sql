CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_PLANOFCAREORDERS (
	POCORD_ID NUMBER(19,0) NOT NULL,
	POCORD_ORDERDATE TIMESTAMP_NTZ(9),
	POCORD_POCID NUMBER(19,0),
	POCORD_SERVICECODEID NUMBER(10,0),
	POCORD_ORDER VARCHAR(16777216),
	POCORD_OCCURENCEPERPATTERNFREQUENCYMIN NUMBER(3,0),
	POCORD_OCCURENCEPERPATTERNFREQUENCYMAX NUMBER(3,0),
	POCORD_PATTERNFREQUENCY NUMBER(3,0),
	POCORD_PATTERNINTERVAL NUMBER(3,0),
	POCORD_RANGEMAXFREQUENCY NUMBER(10,0),
	POCORD_CREATEDDATE TIMESTAMP_NTZ(9),
	POCORD_CREATEDUSER VARCHAR(50),
	POCORD_MODIFIEDDATE TIMESTAMP_NTZ(9),
	POCORD_MODIFIEDUSER VARCHAR(50),
	POCORD_TS VARCHAR(100),
	POCORD_SEQUENCE NUMBER(10,0),
	POCORD_FREQUENCIES VARIANT,
	POCORD_ASSESSMENTID NUMBER(19,0),
	POCORD_ORDERTIME TIMESTAMP_NTZ(9),
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