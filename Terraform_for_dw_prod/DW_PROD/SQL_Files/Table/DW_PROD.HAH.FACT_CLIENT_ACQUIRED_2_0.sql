CREATE OR REPLACE TABLE DW_PROD.HAH.FACT_CLIENT_ACQUIRED_2_0 (
	CLIENT_ACQUIRED_KEY VARCHAR(32),
	ORIGINAL_CLIENT_KEY VARCHAR(32),
	CLIENT_KEY VARCHAR(32),
	CLIENT_NUMBER VARCHAR(50),
	SOURCE_SYSTEM_ID NUMBER(38,0),
	SYSTEM_CODE VARCHAR(20),
	ORIGINAL_BRANCH_KEY VARCHAR(32),
	BRANCH_KEY VARCHAR(32),
	PARTNER_CONTRACT_SERVICE_KEY VARCHAR(32),
	SERVICE_MONTH DATE,
	AQUISITION_NAME VARCHAR(20),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);