CREATE OR REPLACE TABLE DISC_PROD.SANDATAIMPORT.SANDATA_PAYORS (
	ID NUMBER(10,0),
	AGENCYID VARCHAR(25),
	PAYORID NUMBER(10,0),
	NAME VARCHAR(50),
	ADDRESS VARCHAR(50),
	ADDRESS2 VARCHAR(50),
	CITY VARCHAR(50),
	STATE VARCHAR(2),
	ZIP VARCHAR(10),
	BILLMETHOD NUMBER(10,0),
	TRANSPORT NUMBER(10,0),
	BILLCODE VARCHAR(10),
	ISAUTHREQUIRED BOOLEAN,
	WEEKENDING VARCHAR(2),
	USESEVV BOOLEAN,
	SANTRAXACCT VARCHAR(50),
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