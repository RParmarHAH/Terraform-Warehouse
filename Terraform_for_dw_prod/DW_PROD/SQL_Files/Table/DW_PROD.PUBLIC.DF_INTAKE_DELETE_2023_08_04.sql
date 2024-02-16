CREATE OR REPLACE TABLE DW_PROD.PUBLIC.DF_INTAKE_DELETE_2023_08_04 (
	FLG NUMBER(1,0),
	INTAKE_KEY VARCHAR(32),
	REPORT_DATE DATE,
	BRANCH_KEY VARCHAR(32),
	CLIENT_KEY VARCHAR(32),
	CONTRACT_KEY VARCHAR(32),
	SOURCE_SYSTEM_ID NUMBER(1,0),
	PRE_AUTH_NUMBER VARCHAR(150),
	CLIENT_BEGIN_SERVICE_DATE DATE,
	CLIENT_END_SERVICE_DATE DATE,
	LATEST_AUTH_BEGIN_DATE TIMESTAMP_NTZ(9),
	LATEST_AUTH_END_DATE TIMESTAMP_NTZ(9),
	REAUTHORIZED_DATE DATE,
	BRANCH_NAME VARCHAR(50),
	CLIENT_NUMBER NUMBER(38,0),
	CONTRACT_CODE VARCHAR(10),
	BILL_RATE NUMBER(37,11),
	SYSTEM_CODE VARCHAR(10),
	CASE_MANAGER VARCHAR(50),
	HOURS_AUTHORIZED NUMBER(38,12),
	HOURS_AUTHORIZED_NON_ADJUSTED NUMBER(18,5),
	ETL_TASK_KEY NUMBER(1,0),
	ETL_INSERTED_TASK_KEY NUMBER(1,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG NUMBER(1,0)
);