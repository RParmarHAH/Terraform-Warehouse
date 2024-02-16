CREATE OR REPLACE TABLE DISC_PROD.EMPEONEDISON.ELABORDIST (
	TRANS VARCHAR(36) NOT NULL,
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
	GL1 VARCHAR(50),
	GL2 VARCHAR(50),
	GL3 VARCHAR(50),
	GL4 VARCHAR(50),
	GL5 VARCHAR(50),
	GL6 VARCHAR(50),
	CD VARCHAR(1),
	XGL1 VARCHAR(50),
	XGL2 VARCHAR(50),
	XGL3 VARCHAR(50),
	XGL4 VARCHAR(50),
	XGL5 VARCHAR(50),
	XGL6 VARCHAR(50),
	GUIDFIELD VARCHAR(36),
	LASTCHANGE TIMESTAMP_NTZ(9),
	CALENDARID VARCHAR(36),
	LASTCHANGEUSER VARCHAR(50),
	CO VARCHAR(10),
	COMMENT VARCHAR(50),
	VOIDREASON VARCHAR(50),
	ACCOUNT VARCHAR(20),
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