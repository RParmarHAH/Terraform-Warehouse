CREATE OR REPLACE TABLE DW_PROD.STAGE.EDISON_FACT_ADMISSION (
	CLIENT_ADMISSION_KEY VARCHAR(32) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	CLIENT_KEY VARCHAR(32) NOT NULL,
	REFERRER_KEY VARCHAR(32),
	SERVICE_KEY VARCHAR(32),
	PARTNER_CONTRACT_KEY VARCHAR(32),
	PRIMARY_DIAGNOSIS_KEY VARCHAR(32),
	REFERRAL_DATE DATE,
	REFERRAL_INTAKE_BY_EMP_KEY VARCHAR(32),
	REFERRAL_ACCEPTED_SERVICES VARCHAR(16777216),
	REFERRAL_CAMPAIGN VARCHAR(16777216),
	PREVIOUS_PROVIDER VARCHAR(16777216),
	ADMISSION_DATE DATE,
	STATUS VARCHAR(30),
	PRIMARY_DIAGNOSIS VARCHAR(16777216),
	DIAGNOSIS_NOTES VARCHAR(16777216),
	DISCHARGE_DATE DATE,
	DISCHARGE_REASON VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL
);