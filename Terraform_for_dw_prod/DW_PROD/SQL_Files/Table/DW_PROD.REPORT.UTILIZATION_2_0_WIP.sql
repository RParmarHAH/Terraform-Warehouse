CREATE OR REPLACE TABLE DW_PROD.REPORT.UTILIZATION_2_0_WIP (
	PERIOD_BEGIN_DATE DATE,
	STATE VARCHAR(2),
	TYPE VARCHAR(20),
	BRANCH_KEY VARCHAR(32),
	ORIGINAL_BRANCH_KEY VARCHAR(32),
	OFFICE_NUMBER NUMBER(38,0),
	OFFICE_NAME VARCHAR(100),
	SUPERVISOR_KEY VARCHAR(32),
	SUPERVISOR_CODE VARCHAR(100),
	ABSOLUTE_FIRST_SERVICE_DATE DATE,
	CLIENT_KEY VARCHAR(32),
	ORIGINAL_CLIENT_KEY VARCHAR(32),
	CLIENT_NUMBER VARCHAR(50),
	ORIGINAL_CLIENT_NUMBER VARCHAR(50),
	ORIGINAL_SOURCE_SYSTEM_ID NUMBER(38,3),
	SOURCE_SYSTEM_ID NUMBER(38,3),
	CONTRACT_KEY VARCHAR(32),
	CONTRACT_CODE VARCHAR(100),
	PARTNER_CODE VARCHAR(100),
	SERVICE_CODE VARCHAR(100),
	VISITS_SCHEDULED NUMBER(18,0),
	VISITS_COMPLETED NUMBER(18,0),
	VISITS_CANCELLED NUMBER(18,0),
	VISITS_IN_REVIEW NUMBER(18,0),
	VISITS_MISSED NUMBER(18,0),
	VISITS_RESCHEDULED NUMBER(18,0),
	FUTURE_VISITS NUMBER(18,0),
	FUTURE_CANCELLED_VISITS NUMBER(18,0),
	FUTURE_HOLD_VISITS NUMBER(18,0),
	HOURS_SCHEDULED NUMBER(18,2),
	HOURS_SERVED NUMBER(38,3),
	HOURS_CANCELLED NUMBER(18,2),
	HOURS_IN_REVIEW NUMBER(18,2),
	HOURS_MISSED NUMBER(18,2),
	HOURS_RESCHEDULED NUMBER(18,2),
	FUTURE_HOURS NUMBER(18,2),
	FUTURE_HOURS_NO_CAREGIVER NUMBER(18,2),
	FUTURE_CANCELLED_HOURS NUMBER(18,2),
	FUTURE_HOLD_HOURS NUMBER(18,2),
	HOURS_BILLED NUMBER(38,3),
	HOURS_AUTHORIZED NUMBER(38,3),
	HOURS_AUTHORIZED_NON_ADJUSTED NUMBER(38,3),
	UTILIZATION NUMBER(38,9),
	OVER_AUTHED NUMBER(1,0),
	OVER_AUTHED_ADJUSTED NUMBER(1,0),
	OVER_AUTHED_HOURS NUMBER(38,3),
	OVER_AUTHED_HOURS_ADJUSTED NUMBER(38,3),
	SERVED_WITHOUT_AUTH NUMBER(1,0),
	VISITS_ALL NUMBER(38,3),
	VISITS_CLEAN_SHIFTS NUMBER(38,3),
	VISITS_NEED_MAINTENANCE NUMBER(38,3),
	CLIENT_SERVED_FLAG BOOLEAN,
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN,
	ABSOLUTE_LAST_SERVICE_DATE DATE,
	NPS NUMBER(38,0),
	PARTNER_CONTRACT_SERVICE_KEY VARCHAR(32),
	VISITS_COMPLETED_VISIT_BASED NUMBER(18,0),
	VISITS_COMPLETED_TIME_BASED NUMBER(18,3),
	HOURS_SERVED_VISIT NUMBER(18,3),
	HOURS_SERVED_TIME_BASED NUMBER(18,3),
	AUTH_UNIT_TYPE VARCHAR(32),
	CONTRACT_NAME VARCHAR(100),
	SERVICE_NAME VARCHAR(100),
	PARTNER_NAME VARCHAR(100),
	AUTH_START_DATE DATE,
	AUTH_END_DATE DATE,
	NUMBER_OF_DAYS NUMBER(18,0)
);