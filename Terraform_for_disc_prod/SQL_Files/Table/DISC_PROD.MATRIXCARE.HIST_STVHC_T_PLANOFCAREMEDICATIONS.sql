CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_PLANOFCAREMEDICATIONS (
	POCMED_ID NUMBER(19,0) NOT NULL,
	POCMED_POCID NUMBER(19,0),
	POCMED_ORDERDATE TIMESTAMP_NTZ(9),
	POCMED_DISCONTINUEDATE TIMESTAMP_NTZ(9),
	POCMED_NEWCHANGE VARCHAR(1),
	POCMED_MEDID NUMBER(10,0),
	POCMED_DOSE VARCHAR(16777216),
	POCMED_AMOUNT VARCHAR(16777216),
	POCMED_FREQUENCYID NUMBER(10,0),
	POCMED_ROUTEID NUMBER(10,0),
	POCMED_HOURS_1 TIMESTAMP_NTZ(9),
	POCMED_HOURS_2 TIMESTAMP_NTZ(9),
	POCMED_HOURS_3 TIMESTAMP_NTZ(9),
	POCMED_HOURS_4 TIMESTAMP_NTZ(9),
	POCMED_HOURS_5 TIMESTAMP_NTZ(9),
	POCMED_HOURS_6 TIMESTAMP_NTZ(9),
	POCMED_PHYSICIANID NUMBER(19,0),
	POCMED_NOTES VARCHAR(1024),
	POCMED_CREATEDDATE TIMESTAMP_NTZ(9),
	POCMED_CREATEDUSER VARCHAR(50),
	POCMED_MODIFIEDDATE TIMESTAMP_NTZ(9),
	POCMED_MODIFIEDUSER VARCHAR(50),
	POCMED_TS VARCHAR(100),
	POCMED_OASISMEDNAME VARCHAR(256),
	POCMED_SEQUENCE NUMBER(10,0),
	POCMED_ASSESSMENTID NUMBER(19,0),
	POCMED_GUID VARCHAR(36),
	POCMED_TYPE NUMBER(10,0),
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