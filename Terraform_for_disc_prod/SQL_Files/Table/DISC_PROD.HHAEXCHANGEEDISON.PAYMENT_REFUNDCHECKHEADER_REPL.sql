CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEEDISON.PAYMENT_REFUNDCHECKHEADER_REPL (
	AGENCYID NUMBER(10,0),
	REFUNDCHECKHEADERID NUMBER(19,0),
	PAYERID NUMBER(10,0),
	CHECKNUMBER VARCHAR(50),
	CHECKDATE TIMESTAMP_NTZ(9),
	CHECKAMOUNT NUMBER(18,2),
	CHECKMEMO VARCHAR(1500),
	REFUNDTYPE NUMBER(10,0),
	CHECKSTATUS NUMBER(10,0),
	SENTDATE TIMESTAMP_NTZ(9),
	POSTEDDATE TIMESTAMP_NTZ(9),
	TYPE NUMBER(10,0),
	CREDITUSEDAMOUNT NUMBER(18,2),
	PAYERNAME VARCHAR(100),
	PATIENTID NUMBER(10,0),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	CREATEDUTCDATE TIMESTAMP_NTZ(9),
	UPDATEDUTCDATE TIMESTAMP_NTZ(9),
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