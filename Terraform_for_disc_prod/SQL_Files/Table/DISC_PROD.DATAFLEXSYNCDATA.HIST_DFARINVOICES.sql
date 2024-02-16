CREATE OR REPLACE TABLE DISC_PROD.DATAFLEXSYNCDATA.HIST_DFARINVOICES (
	DBNAME VARCHAR(12) NOT NULL,
	REFERENCENO NUMBER(10,0) NOT NULL,
	INVOICENUMBER VARCHAR(25),
	CONTRACTCODE VARCHAR(10),
	PERIOD VARCHAR(10),
	SUPPLEMENTNO NUMBER(10,0),
	OFFICE NUMBER(10,0),
	BATCH NUMBER(10,0),
	SERVICEAREA VARCHAR(10),
	CONTRACTTEXT VARCHAR(50),
	DATECREATED TIMESTAMP_NTZ(9),
	HOURSBILLED NUMBER(18,5),
	AMOUNTBILLED NUMBER(18,5),
	LASTPAYDATE TIMESTAMP_NTZ(9),
	GROSSPAID NUMBER(18,5),
	OUTSTANDING NUMBER(18,5),
	CLIENTBILLED NUMBER(10,0),
	CCUCONTRACT VARCHAR(12),
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