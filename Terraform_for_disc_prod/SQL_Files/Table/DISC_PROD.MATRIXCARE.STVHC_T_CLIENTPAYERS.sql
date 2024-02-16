CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_CLIENTPAYERS (
	CLIPAY_ID NUMBER(19,0),
	CLIPAY_CLIENTID NUMBER(19,0),
	CLIPAY_PAYERID NUMBER(19,0),
	CLIPAY_SEQNO NUMBER(10,0),
	CLIPAY_POLICYNUMBER VARCHAR(25),
	CLIPAY_EFFECTIVEDATE TIMESTAMP_NTZ(9),
	CLIPAY_EXPIRATIONDATE TIMESTAMP_NTZ(9),
	CLIPAY_BILLSPLITTYPEID VARCHAR(1),
	CLIPAY_DEFAULTFLAG BOOLEAN,
	CLIPAY_AMOUNT NUMBER(18,2),
	CLIPAY_PERCENT NUMBER(18,0),
	CLIPAY_DISCOUNTAMOUNT NUMBER(18,2),
	CLIPAY_DISCOUNTPERCENT NUMBER(18,0),
	CLIPAY_DEDUCTIBLE NUMBER(18,2),
	CLIPAY_DEDUCTIBLEBALANCE NUMBER(18,2),
	CLIPAY_COPAYERID NUMBER(19,0),
	CLIPAY_COPAYAMOUNT NUMBER(18,2),
	CLIPAY_COPAYPERCENT NUMBER(18,0),
	CLIPAY_COPAYMULTIPLIER VARCHAR(1),
	CLIPAY_COPAYINVOICENOTE VARCHAR(255),
	CLIPAY_NOTES VARCHAR(255),
	CLIPAY_BILLNOTE VARCHAR(255),
	CLIPAY_ACTIVEFLAG BOOLEAN,
	CLIPAY_EXCLUDEHOLIDAY BOOLEAN,
	CLIPAY_CREATEDDATE TIMESTAMP_NTZ(9),
	CLIPAY_CREATEDUSER VARCHAR(50),
	CLIPAY_MODIFIEDDATE TIMESTAMP_NTZ(9),
	CLIPAY_MODIFIEDUSER VARCHAR(50),
	CLIPAY_TS VARCHAR(100),
	CLIPAY_AUTHREQUIRED BOOLEAN,
	CLIPAY_AUTHSUSESERVICECATEGORIES BOOLEAN,
	CLIPAY_AUTHORIZATIONCONFLICTSALLOW NUMBER(3,0),
	CLIPAY_ADDRESSBOOKID NUMBER(19,0),
	CLIPAY_CHARGEALLOCATIONSEQNO NUMBER(10,0),
	CLIPAY_MANAGECOB NUMBER(10,0),
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