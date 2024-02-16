CREATE OR REPLACE TABLE DISC_PROD.DATAFLEXSYNCDATA.HIST_DFARPAYMENTS (
	DBNAME VARCHAR(10) NOT NULL,
	REFERENCENO NUMBER(10,0) NOT NULL,
	CONTRACTCODE VARCHAR(10),
	PERIOD VARCHAR(10),
	SUPPLEMENTNO NUMBER(10,0),
	OFFICENO NUMBER(10,0),
	BILLEDAMOUNT NUMBER(18,5),
	HOURSBILLED NUMBER(18,5),
	PAYMENTAMOUNT NUMBER(18,5),
	PAYMENTDATETIME TIMESTAMP_NTZ(9),
	ADDEDDATE DATE,
	CHANGEDDATE DATE,
	REPORTED BOOLEAN,
	CODE VARCHAR(20),
	AUDITNO NUMBER(10,0),
	CHECKNUMBER VARCHAR(20),
	PAYMENTDESCRIPTION VARCHAR(50),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEBATCH VARCHAR(36),
	UPDATEDTIME TIMESTAMP_NTZ(9),
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