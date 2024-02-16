CREATE OR REPLACE TABLE DISC_PROD.EMPEONEDISON.EPAYHISTDETAIL (
	TRANS VARCHAR(36) NOT NULL,
	SUBTRANS NUMBER(10,0),
	TRANSTYPE VARCHAR(1),
	DET VARCHAR(1),
	DETCODE VARCHAR(10),
	HOURS NUMBER(14,6),
	RATE NUMBER(14,6),
	AMOUNT NUMBER(14,2),
	RATECODE VARCHAR(10),
	TCODE1 VARCHAR(10),
	TCODE2 VARCHAR(10),
	TCODE3 VARCHAR(10),
	TCODE4 VARCHAR(10),
	BEGINDATE TIMESTAMP_NTZ(9),
	ENDDATE TIMESTAMP_NTZ(9),
	SHIFT VARCHAR(10),
	WCC VARCHAR(10),
	CC1 VARCHAR(10),
	CC2 VARCHAR(10),
	CC3 VARCHAR(10),
	CC4 VARCHAR(10),
	CC5 VARCHAR(10),
	JOBCODE VARCHAR(20),
	DIRDEPTRANSIT VARCHAR(9),
	ACCOUNT VARCHAR(20),
	COMMENT VARCHAR(50),
	AGENCYPROCESS NUMBER(10,0),
	GUIDFIELD VARCHAR(36),
	LASTCHANGE TIMESTAMP_NTZ(9),
	LASTCHANGEUSER VARCHAR(50),
	CO VARCHAR(10),
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