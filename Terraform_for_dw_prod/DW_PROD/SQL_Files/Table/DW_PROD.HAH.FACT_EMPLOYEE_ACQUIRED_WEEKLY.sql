CREATE OR REPLACE TABLE DW_PROD.HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY (
	EMPLOYEE_ACQUIRED_KEY VARCHAR(32),
	ORIGINAL_EMPLOYEE_KEY VARCHAR(32),
	EMPLOYEE_KEY VARCHAR(32),
	EMPLOYEE_ID VARCHAR(50),
	SOURCE_SYSTEM_ID NUMBER(38,0),
	SYSTEM_CODE VARCHAR(20),
	ORIGINAL_BRANCH_KEY VARCHAR(32),
	BRANCH_KEY VARCHAR(32),
	CONTRACT_KEY VARCHAR(32),
	SERVICE_WEEK DATE,
	AQUISITION_NAME VARCHAR(250),
	ETL_TASK_KEY NUMBER(1,0),
	ETL_INSERTED_TASK_KEY NUMBER(1,0),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN
);