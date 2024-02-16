CREATE OR REPLACE TABLE DW_PROD.HAH.FACT_BUDGET_BKCP_12152023 (
	BUDGET_KEY VARCHAR(32) NOT NULL,
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	CALENDAR_DATE DATE NOT NULL,
	BRANCH_KEY VARCHAR(32) NOT NULL,
	STATE_CODE VARCHAR(2),
	BRANCH_NAME VARCHAR(100),
	OFFICE_NUMBER NUMBER(38,0),
	OFFICE_CODE VARCHAR(5),
	SERVICE_LINE_CODE VARCHAR(50) NOT NULL,
	YEAR_MONTH VARCHAR(6),
	CLIENT_COUNT_BUDGETED_DAILY NUMBER(15,3),
	CLIENT_COUNT_BUDGETED_MONTHLY NUMBER(15,3),
	CLIENT_COUNT_BUDGETED_MONTHLY_ROLLING_TOTAL NUMBER(15,3),
	HOURS_BUDGETED_DAILY NUMBER(15,3),
	HOURS_BUDGETED_MONTHLY NUMBER(15,3),
	HOURS_BUDGETED_MONTHLY_ROLLING_TOTAL NUMBER(15,3),
	REVENUE_BUDGETED_DAILY NUMBER(15,3),
	REVENUE_BUDGETED_MONTHLY NUMBER(15,3),
	REVENUE_BUDGETED_MONTHLY_ROLLING_TOTAL NUMBER(15,3),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	CAREGIVER_COUNT_BUDGETED_DAILY NUMBER(15,3),
	CAREGIVER_COUNT_BUDGETED_MONTHLY NUMBER(15,3),
	CAREGIVER_COUNT_BUDGETED_MONTHLY_ROLLING_TOTAL NUMBER(15,3),
	constraint PK_FACT_BUDGET primary key (BUDGET_KEY)
);