CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.BILLING_OTHERCHARGES_REPL (
	AGENCYID NUMBER(10,0),
	OTHERCHARGEID NUMBER(19,0) NOT NULL,
	PATIENTSUPPLYID NUMBER(10,0),
	CAREGIVEREXPENSEID NUMBER(10,0),
	CHARGETYPE VARCHAR(10),
	INVOICEHEADERID NUMBER(10,0),
	CHARGETYPENAME VARCHAR(100),
	BATCHID NUMBER(19,0),
	PATIENTID NUMBER(19,0),
	PAYERID NUMBER(10,0),
	BILLEDUNITS NUMBER(10,2),
	BILLEDRATE NUMBER(10,2),
	BILLEDAMOUNT NUMBER(10,2),
	PAYMENTAMOUNT NUMBER(10,2),
	EXPORTCODE VARCHAR(50),
	PAYMENTSTATUS VARCHAR(20),
	OTHERCHARGEDATE TIMESTAMP_NTZ(9),
	CAREGIVERID NUMBER(10,0),
	LASTEXPORTEDDATE TIMESTAMP_NTZ(9),
	PAYERREFERENCENUMBER VARCHAR(100),
	MILEAGEID NUMBER(10,0),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	CREATEDUTCDATE TIMESTAMP_NTZ(9),
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