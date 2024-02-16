CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_REPORTGROUPTYPES (
	RPTGRPTYP_ID NUMBER(10,0) NOT NULL,
	RPTGRPTYP_NAME VARCHAR(50),
	RPTGRPTYP_DESCRIPTION VARCHAR(256),
	RPTGRPTYP_TYPE NUMBER(3,0),
	RPTGRPTYP_ENUMNAME VARCHAR(50),
	RPTGRPTYP_ACTIVE BOOLEAN,
	RPTGRPTYP_CREATEDDATE TIMESTAMP_NTZ(9),
	RPTGRPTYP_CREATEDUSER VARCHAR(50),
	RPTGRPTYP_MODIFIEDDATE TIMESTAMP_NTZ(9),
	RPTGRPTYP_MODIFIEDUSER VARCHAR(50),
	RPTGRP_TS VARCHAR(100),
	RPTGRPTYP_DDMAINTENANCE BOOLEAN,
	RPTGRPTYP_TABLENAME VARCHAR(50),
	RPTGRPTYP_TABLEABBREVIATION VARCHAR(20),
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