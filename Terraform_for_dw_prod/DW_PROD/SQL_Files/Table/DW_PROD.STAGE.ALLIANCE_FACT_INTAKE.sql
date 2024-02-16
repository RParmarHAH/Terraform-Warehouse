CREATE OR REPLACE TABLE DW_PROD.STAGE.ALLIANCE_FACT_INTAKE (
	INTAKE_KEY VARCHAR(32) NOT NULL,
	REPORT_DATE DATE NOT NULL,
	BRANCH_KEY VARCHAR(32) NOT NULL,
	CLIENT_KEY VARCHAR(32) NOT NULL,
	CONTRACT_KEY VARCHAR(32) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	REAUTHORIZED_DATE DATE NOT NULL,
	PRE_AUTH_NUMBER VARCHAR(50),
	BEGIN_SERVICE_DATE DATE,
	END_SERVICE_DATE DATE,
	LATEST_AUTH_BEGIN_DATE DATE,
	LATEST_AUTH_END_DATE DATE,
	BRANCH_NAME VARCHAR(100),
	CLIENT_NUMBER NUMBER(38,0),
	CONTRACT_CODE VARCHAR(16777216),
	BILL_RATE NUMBER(10,2),
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	CASE_MANAGER VARCHAR(100),
	HOURS_AUTHORIZED NUMBER(38,3),
	HOURS_AUTHORIZED_NON_ADJUSTED NUMBER(38,3),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	constraint PK_ALLIANCE_FACT_INTAKE primary key (INTAKE_KEY)
);