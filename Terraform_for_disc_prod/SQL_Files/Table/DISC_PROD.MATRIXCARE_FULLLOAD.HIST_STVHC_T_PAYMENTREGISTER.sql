CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_PAYMENTREGISTER (
	PMTREG_ID NUMBER(19,0) NOT NULL,
	PMTREG_BRANCHID NUMBER(10,0),
	PMTREG_NUMBER VARCHAR(50),
	PMTREG_AMOUNT NUMBER(18,2),
	PMTREG_NETPAYMENT NUMBER(18,2),
	PMTREG_PAYERID NUMBER(19,0),
	PMTREG_DATED TIMESTAMP_NTZ(9),
	PMTREG_DEPOSITDATE TIMESTAMP_NTZ(9),
	PMTREG_MEMO VARCHAR(1000),
	PMTREG_PAYMENTREGISTERSTATUSID NUMBER(10,0),
	PMTREG_CLIENTID NUMBER(19,0),
	PMTREG_PERIODDATESID NUMBER(19,0),
	PMTREG_PAYMENTREGISTERTYPEID NUMBER(10,0),
	PMTREG_ORDERID NUMBER(10,0),
	PMTREG_AUTHORIZATIONNUMBER VARCHAR(50),
	PMTREG_TRANSACTIONNUMBER VARCHAR(50),
	PMTREG_CREATEDDATE TIMESTAMP_NTZ(9),
	PMTREG_CREATEDUSER VARCHAR(50),
	PMTREG_MODIFIEDDATE TIMESTAMP_NTZ(9),
	PMTREG_MODIFIEDUSER VARCHAR(50),
	PMTREG_TS VARCHAR(100),
	PMTREG_ACCTEXTID NUMBER(19,0),
	PMTREG_ACCTEXTDATE TIMESTAMP_NTZ(9),
	PMTREG_DEPOSITBALANCE NUMBER(18,2),
	PMTREG_AVAILABLETOPOST NUMBER(18,2),
	PMTREG_EDIID NUMBER(19,0),
	PMTREG_ELECTPMTCUSTID VARCHAR(20),
	PMTREG_ELECTPMTCUSTPMTID VARCHAR(20),
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