CREATE OR REPLACE TABLE DW_PROD.PUBLIC.DATAFLEXSYNCDATA_FACT_CLIENT_SERVICE_BACKUP_20240209 (
	CLIENT_SERVICE_KEY VARCHAR(32),
	SOURCE_SYSTEM_ID NUMBER(38,0),
	SYSTEM_CODE VARCHAR(20),
	PARTNER_CONTRACT_SERVICE_KEY VARCHAR(32),
	CLIENT_ADMISSION_KEY VARCHAR(32),
	CLIENT_KEY VARCHAR(32),
	SERVICE_KEY VARCHAR(32),
	BILL_CODE VARCHAR(50),
	BILL_TYPE VARCHAR(20),
	BILL_UOM VARCHAR(20),
	SCHEDULE_TYPE VARCHAR(20),
	SCHEDULE_UOM VARCHAR(20),
	AUTHORIZATION_DISCIPLINE VARCHAR(50),
	AUTHORIZATION_DATE DATE,
	AUTHORIZATION_PERIOD_START_DATE DATE,
	AUTHORIZATION_PERIOD_END_DATE DATE,
	EFFECTIVE_DAYS NUMBER(38,0),
	AUTHORIZATION_TYPE VARCHAR(20),
	AUTHORIZATION_UOM VARCHAR(20),
	AUTH_INFO VARIANT,
	AUTHORIZATION_MAX_UNITS_BY_UOM VARCHAR(200),
	AUTHORIZATION_MAX_UNITS VARCHAR(200),
	AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM VARCHAR(200),
	AUTHORIZATION_MAX_UNITS_ADJUSTED VARCHAR(200),
	ACTIVE_FLAG BOOLEAN,
	CANCELLED_FLAG BOOLEAN,
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);