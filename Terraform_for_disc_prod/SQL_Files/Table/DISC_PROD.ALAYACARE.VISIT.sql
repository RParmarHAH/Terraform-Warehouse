CREATE OR REPLACE TABLE DISC_PROD.ALAYACARE.VISIT (
	VISIT_ID NUMBER(38,0),
	SERVICE_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	IDACCOUNTTYPE NUMBER(38,0),
	EMPLOYEE_ID NUMBER(38,0),
	GUID NUMBER(38,0),
	BRANCH_ID NUMBER(38,0),
	SERVICE_CODE_ID VARIANT,
	CREATED_AT TIMESTAMP_NTZ(9),
	CREATED_BY NUMBER(38,0),
	UPDATED_AT TIMESTAMP_NTZ(9),
	UPDATED_BY NUMBER(38,0),
	START_AT TIMESTAMP_NTZ(9),
	END_AT TIMESTAMP_NTZ(9),
	FUNDER_LAST_UPDATE TIMESTAMP_NTZ(9),
	HOLIDAY_DATE DATE,
	VISIT_COMPUTED_RATE_UNITS VARCHAR(16777216),
	VISIT_COMPUTED_RATE_BILLITEM_ID NUMBER(38,0),
	VISIT_COMPUTED_RATE NUMBER(21,4),
	FACILITY_ID NUMBER(38,0),
	VISIT_COMPLETED NUMBER(1,0),
	PROPERTIES_TBL_SCHEDULER_ITEM_STATUS_REASON_ID VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_IDUSER VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_END_TIME_OFFSET VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_IDMASTERACCOUNT VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_LAST_VIEWED VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_HOURS_APPROVED VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_SERVICE_INSTRUCTIONS VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_LAST_WORK_SESSION_ID VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_END_TIME_APPROVED VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_FIRST_WORK_SESSION_ID VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_START_TIME_OFFSET VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_RATE_BILL VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_OP VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_HOURS_BILL VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_END_TIME VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_CANCELLED_CODE_ID VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_START_TIME VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_IS_LOCKED VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_SERVICE_CODE_ID VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_CREATE_TIME VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_CHECK_HASH VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_GUID VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_LAST_EMAILED VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_UPDATE_USER_ID VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_START_TIME_APPROVED VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_LAST_NOTIFICATION VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_MODIFIED_SINGLE VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_IDPOSITION VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_BREAK_MINUTES VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_IDDEPTCODE VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_SERVICE_RRULE_ID VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_UPDATE_TIME VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_USE_DEFAULT_DURATION VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_IDSTATUS VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_ID VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_LAST_ACCEPTED VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_DISPLAY_ID VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_CREATE_USER_ID VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_APPROVAL_STATUS VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_FUNDER_VALIDATION_BLOCK_ID VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_LAST_MODIFIED VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_HOURS_PAY VARCHAR(16777216),
	PROPERTIES_TBL_SCHEDULER_ITEM_CONFIRMED VARCHAR(16777216),
	IN_OUT_OF_RECURRENCE_STATUS VARCHAR(17),
	VISIT_RECURRENCE NUMBER(1,0),
	IS_INVOICED NUMBER(1,0),
	IS_PAID NUMBER(1,0),
	VISIT_IN_FACILITY NUMBER(38,0),
	VISIT_SEQUENCE_BY_CLIENT NUMBER(38,0),
	VISIT_SEQUENCE_BY_CLIENT_SERVICE NUMBER(38,0),
	ACCOUNT_TYPE NUMBER(38,0),
	CLIENT_VISIT_FACILITY NUMBER(38,0),
	VISIT_MARKED_FOR_RESUBMISSION NUMBER(38,0),
	VISIT_WRITTEN_OFF NUMBER(38,0),
	ADL_COMPLETE NUMBER(38,0),
	HAS_ADL NUMBER(38,0),
	HAS_NOTE NUMBER(38,0),
	VISIT_NOTE_COUNT NUMBER(38,0),
	BREAK_MINUTES NUMBER(13,2),
	BREAK_HOURS FLOAT,
	VISIT_APPROVAL_STATUS NUMBER(38,0),
	VISIT_HOURS_APPROVED NUMBER(13,2),
	VISIT_HOURS_BILL NUMBER(13,2),
	VISIT_BILL NUMBER(13,2),
	VISIT_SCHEDULED_DURATION NUMBER(13,2),
	VISIT_UNIT_QTY NUMBER(13,2),
	VISIT_REVENUE FLOAT,
	VISIT_REVENUE_BREAKTIME FLOAT,
	VISIT_MISSED_CLASS NUMBER(1,0),
	VISIT_BILL_DURATION NUMBER(13,2)
);