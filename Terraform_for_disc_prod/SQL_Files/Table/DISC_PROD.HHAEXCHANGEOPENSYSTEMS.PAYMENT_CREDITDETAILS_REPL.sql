CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.PAYMENT_CREDITDETAILS_REPL (
	AGENCYID NUMBER(10,0),
	CREDITDETAILID NUMBER(19,0) NOT NULL,
	PAYERID NUMBER(10,0),
	PATIENTID NUMBER(10,0),
	CHECKID NUMBER(19,0),
	CHECKNUMBER VARCHAR(50),
	REFCHECKID NUMBER(19,0),
	REFCHECKNUMBER VARCHAR(50),
	VISITID NUMBER(10,0),
	AMOUNT NUMBER(18,2),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	VISITDATE TIMESTAMP_NTZ(9),
	VISIT VARCHAR(50),
	OTHERCHARGEID NUMBER(10,0),
	CREDITPATIENTID NUMBER(10,0),
	CREDITTYPE VARCHAR(50),
	POSTEDDATE TIMESTAMP_NTZ(9),
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