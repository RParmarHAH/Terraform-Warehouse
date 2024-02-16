CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.TRANSACTIONS_REPL (
	AGENCYID NUMBER(10,0),
	SEQ NUMBER(10,0) NOT NULL,
	TRANSACTIONDATE TIMESTAMP_NTZ(9),
	TRANSACTIONNUMBER VARCHAR(100),
	TRANSACTIONTYPE VARCHAR(100),
	TRANSACTIONID NUMBER(10,0),
	VISITID NUMBER(19,0),
	PAYERID NUMBER(10,0),
	DEBITAMOUNT NUMBER(18,2),
	CREDITAMOUNT NUMBER(18,2),
	NOTES VARCHAR(500),
	CREATEDDATE TIMESTAMP_NTZ(9),
	VISITDATE TIMESTAMP_NTZ(9),
	CHECKDATE TIMESTAMP_NTZ(9),
	DEPOSITDATE TIMESTAMP_NTZ(9),
	SERVICECODE VARCHAR(100),
	BILLEDHOURS NUMBER(5,0),
	BILLEDUNITS NUMBER(10,2),
	PATIENTID NUMBER(10,0),
	POSTEDDATE TIMESTAMP_NTZ(9),
	RATETYPE VARCHAR(10),
	SERVICECODEID NUMBER(10,0),
	CAREIVERID NUMBER(10,0),
	DISCIPLINEID NUMBER(10,0),
	INVOICENUMBER NUMBER(19,0),
	TTHOURS NUMBER(5,0),
	OTHOURS NUMBER(5,0),
	OFFICEID NUMBER(10,0),
	CHARGETYPE VARCHAR(10),
	OTHERCHARGEID NUMBER(10,0),
	VISITADJUSTMENTREASONTEXT VARCHAR(200),
	REFUNDCHECKHEADERID NUMBER(19,0),
	TRANSACTIONUTCDATE TIMESTAMP_NTZ(9),
	CREDITREFNUMBER VARCHAR(500),
	OTHERADJUSTMENT NUMBER(10,2),
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