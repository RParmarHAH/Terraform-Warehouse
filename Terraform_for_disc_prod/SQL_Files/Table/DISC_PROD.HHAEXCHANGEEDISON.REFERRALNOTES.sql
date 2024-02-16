CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEEDISON.REFERRALNOTES (
	AGENCYID NUMBER(10,0),
	REFERRALNOTEID NUMBER(10,0),
	REFERRALID NUMBER(10,0),
	REFERRALNOTETYPE VARCHAR(100),
	NOTE VARCHAR(2000),
	NOTECREATEDDATE TIMESTAMP_NTZ(9),
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