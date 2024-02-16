CREATE OR REPLACE TABLE DW_PROD.REPORT.CLIENTS_STARTED (
	PERIOD_BEGIN_DATE DATE NOT NULL,
	CLIENT_KEY VARCHAR(32) NOT NULL,
	ORIGINAL_CLIENT_KEY VARCHAR(32) NOT NULL,
	CONTRACT_KEY VARCHAR(32) NOT NULL,
	FIRST_SERVICE_DATE DATE NOT NULL,
	FIRST_BRANCH_KEY VARCHAR(32) NOT NULL,
	ORIGINAL_FIRST_BRANCH_KEY VARCHAR(32) NOT NULL,
	FIRST_SUPERVISOR_KEY VARCHAR(32) NOT NULL,
	HOURS_SERVED NUMBER(38,3) NOT NULL,
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	constraint PK_CLIENTS_STARTED_CLIENT_KEY_CONTRACT_KEY primary key (CLIENT_KEY, CONTRACT_KEY)
);