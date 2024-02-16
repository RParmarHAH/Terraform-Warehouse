CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.CAREBRIDGELOG (
	LOGID NUMBER(10,0) NOT NULL,
	LOGDATE TIMESTAMP_NTZ(9),
	STATUS VARCHAR(1),
	SCHEDULEID NUMBER(10,0),
	PAYORID NUMBER(10,0),
	TYPE VARCHAR(1),
	ERRORS VARCHAR(16777216),
	DETAILS VARCHAR(16777216),
	LOGFILENAME VARCHAR(60),
	EXPORTEDBY VARCHAR(100),
	EXPORTEDON TIMESTAMP_NTZ(9),
	REQUESTDATA VARCHAR(16777216),
	APPOINTMENTSTATUS VARCHAR(200),
	HASERRORS BOOLEAN,
	BILLEDUNITS NUMBER(8,2),
	BILLEDAMOUNT NUMBER(8,2),
	CLAIM1STATUS VARCHAR(200),
	CLAIM1INVOICENUMBER VARCHAR(100),
	CLAIM1PAYERCLAIMNUMBER VARCHAR(100),
	CLAIM1STATUSDATE TIMESTAMP_NTZ(9),
	CLAIM1DATELASTCHECKED TIMESTAMP_NTZ(9),
	CLAIM1PAYERSTATUSCODE VARCHAR(50),
	CLAIM1PAYERSTATUSDESCRIPTION VARCHAR(200),
	CLAIM2STATUS VARCHAR(200),
	CLAIM2INVOICENUMBER VARCHAR(100),
	CLAIM2PAYERCLAIMNUMBER VARCHAR(100),
	CLAIM2STATUSDATE TIMESTAMP_NTZ(9),
	CLAIM2DATELASTCHECKED TIMESTAMP_NTZ(9),
	CLAIM2PAYERSTATUSCODE VARCHAR(50),
	CLAIM2PAYERSTATUSDESCRIPTION VARCHAR(200),
	TRANSACTIONID VARCHAR(40),
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