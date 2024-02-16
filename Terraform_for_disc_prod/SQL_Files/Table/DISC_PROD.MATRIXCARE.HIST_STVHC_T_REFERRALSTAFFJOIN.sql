CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_REFERRALSTAFFJOIN (
	REFSTAFFJ_ID NUMBER(19,0) NOT NULL,
	REFSTAFFJ_CAREGIVERID NUMBER(19,0),
	REFSTAFFJ_REFERRALENTITIESID NUMBER(3,0),
	REFSTAFFJ_REFERRALRECORDID NUMBER(19,0),
	REFSTAFFJ_STARTDATE TIMESTAMP_NTZ(9),
	REFSTAFFJ_ENDDATE TIMESTAMP_NTZ(9),
	REFSTAFFJ_NOTES VARCHAR(1000),
	REFSTAFFJ_CREATEDDATE TIMESTAMP_NTZ(9),
	REFSTAFFJ_CREATEDUSER VARCHAR(50),
	REFSTAFFJ_MODIFIEDDATE TIMESTAMP_NTZ(9),
	REFSTAFFJ_MODIFIEDUSER VARCHAR(50),
	REFSTAFFJ_TS VARCHAR(100),
	REFSTAFFJ_REFERRALCONTACTRECORDID NUMBER(19,0),
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