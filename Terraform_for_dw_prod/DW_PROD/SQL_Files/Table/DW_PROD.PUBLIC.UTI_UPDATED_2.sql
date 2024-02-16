CREATE OR REPLACE TABLE DW_PROD.PUBLIC.UTI_UPDATED_2 (
	PERIOD_BEGIN_DATE DATE,
	STATE VARCHAR(500),
	TYPE VARCHAR(20),
	BRANCH_KEY VARCHAR(32),
	ORIGINAL_BRANCH_KEY VARCHAR(32),
	OFFICE_NUMBER NUMBER(38,0),
	OFFICE_NAME VARCHAR(100),
	SUPERVISOR_KEY VARCHAR(32),
	SUPERVISOR_CODE VARCHAR(50),
	ABSOLUTE_FIRST_SERVICE_DATE DATE,
	CLIENT_KEY VARCHAR(32),
	ORIGINAL_CLIENT_KEY VARCHAR(32),
	CLIENT_NUMBER VARCHAR(50),
	ORIGINAL_CLIENT_NUMBER VARCHAR(50),
	ORIGINAL_SOURCE_SYSTEM_ID NUMBER(38,0),
	SOURCE_SYSTEM_ID NUMBER(38,0),
	CONTRACT_KEY VARCHAR(32),
	CONTRACT_CODE VARCHAR(10),
	PARTNER_CODE VARCHAR(32),
	SERVICE_CODE VARCHAR(50),
	VISITS_SCHEDULED NUMBER(30,0),
	VISITS_COMPLETED NUMBER(30,0),
	VISITS_CANCELLED NUMBER(30,0),
	VISITS_IN_REVIEW NUMBER(30,0),
	VISITS_MISSED NUMBER(30,0),
	VISITS_RESCHEDULED NUMBER(30,0),
	FUTURE_VISITS NUMBER(30,0),
	FUTURE_CANCELLED_VISITS NUMBER(30,0),
	FUTURE_HOLD_VISITS NUMBER(30,0),
	HOURS_SCHEDULED NUMBER(30,2),
	HOURS_SERVED NUMBER(38,3),
	HOURS_CANCELLED NUMBER(30,2),
	HOURS_IN_REVIEW NUMBER(30,2),
	HOURS_MISSED NUMBER(30,2),
	HOURS_RESCHEDULED NUMBER(30,2),
	FUTURE_HOURS NUMBER(30,2),
	FUTURE_HOURS_NO_CAREGIVER NUMBER(30,2),
	FUTURE_CANCELLED_HOURS NUMBER(30,2),
	FUTURE_HOLD_HOURS NUMBER(30,2),
	HOURS_BILLED NUMBER(38,3),
	HOURS_AUTHORIZED NUMBER(38,12),
	HOURS_AUTHORIZED_NON_ADJUSTED NUMBER(38,12),
	UTILIZATION NUMBER(38,9),
	OVER_AUTHED NUMBER(1,0),
	OVER_AUTHED_ADJUSTED NUMBER(1,0),
	OVER_AUTHED_HOURS NUMBER(38,12),
	OVER_AUTHED_HOURS_ADJUSTED NUMBER(38,12),
	SERVED_WITHOUT_AUTH NUMBER(1,0),
	VISITS_ALL NUMBER(30,0),
	VISITS_CLEAN_SHIFTS NUMBER(30,0),
	VISITS_NEED_MAINTENANCE NUMBER(30,0),
	CLIENT_SERVED_FLAG BOOLEAN,
	ETL_TASK_KEY NUMBER(1,0),
	ETL_INSERTED_TASK_KEY NUMBER(1,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG NUMBER(1,0),
	ABSOLUTE_LAST_SERVICE_DATE DATE,
	NPS VARCHAR(16777216),
	PARTNER_CONTRACT_SERVICE_KEY VARCHAR(32)
);