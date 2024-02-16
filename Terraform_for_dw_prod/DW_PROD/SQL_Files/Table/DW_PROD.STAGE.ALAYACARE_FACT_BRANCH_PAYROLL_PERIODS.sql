CREATE OR REPLACE TABLE DW_PROD.STAGE.ALAYACARE_FACT_BRANCH_PAYROLL_PERIODS (
	BRANCH_PAYROLL_PERIODS_KEY VARCHAR(32) NOT NULL,
	BRANCH_KEY VARCHAR(32) NOT NULL,
	OFFICE_STATE_CODE VARCHAR(2) NOT NULL,
	DETAILED_OFFICE_NAME VARCHAR(100) NOT NULL,
	PERIOD_START_DATE DATE,
	PERIOD_END_DATE DATE,
	CHECK_DATE DATE,
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	ETL_INFERRED_MEMBER_FLAG BOOLEAN NOT NULL
);