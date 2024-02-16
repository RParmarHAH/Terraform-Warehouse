CREATE OR REPLACE TABLE DW_PROD.REPORT.HOURS_AND_CLIENT_CENSUS_MONTHLY (
	PERIOD_BEGIN_DATE DATE,
	PERIOD_NAME VARCHAR(16777216),
	TYPE VARCHAR(20),
	STATE VARCHAR(2),
	BRANCH_KEY VARCHAR(32),
	OFFICE_NUMBER NUMBER(38,0),
	OFFICE_NAME VARCHAR(100),
	SUPERVISOR_KEY VARCHAR(32),
	SUPERVISOR_CODE VARCHAR(100),
	ABSOLUTE_FIRST_SERVICE_DATE DATE,
	ABSOLUTE_LAST_SERVICE_DATE DATE,
	CLIENT_KEY_DATA VARCHAR(32),
	CLIENT_NUMBER VARCHAR(50),
	ORIGINAL_SOURCE_SYSTEM_ID NUMBER(38,3),
	SOURCE_SYSTEM_ID NUMBER(38,3),
	CONTRACT_KEY VARCHAR(32),
	PARTNER_CONTRACT_SERVICE_KEY VARCHAR(32),
	CONTRACT_CODE VARCHAR(100),
	SERVICE_CODE VARCHAR(100),
	PARTNER_CODE VARCHAR(100),
	CLIENT_KEY VARCHAR(16777216),
	HOURS_SCHEDULED NUMBER(18,2),
	HOURS_CANCELLED NUMBER(18,2),
	HOURS_IN_REVIEW NUMBER(18,2),
	HOURS_MISSED NUMBER(18,2),
	HOURS_RESCHEDULED NUMBER(18,2),
	FUTURE_HOURS NUMBER(18,2),
	FUTURE_HOURS_NO_CAREGIVER NUMBER(18,2),
	FUTURE_CANCELLED_HOURS NUMBER(18,2),
	FUTURE_HOLD_HOURS NUMBER(18,2),
	HOURS_SERVED_WHERE_AUTH_EXISTS NUMBER(38,3),
	HOURS_BILLED_WHERE_AUTH_EXISTS NUMBER(38,3),
	HOURS_AUTHORIZED_WHERE_AUTH_EXISTS NUMBER(38,3),
	NON_STANDARD_UNITS NUMBER(38,3),
	HOURS_SERVED_ALL NUMBER(38,3),
	HOURS_BILLED_ALL NUMBER(38,3),
	HOURS_AUTHORIZED_NON_ADJUSTED_ALL NUMBER(38,3),
	INCLUDE_FOR_CLIENTS BOOLEAN,
	INCLUDE_FOR_HOURS BOOLEAN,
	REVENUE_CATEGORY VARCHAR(16777216),
	VISITS_ALL NUMBER(38,3),
	VISITS_CLEAN_SHIFTS NUMBER(38,3),
	VISITS_NEED_MAINTENANCE NUMBER(38,3),
	VISITS_SCHEDULED NUMBER(18,0),
	VISITS_COMPLETED NUMBER(18,0),
	VISITS_CANCELLED NUMBER(18,0),
	VISITS_IN_REVIEW NUMBER(18,0),
	VISITS_MISSED NUMBER(18,0),
	VISITS_RESCHEDULED NUMBER(18,0),
	FUTURE_VISITS NUMBER(18,0),
	FUTURE_CANCELLED_VISITS NUMBER(18,0),
	FUTURE_HOLD_VISITS NUMBER(18,0),
	CLIENT_ACQUIRED_FLAG BOOLEAN,
	CLIENT_ACQUISITION_NAME VARCHAR(16777216),
	CLIENT_SERVED_FLAG BOOLEAN,
	NPS NUMBER(38,0),
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
	NUMBER_OF_DAYS NUMBER(18,0),
	HRS_OVER_OR_UNDER_SERVED NUMBER(38,3),
	VALID_AUTH VARCHAR(14),
	POTENTIAL_HRS NUMBER(38,3),
	POTENTIAL_HRS_SERVED_WHERE_AUTH_EXISTS NUMBER(38,3),
	POTENTIAL_HRS_OVER_OR_UNDER_SERVED NUMBER(38,3),
	POTENTIAL_OVER_OR_UNDER_DESC VARCHAR(12),
	HAS_FUTURE_HRS_NO_CAREGIVER VARCHAR(3),
	ACQUISITION_AS_OF_DATE BOOLEAN,
	ETL_TASK_KEY VARCHAR(2),
	ETL_INSERTED_TASK_KEY VARCHAR(2),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG NUMBER(1,0)
);