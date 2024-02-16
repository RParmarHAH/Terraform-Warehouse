CREATE OR REPLACE TABLE DW_PROD.REPORT.HOURS_AND_CENSUS_BY_PAYROLL_DATE_WEEKLY_2_0 (
	SERVICE_WEEK DATE,
	BILL_UNIT VARCHAR(20),
	SERVICE_END_OF_WEEK DATE,
	BRANCH_KEY VARCHAR(32),
	CONTRACT_KEY VARCHAR(32),
	SUPERVISOR_KEY VARCHAR(32),
	CLIENT_KEY_DATA VARCHAR(32),
	PARTNER_CONTRACT_SERVICE_KEY VARCHAR(32),
	ORIGINAL_SOURCE_SYSTEM_ID NUMBER(38,0),
	SOURCE_SYSTEM_ID NUMBER(38,0),
	CLIENT_KEY VARCHAR(16777216),
	HOURS_SCHEDULED NUMBER(18,2),
	HOURS_SERVED_ALL NUMBER(38,3),
	HOURS_CANCELLED NUMBER(18,2),
	HOURS_IN_REVIEW NUMBER(18,2),
	HOURS_MISSED NUMBER(18,2),
	FUTURE_HOURS NUMBER(18,2),
	FUTURE_CANCELLED_HOURS NUMBER(18,2),
	FUTURE_HOLD_HOURS NUMBER(18,2),
	HOURS_RESCHEDULED NUMBER(18,2),
	VISITS_SCHEDULED NUMBER(18,0),
	VISITS_COMPLETED NUMBER(18,0),
	VISITS_CANCELLED NUMBER(18,0),
	VISITS_IN_REVIEW NUMBER(18,0),
	VISITS_MISSED NUMBER(18,0),
	FUTURE_VISITS NUMBER(18,0),
	FUTURE_CANCELLED_VISITS NUMBER(18,0),
	FUTURE_HOLD_VISITS NUMBER(18,0),
	VISITS_RESCHEDULED NUMBER(18,0),
	HOURS_AUTHORIZED NUMBER(18,0),
	HOURS_AUTHORIZED_NON_ADJUSTED NUMBER(18,0),
	VISITS_CLEAN_SHIFTS NUMBER(30,0),
	VISITS_NEED_MAINTENANCE NUMBER(30,0),
	CLIENT_SERVED_FLAG BOOLEAN,
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG NUMBER(1,0),
	ETL_INFERRED_MEMBER_FLAG NUMBER(1,0),
	CLIENT_ACQUIRED_FLAG BOOLEAN,
	CLIENT_ACQUISITION_NAME VARCHAR(16777216)
);