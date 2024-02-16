CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.PAYMENT_PATIENTCREDITHEADER_REPL (
	AGENCYID NUMBER(10,0),
	PATIENTCREDITHEADERID NUMBER(19,0) NOT NULL,
	TYPE NUMBER(10,0),
	PAYERID NUMBER(10,0),
	PATIENTID NUMBER(10,0),
	CHECKID NUMBER(10,0),
	CHECKNUMBER VARCHAR(50),
	CHECKDATE TIMESTAMP_NTZ(9),
	CHECKAMOUNT NUMBER(18,2),
	BALANCEAMOUNT NUMBER(18,2),
	POSTEDDATE TIMESTAMP_NTZ(9),
	CREATEDBY NUMBER(19,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(19,0),
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