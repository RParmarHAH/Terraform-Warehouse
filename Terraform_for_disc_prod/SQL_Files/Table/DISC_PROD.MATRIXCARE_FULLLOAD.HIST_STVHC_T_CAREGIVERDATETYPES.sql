CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_CAREGIVERDATETYPES (
	CARDTTYP_ID NUMBER(10,0) NOT NULL,
	CARDTTYP_NAME VARCHAR(50),
	CARDTTYP_WARN BOOLEAN,
	CARDTTYP_ACTIVE BOOLEAN,
	CARDTTYP_CREATEDDATE TIMESTAMP_NTZ(9),
	CARDTTYP_CREATEDUSER VARCHAR(50),
	CARDTTYP_MODIFIEDDATE TIMESTAMP_NTZ(9),
	CARDTTYP_MODIFIEDUSER VARCHAR(50),
	CARDTTYP_TS VARCHAR(100),
	CARDTTYP_LISTITEMTYPE NUMBER(3,0),
	CARDTTYP_RPTGROUPID NUMBER(10,0),
	CARDTTYP_BRANCHID NUMBER(10,0),
	CARDTTYP_OVERRIDEID NUMBER(10,0),
	CARDTTYP_DESCRIPTION VARCHAR(1000),
	CARDTTYP_REMINDERITEM BOOLEAN,
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