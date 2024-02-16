CREATE OR REPLACE TABLE DW_PROD.REPORT.CLIENT_LINEAR_RETENTION_FORWARD_MONTHLY (
	SERVICE_MONTH_NAME VARCHAR(16777216),
	SERVICE_MONTH DATE,
	CLIENT_KEY VARCHAR(16777216),
	BRANCH_KEY VARCHAR(32),
	"1_month_active" BOOLEAN,
	"3_month_active" BOOLEAN,
	"12_month_active" BOOLEAN,
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG NUMBER(1,0)
);