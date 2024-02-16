CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.PATIENTCONTRACTS_REPL (
	AGENCYID NUMBER(10,0),
	PATIENTCONTRACTID NUMBER(10,0),
	CONTRACTID NUMBER(10,0),
	PATIENTID NUMBER(19,0),
	ALTPATIENTID VARCHAR(50),
	DELETED BOOLEAN,
	STARTDATE TIMESTAMP_NTZ(9),
	DISCHARGEDATE TIMESTAMP_NTZ(9),
	PAYERID NUMBER(10,0),
	ISPRIMARYCONTRACT BOOLEAN,
	PCOFFICEID NUMBER(10,0),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
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