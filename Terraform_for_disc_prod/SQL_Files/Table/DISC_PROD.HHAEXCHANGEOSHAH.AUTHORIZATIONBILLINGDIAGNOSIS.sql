CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.AUTHORIZATIONBILLINGDIAGNOSIS (
	BILLINGDIAGNOSISID NUMBER(10,0) NOT NULL,
	AGENCYID NUMBER(10,0) NOT NULL,
	DIAGNOSISID NUMBER(10,0),
	DIAGNOSISCODE VARCHAR(500),
	DIAGNOSISDESCRIPTION VARCHAR(500),
	CONTRACTID NUMBER(10,0),
	AUTHID NUMBER(10,0),
	PATIENTID NUMBER(10,0),
	OFFICEID NUMBER(10,0),
	PRIMARYDIAGNOSIS VARCHAR(10),
	ADMITTINGDIAGNOSIS VARCHAR(10),
	ICD NUMBER(3,0),
	DISPLAYORDER NUMBER(5,0),
	CREATEDBY NUMBER(10,0),
	CREATEDBYUSER VARCHAR(200),
	CREATEDDATE TIMESTAMP_NTZ(9),
	CREATEDUTCDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDBYUSER VARCHAR(200),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDUTCDATE TIMESTAMP_NTZ(9),
	PAYERID NUMBER(19,0),
	ISVALID NUMBER(3,0),
	PAYERBILLINGDIAGNOSISID NUMBER(10,0),
	ADDEDBY VARCHAR(50),
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