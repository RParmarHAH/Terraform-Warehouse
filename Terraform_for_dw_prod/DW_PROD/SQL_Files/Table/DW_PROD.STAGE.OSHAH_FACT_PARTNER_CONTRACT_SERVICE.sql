CREATE OR REPLACE TABLE DW_PROD.STAGE.OSHAH_FACT_PARTNER_CONTRACT_SERVICE (
	PARTNER_CONTRACT_SERVICE_KEY VARCHAR(32),
	SOURCE_SYSTEM_ID NUMBER(38,0),
	SYSTEM_CODE VARCHAR(20),
	STATE VARCHAR(16777216),
	PARTNER_CONTRACT_KEY VARCHAR(32),
	PARTNER_CODE VARCHAR(32),
	PARTNER_NAME VARCHAR(50),
	CONTRACT_CODE VARCHAR(10),
	CONTRACT_NAME VARCHAR(50),
	SERVICE_KEY VARCHAR(32),
	SERVICE_CODE VARCHAR(50),
	SERVICE_NAME VARCHAR(50),
	BILLING_KEY VARCHAR(32),
	BILL_CODE VARCHAR(50),
	BILL_NAME VARCHAR(50),
	BILLABLE_FLAG BOOLEAN,
	BILL_TYPE VARCHAR(20),
	BILL_UOM VARCHAR(32),
	SCHEDULE_TYPE VARCHAR(20),
	SCHEDULE_UOM VARCHAR(32),
	AUTHORIZATION_REQUIRED_FLAG BOOLEAN,
	PAYABLE_FLAG BOOLEAN,
	EXPENSE_FLAG BOOLEAN,
	MILEAGE_FLAG BOOLEAN,
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);