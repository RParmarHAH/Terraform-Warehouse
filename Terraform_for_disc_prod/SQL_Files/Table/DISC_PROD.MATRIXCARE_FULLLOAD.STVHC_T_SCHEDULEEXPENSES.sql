CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_SCHEDULEEXPENSES (
	SCHEXP_ID NUMBER(19,0),
	SCHEXP_SCHID NUMBER(19,0),
	SCHEXP_EXPID NUMBER(10,0),
	SCHEXP_CLIENTPAYERID NUMBER(19,0),
	SCHEXP_PAYERID NUMBER(19,0),
	SCHEXP_COSTUNITS NUMBER(18,0),
	SCHEXP_COSTRATEOVERRIDEAMT NUMBER(18,2),
	SCHEXP_COSTRATEOVERRIDEMODIFIEDUSER VARCHAR(50),
	SCHEXP_COSTRATEOVERRIDEMODIFIEDDATE TIMESTAMP_NTZ(9),
	SCHEXP_BILLUNITS NUMBER(18,0),
	SCHEXP_BILLRATEUNITFLAG NUMBER(5,0),
	SCHEXP_BILLRATEOVERRIDEAMT NUMBER(18,2),
	SCHEXP_BILLRATEOVERRIDEMODIFIEDUSER VARCHAR(50),
	SCHEXP_BILLRATEOVERRIDEMODIFIEDDATE TIMESTAMP_NTZ(9),
	SCHEXP_BILLRATEID NUMBER(19,0),
	SCHEXP_BILLRATE NUMBER(18,2),
	SCHEXP_PAYUNITS NUMBER(18,0),
	SCHEXP_PAYRATEUNITFLAG NUMBER(5,0),
	SCHEXP_PAYRATEOVERRIDEAMT NUMBER(18,2),
	SCHEXP_PAYRATEOVERRIDEMODIFIEDUSER VARCHAR(50),
	SCHEXP_PAYRATEOVERRIDEMODIFIEDDATE TIMESTAMP_NTZ(9),
	SCHEXP_NOTES VARCHAR(255),
	SCHEXP_PAYDATE TIMESTAMP_NTZ(9),
	SCHEXP_REVENUECODE NUMBER(3,0),
	SCHEXP_PAYCODE NUMBER(3,0),
	SCHEXP_PAYREVIEWFLAG BOOLEAN,
	SCHEXP_PAYROLLBATCHID NUMBER(19,0),
	SCHEXP_NOTESDATE TIMESTAMP_NTZ(9),
	SCHEXP_BILLINGSTATUS NUMBER(3,0),
	SCHEXP_CREATEDDATE TIMESTAMP_NTZ(9),
	SCHEXP_CREATEDUSER VARCHAR(50),
	SCHEXP_MODIFIEDDATE TIMESTAMP_NTZ(9),
	SCHEXP_MODIFIEDUSER VARCHAR(50),
	SCHEXP_TS VARCHAR(100),
	SCHEXP_TOTALCHARGE NUMBER(18,2),
	SCHEXP_BILLOTUNITS NUMBER(18,0),
	SCHEXP_BILLOTMULTI NUMBER(18,0),
	SCHEXP_ORIGINALPAYDATE TIMESTAMP_NTZ(9),
	SCHEXP_TOTALBILLABLE NUMBER(18,2),
	SCHEXP_TOTALBILLED NUMBER(18,2),
	SCHEXP_TOTALPAID NUMBER(18,2),
	SCHEXP_INVOICEDETAILDESCRIPTION VARCHAR(100),
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