CREATE OR REPLACE TABLE DW_PROD.REPORT.CLIENT_CENSUS (
	CLIENT_KEY VARCHAR(32),
	ORIGINAL_CLIENT_KEY VARCHAR(32),
	SOURCE_SYSTEM_ID NUMBER(5,0),
	ORIGINAL_SOURCE_SYSTEM_ID NUMBER(5,0),
	BRANCH_KEY VARCHAR(32),
	ORIGINAL_BRANCH_KEY VARCHAR(32),
	SUPERVISOR_KEY VARCHAR(32),
	REVENUE_CATEGORY VARCHAR(50),
	REVENUE_SUBCATEGORY_CODE VARCHAR(50),
	SERVICE_MONTH DATE,
	TERMINATED_FLAG NUMBER(1,0),
	REFERRAL_DATE DATE,
	FIRST_SERVICE_DATE DATE,
	LAST_SERVICE_DATE DATE,
	REACTIVATED_FLAG NUMBER(1,0),
	NEW_FLAG NUMBER(1,0),
	INCLUDE_FOR_OPS_PERF_CLIENTS BOOLEAN,
	INCLUDE_FOR_EXEC_OPS_CLIENTS BOOLEAN
);