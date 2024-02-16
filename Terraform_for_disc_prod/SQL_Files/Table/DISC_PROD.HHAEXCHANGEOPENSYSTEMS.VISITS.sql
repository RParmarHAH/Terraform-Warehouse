CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.VISITS (
	AGENCYID NUMBER(10,0),
	PATIENTID NUMBER(10,0),
	VISITID NUMBER(19,0) NOT NULL,
	VISITDATE TIMESTAMP_NTZ(9),
	SCHEDULEDSTARTTIME TIMESTAMP_NTZ(9),
	SCHEDULEDENDTIME TIMESTAMP_NTZ(9),
	IVRCALLIN TIMESTAMP_NTZ(9),
	IVRCALLOUT TIMESTAMP_NTZ(9),
	VISITSTARTTIME TIMESTAMP_NTZ(9),
	VISITENDTIME TIMESTAMP_NTZ(9),
	DUTIES VARCHAR(8000),
	APPROVEDTRAVELTIMEHOURS VARCHAR(10),
	MISSEDVISIT VARCHAR(1),
	TIMESHEETREQUIRED VARCHAR(1),
	TIMESHEETRECEIVED VARCHAR(1),
	PRIMARYBILLTO VARCHAR(50),
	PRIMARYSERVICECODE VARCHAR(50),
	PRIMARYCONTRACTHOURS VARCHAR(6),
	PRIMARYBILLTYPE VARCHAR(1),
	DISCIPLINE VARCHAR(20),
	SECONDARYBILLTO VARCHAR(50),
	SECONDARYSERVICECODE VARCHAR(50),
	SECONDARYCONTRACTHOURS VARCHAR(6),
	SECONDARYBILLTYPE VARCHAR(1),
	BILLED VARCHAR(1),
	BILLEDHOURS VARCHAR(6),
	TRAVELTIMEHOURS VARCHAR(6),
	OVERTIMEHOURS VARCHAR(6),
	BILLEDAMOUNT NUMBER(18,2),
	INVOICENUMBER NUMBER(19,0) NOT NULL,
	INVOICEDATE TIMESTAMP_NTZ(9),
	BATCHNUMBER VARCHAR(20),
	BILLINGEXPORTED VARCHAR(1),
	BILLINGEXPORTDATE TIMESTAMP_NTZ(9),
	AIDEID NUMBER(10,0),
	PAYRATE VARCHAR(100),
	PAID VARCHAR(1),
	PAIDDATE TIMESTAMP_NTZ(9),
	PAYROLLBATCHNUMBER VARCHAR(50),
	PAYROLLEXPORTED VARCHAR(1),
	PAYROLLEXPORTDATE TIMESTAMP_NTZ(9),
	PAIDAMOUNT NUMBER(18,2),
	PAIDHOURS VARCHAR(6),
	THIRDPARTYAMOUNT NUMBER(18,2),
	BILLEDRATE NUMBER(18,6),
	CONTRACTID NUMBER(10,0),
	PAYERID NUMBER(10,0),
	OFFICEID NUMBER(10,0),
	IMPORTID VARCHAR(100),
	EVVSOURCESTARTTIME VARCHAR(10),
	EVVTYPESTARTTIME VARCHAR(10),
	EVVSOURCEENDTIME VARCHAR(10),
	EVVTYPEENDTIME VARCHAR(10),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
	INVOICEDETAILID NUMBER(19,0) NOT NULL,
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