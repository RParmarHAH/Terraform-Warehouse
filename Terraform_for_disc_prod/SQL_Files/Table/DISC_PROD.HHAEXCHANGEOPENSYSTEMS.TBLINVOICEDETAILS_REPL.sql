CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.TBLINVOICEDETAILS_REPL (
	INVOICEDETAILID NUMBER(19,0) NOT NULL,
	INVOICEHEADERID NUMBER(10,0),
	VISITID NUMBER(19,0),
	CAREGIVERID NUMBER(10,0),
	VISITSTARTTIME TIMESTAMP_NTZ(9),
	VISITENDTIME TIMESTAMP_NTZ(9),
	BILLEDHOURS NUMBER(10,0),
	BILLEDRATE NUMBER(18,6),
	OVERTIMEHOURS NUMBER(10,0),
	OVERTIMERATE NUMBER(18,2),
	TRAVELTIMEHOURS NUMBER(10,0),
	TRAVELTIMERATE NUMBER(18,2),
	BILLEDAMOUNT NUMBER(18,2),
	VISITDATE TIMESTAMP_NTZ(9),
	PATIENTID NUMBER(19,0),
	PAYERID NUMBER(19,0),
	AGENCYID NUMBER(10,0),
	INVSERVICECODEID NUMBER(10,0),
	INVCONTRACTSERVICECODE VARCHAR(50),
	INVRATETYPE VARCHAR(10),
	VISITPAYMENTSTATUS NUMBER(5,0),
	BILLEDUNITS NUMBER(8,2),
	AUTHORIZATIONNUMBER VARCHAR(50),
	LASTEXPORTEDDATE TIMESTAMP_NTZ(9),
	PATIENTPAIDAMOUNT NUMBER(18,2),
	INVOICEDETAILID3RDPARTY NUMBER(19,0),
	EBILLINGHOLD BOOLEAN,
	PAYERREFERENCENUMBER VARCHAR(100),
	OFFICEID NUMBER(10,0),
	SUBMISSIONDATE TIMESTAMP_NTZ(9),
	SUBMISSIONUTCDATE TIMESTAMP_NTZ(9),
	EBILLINGHOLDREASONTEXT VARCHAR(100),
	DFTAVISIT VARCHAR(10),
	EXTERNALSCHEDULEID VARCHAR(100),
	EXTERNALINVOICENUMBER VARCHAR(500),
	EXTERNALCLAIMNUMBER VARCHAR(500),
	BILLINGLINEITEMID VARCHAR(50),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	CREATEDUTCDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDUTCDATE TIMESTAMP_NTZ(9),
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