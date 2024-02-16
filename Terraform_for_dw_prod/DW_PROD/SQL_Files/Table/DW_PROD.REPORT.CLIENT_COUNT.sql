CREATE OR REPLACE TABLE DW_PROD.REPORT.CLIENT_COUNT (
	CONTRACT_KEY VARCHAR(32),
	BRANCH_KEY VARCHAR(32),
	SUPERVISOR_KEY VARCHAR(32),
	REPORT_DATE DATE,
	LAST_MONTH DATE,
	CLIENT_COUNT NUMBER(38,0),
	LOST_CLIENT NUMBER(18,0),
	NEW_CLIENTS NUMBER(13,0),
	CONVERTED_CLIENT NUMBER(30,0),
	REFERRED_LAST_MONTH NUMBER(13,0),
	CONVERTED_LAST_MONTH NUMBER(13,0),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	ETL_INFERRED_MEMBER_FLAG BOOLEAN NOT NULL
);