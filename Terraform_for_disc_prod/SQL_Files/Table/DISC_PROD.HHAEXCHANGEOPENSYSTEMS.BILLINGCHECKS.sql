CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.BILLINGCHECKS (
	AGENCYID NUMBER(10,0),
	CHECKID NUMBER(19,0) NOT NULL,
	PAYERNAME VARCHAR(100),
	CHECKNUMBER VARCHAR(50),
	CHECKDATE TIMESTAMP_NTZ(9),
	DEPOSITDATE TIMESTAMP_NTZ(9),
	CHECKAMOUNT NUMBER(18,2),
	APPLIEDAMOUNT NUMBER(18,2),
	REMIANINGAMOUNT NUMBER(18,2),
	PAYMENTNOTES VARCHAR(16777216),
	USERNAME VARCHAR(50),
	APPLYFROMCREDITAMOUNT NUMBER(38,2),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
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