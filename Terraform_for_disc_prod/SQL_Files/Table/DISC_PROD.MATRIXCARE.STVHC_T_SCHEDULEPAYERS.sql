CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_SCHEDULEPAYERS (
	SCHCP_ID NUMBER(19,0),
	SCHCP_CLIENTPAYERID NUMBER(19,0),
	SCHCP_PAYERID NUMBER(19,0),
	SCHCP_ADMISSIONID NUMBER(19,0),
	SCHCP_SCHEDULEID NUMBER(19,0),
	SCHCP_SCHEDULEEXPENSEID NUMBER(19,0),
	SCHCP_SEQNO NUMBER(10,0),
	SCHCP_BILLSPLITTYPEID VARCHAR(1),
	SCHCP_AMOUNT NUMBER(18,2),
	SCHCP_PERCENT NUMBER(18,0),
	SCHCP_DISCOUNTAMOUNT NUMBER(18,2),
	SCHCP_DISCOUNTPERCENT NUMBER(18,0),
	SCHCP_COPAYERID NUMBER(19,0),
	SCHCP_COPAYINVOICENOTE VARCHAR(255),
	SCHCP_NOTES VARCHAR(255),
	SCHCP_SOURCE NUMBER(3,0),
	SCHCP_EXCLUDEHOLIDAY BOOLEAN,
	SCHCP_CREATEDDATE TIMESTAMP_NTZ(9),
	SCHCP_CREATEDUSER VARCHAR(50),
	SCHCP_MODIFIEDDATE TIMESTAMP_NTZ(9),
	SCHCP_MODIFIEDUSER VARCHAR(50),
	SCHCP_TS VARCHAR(100),
	SCHCP_INVOICEID NUMBER(19,0),
	SCHCP_CANCELDATE TIMESTAMP_NTZ(9),
	SCHCP_ADDRESSBOOKID NUMBER(19,0),
	SCHCP_FEECHARTID NUMBER(10,0),
	SCHCP_CHARGEALLOCATIONSEQNO NUMBER(10,0),
	SCHCP_TRANSFERFROMINVOICEHEADERID NUMBER(19,0),
	SCHCP_TRANSFERTOINVOICEHEADERID NUMBER(19,0),
	SCHCP_MANAGECOB NUMBER(10,0),
	SCHCP_COBSTATUS NUMBER(10,0),
	INSERTDATE TIMESTAMP_NTZ(9),
	UPDATEDATE TIMESTAMP_NTZ(9),
	DELETEDFLAG BOOLEAN,
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