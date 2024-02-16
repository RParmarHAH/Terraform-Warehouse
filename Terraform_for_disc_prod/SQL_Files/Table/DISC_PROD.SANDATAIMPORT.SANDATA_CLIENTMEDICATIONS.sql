CREATE OR REPLACE TABLE DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTMEDICATIONS (
	ID NUMBER(10,0),
	AGENCYID VARCHAR(25),
	CLIENTID NUMBER(10,0),
	MEDID NUMBER(10,0),
	NAME VARCHAR(10),
	BEGINDATE DATE,
	ENDDATE DATE,
	STRENGTH VARCHAR(50),
	DOSAGE VARCHAR(50),
	FREQUENCY VARCHAR(50),
	ROUTE VARCHAR(50),
	CLASS VARCHAR(50),
	CREATEDAT TIMESTAMP_NTZ(9),
	UPDATEDAT TIMESTAMP_NTZ(9),
	HASHEDROWVALUES VARCHAR(250),
	BATCHID NUMBER(10,0),
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