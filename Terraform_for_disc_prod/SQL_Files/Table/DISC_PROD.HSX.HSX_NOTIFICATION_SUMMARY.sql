CREATE OR REPLACE TABLE DISC_PROD.HSX.HSX_NOTIFICATION_SUMMARY (
	DEST_FACILITY VARCHAR(256),
	DEST_PRACTICE VARCHAR(32),
	PCP VARCHAR(32),
	DEST_MRN VARCHAR(32),
	SRC_FACILITY VARCHAR(256),
	SRC_MRN VARCHAR(32),
	FIRST_NAME VARCHAR(32) NOT NULL,
	MIDDLE_NAME VARCHAR(32),
	LAST_NAME VARCHAR(32) NOT NULL,
	GENDER VARCHAR(32),
	BIRTH_DT DATE NOT NULL,
	ADDRESS VARCHAR(256),
	CITY VARCHAR(32),
	STATE VARCHAR(32),
	ZIP VARCHAR(32),
	PRIMARY_PHONE VARCHAR(32),
	SRC_SETTING VARCHAR(128),
	EVENT_TYPE VARCHAR(256),
	ADMIT_DT VARCHAR(32),
	ADMIT_TIME VARCHAR(32),
	ADMIT_RSN VARCHAR(1000),
	ADMIT_TYPE VARCHAR(32),
	REFERRAL_INFO VARCHAR(256),
	DISCHARGE_DT VARCHAR(32),
	DISCHARGE_TIME VARCHAR(32),
	DEATH_IND VARCHAR(1),
	DIAG_CD VARCHAR(1024),
	DIAG_DESC VARCHAR(1024),
	DISCHARGE_DISP VARCHAR(256),
	ATTENDING_DR VARCHAR(32),
	INSURANCE VARCHAR(32),
	SRC_FILENAME VARCHAR(256) NOT NULL,
	ETL_TASK_KEY NUMBER(10,0),
	ETL_INSERTED_TASK_KEY NUMBER(10,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG NUMBER(1,0)
);