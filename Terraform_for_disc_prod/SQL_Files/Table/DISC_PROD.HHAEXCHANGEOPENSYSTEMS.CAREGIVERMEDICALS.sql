CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CAREGIVERMEDICALS (
	AGENCYID NUMBER(10,0) NOT NULL,
	CAREGIVERMEDICALID NUMBER(10,0) NOT NULL,
	CAREGIVERID NUMBER(10,0),
	MEDICALNAME VARCHAR(200),
	DATE TIMESTAMP_NTZ(9),
	RESULT VARCHAR(100),
	EXPIRATIONDATE TIMESTAMP_NTZ(9),
	COMMENTS VARCHAR(2000),
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