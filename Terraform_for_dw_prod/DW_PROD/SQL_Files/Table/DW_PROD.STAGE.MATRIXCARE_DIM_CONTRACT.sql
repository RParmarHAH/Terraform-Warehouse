CREATE OR REPLACE TABLE DW_PROD.STAGE.MATRIXCARE_DIM_CONTRACT (
	CONTRACT_KEY VARCHAR(32),
	CONTRACT_CODE VARCHAR(10),
	SYSTEM_CODE VARCHAR(20),
	SOURCE_SYSTEM_ID NUMBER(38,0),
	CONTRACT_NAME VARCHAR(100),
	SERVICE_CODE_ID VARCHAR(10),
	SERVICE_KEY VARCHAR(32),
	DEFAULT_BILL_CODE VARCHAR(50),
	PAYROLL_CODE VARCHAR(50),
	REVENUE_CATEGORY VARCHAR(50),
	REVENUE_SUBCATEGORY_CODE VARCHAR(10),
	REVENUE_SUBCATEGORY_NAME VARCHAR(50),
	PAYOR_CODE VARCHAR(50),
	PAYOR_DESCRIPTION VARCHAR(100),
	SERVICE_LINE_CODE VARCHAR(50),
	SERVICE_LINE_DESCRIPTION VARCHAR(100),
	CONTRACT_STATE_CODE VARCHAR(2),
	TIME_TRANSLATION_CODE VARCHAR(10),
	TIME_TRANSLATION_DIVIDER NUMBER(38,0),
	PAY_TRAVELS_CODE VARCHAR(3),
	MILEAGE_FLAG BOOLEAN,
	PAYABLE_FLAG BOOLEAN,
	BILLABLE_FLAG BOOLEAN,
	BILLED_BY_QUARTER_HOURS BOOLEAN,
	BILLED_BY_HALF_HOURS BOOLEAN,
	EFFECTIVE_FROM_DATE TIMESTAMP_NTZ(9),
	EFFECTIVE_TO_DATE TIMESTAMP_NTZ(9),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN,
	ETL_INFERRED_MEMBER_FLAG BOOLEAN
);